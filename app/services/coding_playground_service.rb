class CodingPlaygroundService
  PROBLEMS = [
    { id: "two_sum", title: "Two Sum", difficulty: "easy", category: "Arrays",
      description: "Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.",
      examples: [{ input: "nums = [2,7,11,15], target = 9", output: "[0, 1]" }, { input: "nums = [3,2,4], target = 6", output: "[1, 2]" }],
      constraints: ["2 <= nums.length <= 10^4", "-10^9 <= nums[i] <= 10^9", "Only one valid answer exists"],
      hints: ["Try using a hash map for O(n) solution", "For each number, check if target - number exists in the map"] },
    { id: "reverse_linked_list", title: "Reverse Linked List", difficulty: "easy", category: "Linked Lists",
      description: "Given the head of a singly linked list, reverse the list, and return the reversed list.",
      examples: [{ input: "head = [1,2,3,4,5]", output: "[5,4,3,2,1]" }],
      constraints: ["The number of nodes: [0, 5000]", "-5000 <= Node.val <= 5000"],
      hints: ["Use three pointers: prev, current, next", "Iteratively reverse the links"] },
    { id: "valid_parentheses", title: "Valid Parentheses", difficulty: "easy", category: "Stacks",
      description: "Given a string s containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.",
      examples: [{ input: 's = "()"', output: "true" }, { input: 's = "()[]{}"', output: "true" }, { input: 's = "(]"', output: "false" }],
      constraints: ["1 <= s.length <= 10^4", "s consists of parentheses only"],
      hints: ["Use a stack data structure", "Push opening brackets, pop and compare for closing brackets"] },
    { id: "binary_search", title: "Binary Search", difficulty: "easy", category: "Searching",
      description: "Given a sorted array of integers nums and a target value, return the index if found. If not, return -1.",
      examples: [{ input: "nums = [-1,0,3,5,9,12], target = 9", output: "4" }, { input: "nums = [-1,0,3,5,9,12], target = 2", output: "-1" }],
      constraints: ["1 <= nums.length <= 10^4", "nums is sorted in ascending order"],
      hints: ["Use two pointers: left and right", "Compare mid element with target"] },
    { id: "lru_cache", title: "LRU Cache", difficulty: "medium", category: "Design",
      description: "Design a data structure that follows the constraints of a Least Recently Used (LRU) cache. Implement get and put operations in O(1) time.",
      examples: [{ input: "LRUCache(2), put(1,1), put(2,2), get(1), put(3,3), get(2)", output: "1, -1" }],
      constraints: ["1 <= capacity <= 3000", "0 <= key <= 10^4"],
      hints: ["Use a hash map + doubly linked list", "Hash map for O(1) lookup, linked list for O(1) removal"] },
    { id: "merge_intervals", title: "Merge Intervals", difficulty: "medium", category: "Arrays",
      description: "Given an array of intervals where intervals[i] = [start, end], merge all overlapping intervals.",
      examples: [{ input: "intervals = [[1,3],[2,6],[8,10],[15,18]]", output: "[[1,6],[8,10],[15,18]]" }],
      constraints: ["1 <= intervals.length <= 10^4"],
      hints: ["Sort intervals by start time first", "Compare current interval's start with previous interval's end"] }
  ].freeze

  def initialize(user)
    @user = user
  end

  def problems(difficulty: nil)
    result = PROBLEMS
    result = result.select { |p| p[:difficulty] == difficulty } if difficulty.present?
    result
  end

  def find_problem(problem_id)
    PROBLEMS.find { |p| p[:id] == problem_id }
  end

  def evaluate(problem_id, code, language)
    problem = find_problem(problem_id)
    return nil unless problem

    submission = @user.code_submissions.create!(
      language: language,
      code: code,
      problem_data: problem,
      status: :evaluating
    )

    prompt = GeminiPrompts.code_evaluation_prompt(problem, code, language)
    result = GeminiClient.new.generate(prompt, response_schema: evaluation_schema)

    if result
      submission.update!(
        test_results: result["test_results"] || [],
        ai_feedback: result,
        score: result["score"] || 0,
        status: :completed
      )
    else
      submission.update!(status: :failed, ai_feedback: { "error" => "Evaluation failed" })
    end

    submission
  rescue => e
    Rails.logger.error("Code evaluation failed: #{e.message}")
    submission&.update!(status: :failed)
    submission
  end

  def recent_submissions(limit = 10)
    @user.code_submissions.recent.limit(limit)
  end

  private

  def evaluation_schema
    {
      type: "OBJECT",
      properties: {
        score: { type: "INTEGER" },
        correctness: { type: "STRING" },
        time_complexity: { type: "STRING" },
        space_complexity: { type: "STRING" },
        code_quality: { type: "INTEGER" },
        strengths: { type: "ARRAY", items: { type: "STRING" } },
        improvements: { type: "ARRAY", items: { type: "STRING" } },
        test_results: { type: "ARRAY", items: { type: "OBJECT", properties: { test_case: { type: "STRING" }, passed: { type: "BOOLEAN" }, explanation: { type: "STRING" } } } },
        optimized_solution: { type: "STRING" },
        hints_for_improvement: { type: "ARRAY", items: { type: "STRING" } }
      }
    }
  end
end
