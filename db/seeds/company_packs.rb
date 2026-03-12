puts "Seeding company interview packs..."

packs = [
  {
    name: "Google",
    slug: "google",
    description: "Known for rigorous coding rounds and system design. Focuses on algorithmic thinking, scalability, and Googleyness (culture fit).",
    logo_icon: "search",
    difficulty_level: "hard",
    position: 1,
    interview_rounds: [
      { name: "Phone Screen", description: "45-min coding round with a Google engineer. Expect 1-2 medium/hard DSA problems.", duration: "45 min" },
      { name: "Coding Round 1", description: "On-site coding with focus on data structures, algorithms, and problem solving.", duration: "45 min" },
      { name: "Coding Round 2", description: "Advanced coding round with emphasis on optimization and edge cases.", duration: "45 min" },
      { name: "System Design", description: "Design a large-scale distributed system. Expected for L4+ roles.", duration: "45 min" },
      { name: "Behavioral (Googleyness)", description: "Culture fit assessment focusing on collaboration, ambiguity handling, and leadership.", duration: "30 min" }
    ],
    tips_data: [
      "Practice on LeetCode medium/hard problems daily for 2-3 months before applying",
      "Always discuss time and space complexity before and after coding",
      "For system design, start with requirements gathering and capacity estimation",
      "Show collaborative thinking — talk through your approach before coding",
      "Google values 'Googleyness' — demonstrate humility and willingness to learn"
    ],
    questions_data: [
      { question: "Design Google Search autocomplete", category: "System Design", tip: "Focus on trie data structure, ranking algorithms, and caching strategies", model_answer: "Use a distributed trie with frequency-based ranking. Cache top suggestions per prefix. Handle real-time updates with a streaming pipeline." },
      { question: "Given a stream of integers, find the median at any point", category: "DSA", tip: "Think about using two heaps — a max heap for the lower half and min heap for the upper half", model_answer: "Maintain two heaps: a max-heap for the lower half and a min-heap for the upper half. Balance them so sizes differ by at most 1. Median is either the top of the larger heap or average of both tops." },
      { question: "Tell me about a time you simplified a complex technical problem", category: "Behavioral", tip: "Use STAR method. Focus on YOUR specific contribution and the measurable impact.", model_answer: "Describe the complex situation, your analysis approach, the simplification you proposed, and the measurable outcome (reduced complexity, faster delivery, etc.)." },
      { question: "Design a distributed key-value store", category: "System Design", tip: "Cover consistency models (CAP theorem), partitioning, replication, and failure handling", model_answer: "Discuss consistent hashing for partitioning, quorum-based reads/writes for consistency, vector clocks for conflict resolution, and gossip protocol for failure detection." },
      { question: "Implement LRU Cache with O(1) get and put operations", category: "DSA", tip: "Combine a hash map with a doubly linked list", model_answer: "Use a hash map mapping keys to doubly-linked list nodes. The list maintains access order. On get/put, move the node to the head. On eviction, remove from the tail. Both operations are O(1)." }
    ]
  },
  {
    name: "Amazon",
    slug: "amazon",
    description: "Heavy focus on Leadership Principles (LPs). Every interview round includes LP-based behavioral questions alongside technical assessment.",
    logo_icon: "shopping_cart",
    difficulty_level: "hard",
    position: 2,
    interview_rounds: [
      { name: "Online Assessment", description: "2 coding problems (70 min) + work simulation assessment.", duration: "90 min" },
      { name: "Phone Screen", description: "1 coding problem + Leadership Principle questions.", duration: "60 min" },
      { name: "Loop Round 1 - Coding", description: "DSA problem solving with LP behavioral questions.", duration: "60 min" },
      { name: "Loop Round 2 - System Design", description: "System design (SDE-2+) with LP behavioral questions.", duration: "60 min" },
      { name: "Loop Round 3 - Bar Raiser", description: "The hardest round. A senior engineer from another team evaluates if you raise the bar.", duration: "60 min" }
    ],
    tips_data: [
      "Memorize all 16 Amazon Leadership Principles with 2-3 STAR stories for each",
      "Every answer should tie back to an LP — interviewers are trained to map your responses",
      "For the Bar Raiser round, prepare your most impactful stories with measurable outcomes",
      "Amazon loves data-driven decisions — quantify your impact wherever possible",
      "Practice the STAR method until it's second nature"
    ],
    questions_data: [
      { question: "Tell me about a time you had to make a decision with incomplete data", category: "Leadership Principle - Bias for Action", tip: "Show you can act decisively while managing risk", model_answer: "Describe a situation with ambiguity, the data you had vs needed, your decision framework, the action taken, and the outcome. Emphasize calculated risk-taking." },
      { question: "Design an e-commerce order management system", category: "System Design", tip: "Cover order lifecycle, inventory management, payment processing, and notification system", model_answer: "Discuss microservices architecture: order service, inventory service, payment gateway integration, event-driven notifications, and handling distributed transactions with saga pattern." },
      { question: "Tell me about a time you disagreed with your manager", category: "Leadership Principle - Have Backbone", tip: "Show you can disagree respectfully but commit once a decision is made", model_answer: "Use STAR: explain the disagreement context, how you presented your data-backed position, how you escalated appropriately, and whether you committed to the final decision even if it wasn't yours." },
      { question: "Find the kth largest element in an unsorted array", category: "DSA", tip: "Consider using quickselect algorithm for average O(n) time", model_answer: "Use quickselect (partition-based selection): pick a pivot, partition around it, recurse on the relevant half. Average O(n) time, O(1) space. Alternative: min-heap of size k for O(n log k)." },
      { question: "Tell me about your most significant technical achievement", category: "Leadership Principle - Deliver Results", tip: "Pick something with clear, measurable business impact", model_answer: "Choose a project with quantifiable impact. Describe the technical challenge, your approach, the implementation, and business results (revenue, efficiency gains, scale improvements)." }
    ]
  },
  {
    name: "Microsoft",
    slug: "microsoft",
    description: "Focus on coding fundamentals, system design, and growth mindset. Known for relatively balanced interviews with strong emphasis on problem-solving approach.",
    logo_icon: "window",
    difficulty_level: "medium",
    position: 3,
    interview_rounds: [
      { name: "Online Assessment", description: "2-3 coding problems on HackerRank/Codility.", duration: "60-90 min" },
      { name: "Phone Screen", description: "Coding round with a Microsoft engineer.", duration: "45 min" },
      { name: "On-site Round 1", description: "Data structures and algorithms focused.", duration: "45 min" },
      { name: "On-site Round 2", description: "System design or coding depending on level.", duration: "45 min" },
      { name: "Hiring Manager Round", description: "Behavioral and culture fit assessment.", duration: "30 min" }
    ],
    tips_data: [
      "Microsoft values growth mindset — show you're eager to learn and adapt",
      "Focus on clean, readable code rather than clever tricks",
      "For system design, emphasize scalability with Azure cloud services knowledge",
      "Be prepared to discuss trade-offs thoroughly for every design decision",
      "Show collaborative skills — Microsoft culture values teamwork heavily"
    ],
    questions_data: [
      { question: "Design a file synchronization service like OneDrive", category: "System Design", tip: "Focus on conflict resolution, chunked uploads, and delta sync", model_answer: "Discuss file chunking, content-addressable storage, delta sync for bandwidth efficiency, conflict resolution strategies, and real-time notifications via WebSocket." },
      { question: "Serialize and deserialize a binary tree", category: "DSA", tip: "Use preorder traversal with null markers", model_answer: "Serialize: preorder traversal, use a marker for null nodes. Deserialize: rebuild using a queue/iterator consuming values in preorder. Handle null markers to reconstruct structure. O(n) time and space." },
      { question: "Tell me about a time you received critical feedback", category: "Behavioral", tip: "Show growth mindset — how you internalized and acted on the feedback", model_answer: "Describe the feedback situation, your initial reaction, how you processed it constructively, specific changes you made, and the positive outcome that resulted." }
    ]
  },
  {
    name: "Flipkart",
    slug: "flipkart",
    description: "India's largest e-commerce company. Strong focus on machine coding, system design for Indian scale, and cultural fit.",
    logo_icon: "storefront",
    difficulty_level: "hard",
    position: 4,
    interview_rounds: [
      { name: "Machine Coding", description: "Build a working application in 90 minutes. Clean code, design patterns, and OOP principles matter.", duration: "90 min" },
      { name: "Problem Solving", description: "DSA round with focus on optimization and edge cases.", duration: "60 min" },
      { name: "System Design", description: "Design for Indian scale — payment systems, logistics, inventory.", duration: "60 min" },
      { name: "Hiring Manager", description: "Cultural fit, past experience, and leadership assessment.", duration: "45 min" }
    ],
    tips_data: [
      "Machine coding round is unique to Flipkart — practice building complete OOP solutions in 90 minutes",
      "Focus on SOLID principles and design patterns in the machine coding round",
      "For system design, understand Indian e-commerce challenges: payment failures, COD, logistics in tier-2/3 cities",
      "Flipkart values ownership and hustle — show examples of going beyond your role"
    ],
    questions_data: [
      { question: "Design a machine coding solution for a parking lot system", category: "Machine Coding", tip: "Focus on OOP design, extensibility, and clean code. Use strategy pattern for pricing.", model_answer: "Create Vehicle, ParkingSpot, ParkingLot, and PricingStrategy classes. Use factory pattern for vehicle types, strategy pattern for pricing (hourly, daily). Implement with proper encapsulation and SOLID principles." },
      { question: "Design Flipkart's order tracking system", category: "System Design", tip: "Consider real-time tracking, multiple logistics partners, and scale for sale events", model_answer: "Event-driven architecture with Kafka for order state transitions. Separate services for order management, logistics tracking, and notifications. Handle Big Billion Days scale with auto-scaling and circuit breakers." },
      { question: "Find all paths from root to leaf in a binary tree that sum to a target", category: "DSA", tip: "Use DFS with backtracking, maintaining a running sum and current path", model_answer: "DFS traversal maintaining current path and running sum. At each leaf, check if sum equals target. Backtrack by removing the current node from path after exploring both subtrees. O(n) time." }
    ]
  },
  {
    name: "Razorpay",
    slug: "razorpay",
    description: "Leading fintech company. Interviews focus on payment systems, distributed systems, and building reliable financial infrastructure.",
    logo_icon: "payments",
    difficulty_level: "medium",
    position: 5,
    interview_rounds: [
      { name: "Coding Round", description: "DSA and problem-solving with focus on correctness and edge cases.", duration: "60 min" },
      { name: "System Design", description: "Design payment/fintech systems with focus on reliability and consistency.", duration: "60 min" },
      { name: "Technical Deep Dive", description: "Deep dive into your past work, architecture decisions, and technical leadership.", duration: "45 min" },
      { name: "Culture Fit", description: "Values alignment and collaborative problem-solving.", duration: "30 min" }
    ],
    tips_data: [
      "Understand payment processing fundamentals — idempotency, reconciliation, settlement",
      "Razorpay values reliability — discuss how you handle failures and ensure data consistency",
      "For system design, focus on exactly-once processing and financial transaction integrity",
      "Show passion for building developer tools and APIs"
    ],
    questions_data: [
      { question: "Design a payment gateway that handles 10K TPS", category: "System Design", tip: "Focus on idempotency, retry mechanisms, and distributed transactions", model_answer: "Discuss idempotency keys, distributed transaction management (saga pattern), event sourcing for audit trails, circuit breakers for bank API failures, and reconciliation systems." },
      { question: "How would you design an API rate limiter?", category: "System Design", tip: "Consider token bucket or sliding window algorithms with Redis", model_answer: "Use token bucket algorithm with Redis for distributed rate limiting. Store tokens per API key with atomic operations. Handle burst traffic with sliding window counters. Return appropriate 429 responses with retry-after headers." }
    ]
  },
  {
    name: "Swiggy",
    slug: "swiggy",
    description: "India's leading food delivery platform. Interviews focus on real-time systems, location services, and handling high-throughput concurrent operations.",
    logo_icon: "restaurant",
    difficulty_level: "medium",
    position: 6,
    interview_rounds: [
      { name: "Coding Round 1", description: "DSA problem solving — arrays, trees, graphs.", duration: "60 min" },
      { name: "Coding Round 2", description: "Advanced DSA or low-level design.", duration: "60 min" },
      { name: "System Design", description: "Real-time systems — delivery tracking, order matching, surge pricing.", duration: "60 min" },
      { name: "Hiring Manager", description: "Behavioral and past experience evaluation.", duration: "45 min" }
    ],
    tips_data: [
      "Understand real-time location tracking and geospatial indexing (geohashing)",
      "Study how food delivery matching algorithms work (driver-order assignment)",
      "Focus on handling concurrent operations and race conditions",
      "Swiggy values speed of execution — show examples of shipping fast"
    ],
    questions_data: [
      { question: "Design Swiggy's real-time delivery tracking system", category: "System Design", tip: "Cover WebSocket connections, geohashing, and efficient location updates", model_answer: "Use geohashing for spatial indexing, WebSocket for real-time location push to customers, Kafka for location event streaming, and Redis for caching active delivery locations. Handle driver reconnection gracefully." },
      { question: "Design a surge pricing algorithm", category: "System Design", tip: "Consider supply-demand balance, zone-based pricing, and real-time computation", model_answer: "Calculate demand (orders) vs supply (available drivers) per geo-zone. Use a multiplier formula based on the ratio. Implement with time-windowed counters, zone-level Redis caches, and gradual price adjustment to avoid shocks." }
    ]
  }
]

packs.each do |pack_data|
  CompanyPack.find_or_create_by!(slug: pack_data[:slug]) do |pack|
    pack.assign_attributes(pack_data)
  end
  puts "  Created company pack: #{pack_data[:name]}"
end

puts "Company packs seeded! (#{CompanyPack.count} total)"
