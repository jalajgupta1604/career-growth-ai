# Career Growth AI - Master Product Requirement Document (Master PRD)

## Version: 1.0

Platform: Web SaaS\
Tech Stack: Ruby on Rails\
Authentication: Google OAuth Only\
Primary Market: India (IT Professionals)

------------------------------------------------------------------------

# 1. Product Vision

To become India's leading Salary Intelligence & Career Acceleration
Platform by helping professionals:

-   Discover their true market salary
-   Identify highest ROI skills
-   Improve interview success probability
-   Optimize job offers & negotiations
-   Benchmark against peers

Core Promise:

"Know your market value. Accelerate your income."

------------------------------------------------------------------------

# 2. Target Audience

Primary ICP (MVP Focus):

-   Age: 22--30
-   Experience: 1--6 years
-   Salary: ₹4--15 LPA
-   Roles: Software Developer, QA Engineer, Data Analyst, DevOps
    Engineer

Future Expansion: - Product Managers - Designers - Tier-2/3
professionals

------------------------------------------------------------------------

# 3. Product Roadmap Overview

  -----------------------------------------------------------------------
  Stage         Timeline          Focus         Revenue Model
  ------------- ----------------- ------------- -------------------------
  MVP           Month 0--2        Validation    ₹999 one-time

  Phase 2       Month 3--6        Revenue       Subscription + Upsells
                                  Expansion

  Phase 3       Month 6--12       Data Network  Recurring + Intelligence
                                  Effects

  Phase 4       Month 12--18      AI-Powered    Enterprise + B2B + API
                                  Scale

  Phase 5       Month 18--24      Marketplace   Marketplace + API +
                                  & Community   Community
  -----------------------------------------------------------------------

------------------------------------------------------------------------

# 4. MVP Requirements (Month 0--2)

## Objectives

-   Validate problem-solution fit
-   Validate willingness to pay
-   Generate first revenue
-   Start collecting salary data

## Core Features

-   Google OAuth login
-   Salary Benchmark Engine
-   Resume Upload & Parsing
-   Skill Gap Analyzer
-   Interview Probability Score
-   12-Month Career Roadmap Generator
-   Razorpay One-Time Payment
-   PDF Report Generation

## Key Formulae

Underpayment Percentage: ((median_salary - user_salary) / median_salary)
\* 100

Skill ROI: (skill_uplift \* demand_index) / difficulty_index

Interview Score: (skill_match \* 0.5) + (experience_score \* 0.3) +
(project_score \* 0.2)

## MVP Success Metrics

-   1,000 users
-   100 paid users
-   ₹1L+ revenue
-   10--15% conversion rate

------------------------------------------------------------------------

# 5. Phase 2 Requirements (Month 3--6)

## Objectives

-   Increase ARPU
-   Improve retention
-   Introduce recurring revenue

## Features

-   Subscription Model (₹499/month)
-   Monthly Salary Re-evaluation
-   AI Salary Negotiation Tool
-   AI Mock Interview (Text-based)
-   Resume ATS Scoring Engine
-   Offer Letter Analyzer

## Revenue Strategy

-   Subscription ₹499/month
-   Negotiation Tool ₹299/use
-   Mock Interview ₹499/session

## Phase 2 Metrics

-   20% paid users → subscription
-   ARPU \> ₹2,500
-   ₹5--10L MRR target

------------------------------------------------------------------------

# 6. Phase 3 Requirements (Month 6--12)

## Objectives

-   Build defensible data moat
-   Create network effects
-   Increase retention beyond 4 months

## Features

-   Salary Crowdsourcing Engine
-   Peer Benchmark Dashboard
-   Skill Demand Trend Engine
-   Interview Experience Clustering
-   Referral Growth System

## Strategic Positioning

Career Tool → Salary Intelligence Platform

## Phase 3 Metrics

-   10,000 users
-   2,000 subscribers
-   ₹10L--₹20L MRR potential

------------------------------------------------------------------------

# 7. Phase 4 Requirements (Month 12--18)

## Objectives

-   Deepen user engagement with AI-first experiences
-   Unlock B2B revenue via enterprise HR analytics
-   Leverage LinkedIn data for personalized recommendations
-   Increase retention and daily active usage

## Features

-   LinkedIn Integration (profile import, skill sync, connection insights)
-   Personalized Job Recommendations (AI-matched jobs based on skills, salary, and career goals)
-   Enterprise HR Analytics Version (company dashboard, team benchmarking, hiring intelligence)
-   AI Career Coach Chatbot (conversational career guidance, goal tracking, proactive nudges)

## Revenue Strategy

-   Enterprise HR Dashboard ₹25,000--₹1,00,000/month per company
-   Premium Job Recommendations ₹199/month add-on
-   AI Career Coach unlimited access included in Pro
-   B2B API licensing for recruitment platforms

## Phase 4 Metrics

-   50,000 users
-   5,000 subscribers
-   10+ enterprise clients
-   ₹30L--₹50L MRR target
-   Daily active user ratio > 25%

------------------------------------------------------------------------

# 8. Phase 5 Requirements (Month 18--24)

## Objectives

-   Launch recruitment marketplace connecting vetted candidates with employers
-   Monetize platform intelligence via public API for HR tech ecosystem
-   Expand to Southeast Asia (starting with Singapore, UAE)
-   Build community-driven career growth features
-   Achieve Series A readiness with strong unit economics

## Features

### 8.1 Talent Marketplace

-   Employer Portal: Companies can post roles, search candidate profiles (anonymized until mutual interest)
-   Smart Matching: AI ranks candidates by skill fit, salary alignment, and career trajectory
-   Application Tracker: Candidates track applications, interviews, and offers in one place
-   Verified Skills Badges: AI-assessed skill badges from mock interviews and resume analysis displayed on profiles
-   Salary Transparency: Roles show verified salary ranges from crowdsourced data

### 8.2 Public API & Developer Platform

-   Salary Intelligence API: Role + city + experience → salary range (REST & GraphQL)
-   Skill Demand API: Real-time skill demand trends by market and role
-   Resume Parsing API: Upload resume → structured JSON (skills, experience, certifications)
-   API Key management dashboard with usage analytics and rate limiting
-   Tiered pricing: Free (100 calls/month), Starter (₹4,999/month), Enterprise (custom)

### 8.3 Community & Social Features

-   Career Growth Feed: Users share salary milestones, job switches, and learnings (anonymized)
-   Mentor Matching: Senior professionals opt-in to mentor juniors based on role and skill overlap
-   Company Reviews: Verified employee reviews on salary accuracy, growth opportunities, interview process
-   Discussion Forums: Role-specific Q&A boards (e.g., "Backend Engineers", "Data Analysts")

### 8.4 Advanced AI Features

-   Career Path Simulator: "What-if" scenarios (e.g., "If I learn Kubernetes + switch to Bangalore, my salary could be ₹X")
-   Salary Trajectory Forecasting: 3-year salary projection based on skill plan and market trends
-   AI Resume Builder: Generate ATS-optimized resumes from profile data with role-specific tailoring
-   Interview Debrief AI: Post-interview analysis — what went well, what to improve, company-specific tips

## Revenue Strategy

-   Talent Marketplace: ₹15,000--₹50,000 per successful hire (employer pays)
-   API Licensing: ₹4,999--₹49,999/month tiered plans
-   Premium Community: ₹199/month add-on for mentor access and exclusive content
-   Resume Builder: Included in Pro, ₹299 one-time for free users

## Phase 5 Metrics

-   1,00,000 users
-   10,000 subscribers
-   50+ employer accounts on marketplace
-   20+ API customers
-   ₹50L--₹1Cr MRR target
-   Series A fundraise readiness

------------------------------------------------------------------------

# 9. System Architecture

Frontend: - Rails 7 + Hotwire - TailwindCSS

Backend: - Ruby on Rails - PostgreSQL (JSONB heavy usage) - Redis -
Sidekiq

AI Layer: - External LLM API (Structured JSON Output)

Payments: - Razorpay (One-time + Subscription)

Storage: - AWS S3 (Private Buckets)

Monitoring: - Sentry - NewRelic - Lograge

------------------------------------------------------------------------

# 10. Data & Security

-   OAuth-only authentication
-   Private S3 storage
-   Signed URLs for file access
-   Webhook validation
-   Encrypted credentials
-   Rate limiting on AI endpoints

------------------------------------------------------------------------

# 11. 24-Month Strategic Outcome

By end of Phase 3, platform owns:

-   Skill → Salary mapping dataset
-   Negotiation success database
-   Interview difficulty index
-   Salary trend analytics engine
-   Crowdsourced benchmarking intelligence

By end of Phase 4, platform additionally owns:

-   LinkedIn-enriched professional profiles
-   AI-powered job matching engine
-   Enterprise HR intelligence dashboard
-   Conversational AI career coaching system
-   B2B client base with recurring enterprise revenue

By end of Phase 5, platform additionally owns:

-   Two-sided talent marketplace with employer revenue
-   Public API platform with external developer adoption
-   Community-driven content and mentorship network
-   AI resume builder and career path simulation engine
-   Verified skills badge ecosystem trusted by employers

Positioned for:

-   Series A fundraising (₹5--10Cr target)
-   Recruitment marketplace with hiring fee revenue
-   API-as-a-product for HR tech ecosystem
-   Strategic partnerships with job portals (Naukri, LinkedIn, Indeed)
-   Potential acqui-hire interest from major HR tech players

------------------------------------------------------------------------

End of Master PRD
