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

  Phase 5       Month 18--24      Interview     Engagement + Gamification
                                  Mastery       + AI Simulation

  Phase 6       Month 24--30      Marketplace   Marketplace + API +
                                  & Community   Community

  Phase 7       Month 30--36      Operational   Admin + Employer +
                                  Excellence    Notifications + Billing

  Phase 8       Month 36--42      Growth &      Analytics + CMS +
                                  Intelligence  Mobile + Integrations
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

-   Transform interview prep into the most comprehensive AI-powered interview training platform in India
-   Drive daily active usage through gamification and streaks
-   Increase Pro conversion via premium interview features
-   Build company-specific intelligence from community data

## Features

### 8.1 AI Interview Simulator

-   Conversational AI interviewer that asks follow-up questions based on user answers
-   Role-specific interview modes: System Design, DSA, Behavioral, HR
-   Company-specific interview styles (Google, Amazon, Microsoft, Flipkart, etc.)
-   Real-time feedback on answer quality, communication clarity, and technical depth
-   Post-interview scorecard with detailed breakdown and improvement suggestions

### 8.2 Interview Readiness Score

-   Aggregate score combining: lessons completed, mock interview performance, practice question accuracy, weak area coverage
-   "You are X% ready for [Company/Role]" widget on dashboard
-   Actionable recommendations to improve score (e.g., "Complete 2 more System Design lessons to reach 80%")
-   Score history graph tracking improvement over time

### 8.3 Daily Challenge & Streak System

-   One question per day (rotating: DSA, system design, behavioral)
-   Streak counter with visual fire/badge indicators
-   Gamification: badges for 7-day, 30-day, 100-day streaks
-   Weekly leaderboard among users at similar experience level
-   Push/email notifications to maintain streaks

### 8.4 Company-Specific Interview Packs

-   Curated prep paths for top 20 companies (MAANG, Flipkart, Razorpay, Swiggy, etc.)
-   Real interview questions sourced from community (Interview Experience data)
-   Company culture fit tips and common behavioral question patterns
-   Difficulty calibration per company (e.g., Google L4 vs Amazon SDE-2)
-   Success rate statistics per company from platform data

### 8.5 Spaced Repetition & Smart Revision

-   Track which questions users got wrong or struggled with
-   Automatically resurface weak topics at optimal intervals (SM-2 algorithm)
-   Daily "5-minute revision" mode with previously failed questions
-   Weakness heatmap showing topics that need more practice

### 8.6 Coding Playground

-   Embedded code editor within DSA lessons (Monaco editor)
-   Support for Python, JavaScript, Java, C++
-   AI evaluates code for correctness, time/space complexity, and code quality
-   Progressive hints system that reveals approach step-by-step
-   Test cases with expected vs actual output comparison

### 8.7 Peer Practice & Study Groups

-   Match users for live mock interview practice with each other
-   Peer feedback and rating system after each session
-   Study groups by target company or role
-   Leaderboard by category or overall score

### 8.8 Post-Interview Debrief AI

-   User logs what questions were asked in a real interview
-   AI analyzes: what went well, what to improve, model answers for questions they struggled with
-   Company-specific tips based on aggregated debrief data
-   Feeds back into personalized prep plan automatically

## Revenue Strategy

-   AI Interview Simulator: 3 free sessions/month, unlimited for Pro
-   Company-Specific Packs: ₹299 per pack or included in Pro
-   Coding Playground: Basic free, AI evaluation for Pro only
-   Peer Practice: Free matching, premium scheduling and recording for Pro
-   Daily Challenge: Free, but streak recovery (miss a day) costs ₹49 or Pro

## Phase 5 Metrics

-   Daily active user ratio > 30%
-   Average session duration > 15 minutes
-   70% of Pro users engage with interview prep weekly
-   50,000+ daily challenge attempts/month
-   Interview success rate improvement > 40% for active users

------------------------------------------------------------------------

# 9. Phase 6 Requirements (Month 24--30)

## Objectives

-   Launch recruitment marketplace connecting vetted candidates with employers
-   Monetize platform intelligence via public API for HR tech ecosystem
-   Build community-driven career growth features
-   Achieve Series A readiness with strong unit economics

## Features

### 9.1 Talent Marketplace

-   Employer Portal: Companies can post roles, search candidate profiles (anonymized until mutual interest)
-   Smart Matching: AI ranks candidates by skill fit, salary alignment, and career trajectory
-   Application Tracker: Candidates track applications, interviews, and offers in one place
-   Verified Skills Badges: AI-assessed skill badges from mock interviews and resume analysis displayed on profiles
-   Salary Transparency: Roles show verified salary ranges from crowdsourced data

### 9.2 Public API & Developer Platform

-   Salary Intelligence API: Role + city + experience → salary range (REST & GraphQL)
-   Skill Demand API: Real-time skill demand trends by market and role
-   Resume Parsing API: Upload resume → structured JSON (skills, experience, certifications)
-   API Key management dashboard with usage analytics and rate limiting
-   Tiered pricing: Free (100 calls/month), Starter (₹4,999/month), Enterprise (custom)

### 9.3 Community & Social Features

-   Career Growth Feed: Users share salary milestones, job switches, and learnings (anonymized)
-   Mentor Matching: Senior professionals opt-in to mentor juniors based on role and skill overlap
-   Company Reviews: Verified employee reviews on salary accuracy, growth opportunities, interview process
-   Discussion Forums: Role-specific Q&A boards (e.g., "Backend Engineers", "Data Analysts")

### 9.4 Advanced AI Features

-   Career Path Simulator: "What-if" scenarios (e.g., "If I learn Kubernetes + switch to Bangalore, my salary could be ₹X")
-   Salary Trajectory Forecasting: 3-year salary projection based on skill plan and market trends
-   AI Resume Builder: Generate ATS-optimized resumes from profile data with role-specific tailoring
-   Interview Debrief AI: Post-interview analysis — what went well, what to improve, company-specific tips

## Revenue Strategy

-   Talent Marketplace: ₹15,000--₹50,000 per successful hire (employer pays)
-   API Licensing: ₹4,999--₹49,999/month tiered plans
-   Premium Community: ₹199/month add-on for mentor access and exclusive content
-   Resume Builder: Included in Pro, ₹299 one-time for free users

## Phase 6 Metrics

-   1,00,000 users
-   10,000 subscribers
-   50+ employer accounts on marketplace
-   20+ API customers
-   ₹50L--₹1Cr MRR target
-   Series A fundraise readiness

------------------------------------------------------------------------

# 10. Phase 7 Requirements (Month 30--36)

## Objectives

-   Build operational infrastructure to run, monitor, and scale the platform
-   Launch dedicated Employer Portal to unlock marketplace hiring revenue
-   Implement notification engine to drive retention and re-engagement
-   Achieve billing compliance (GST invoices) and payment reliability
-   Establish content moderation to protect community trust and safety
-   Enable platform-wide search and discovery across 50+ feature surfaces

## Features

### 10.1 Admin Dashboard & Site Operations

-   **Admin role system** — Super admin, support agent, content moderator roles with scoped permissions
-   **User management** — Search, view, suspend, reactivate, impersonate users; view user activity timeline
-   **Revenue dashboard** — Real-time MRR, churn rate, ARPU, LTV, subscription analytics with date range filters
-   **Content moderation queue** — Flagged community posts, reviews, discussions with approve/remove/warn actions
-   **Feature usage analytics** — Heatmap of feature adoption, daily/weekly/monthly active users per feature
-   **System health monitor** — Background job queue depth, API response times, error rates, storage usage
-   **Audit logs** — Immutable log of admin actions, user-sensitive operations, payment events, data access

### 10.2 Notification Engine

-   **In-app notification center** — Bell icon with unread badge, categorized notification feed (career, community, system)
-   **Email notification system** — Transactional emails via SendGrid/Postmark:
    -   Welcome & onboarding sequence (Day 0, 1, 3, 7)
    -   Report ready / PDF generated
    -   Payment receipts & subscription confirmations
    -   Streak reminders ("Don't lose your 15-day streak!")
    -   Weekly career digest (new jobs, salary trends, community highlights)
    -   Re-engagement campaigns (inactive 7/14/30 days)
-   **Smart nudges** — Context-aware prompts:
    -   "3 new jobs match your profile"
    -   "Your readiness score improved 12% this week"
    -   "Someone replied to your discussion thread"
    -   "New company pack available: [Company]"
-   **Real-time delivery** — ActionCable channels for live notification push (infrastructure already configured)
-   **Notification preferences** — Per-category opt-in/opt-out settings on profile page

### 10.3 Employer Portal (Dedicated Experience)

-   **Employer registration** — Separate signup flow with company verification (domain-based email verification)
-   **Employer dashboard** — Active job postings, applicant pipeline, hiring analytics
-   **Candidate search** — Filter anonymized profiles by skills, experience, city, readiness score, salary expectations
-   **Applicant tracking pipeline** — Kanban board: Applied → Screening → Interview → Offer → Hired/Rejected
-   **Candidate reveal** — Unlock candidate identity on mutual interest (employer requests, candidate approves)
-   **Hiring analytics** — Time to hire, source quality, cost per hire, conversion rates per stage
-   **Employer branding** — Public company profile pages with reviews, interview tips, salary ranges
-   **Billing** — Per-hire fee (₹15,000--₹50,000) or monthly employer subscription (₹25,000--₹1,00,000)

### 10.4 Billing & Payment Infrastructure

-   **GST-compliant invoice generation** — Auto-generated for every payment with GSTIN, HSN codes, tax breakdowns
-   **Payment history page** — User-facing transaction history with download links for all invoices
-   **Dunning management** — Automated failed payment recovery:
    -   Day 0: Payment failed notification
    -   Day 3: Gentle reminder with retry link
    -   Day 7: Urgent notice, features start degrading
    -   Day 14: Subscription paused, data preserved
-   **Plan change flows** — Upgrade (immediate) / downgrade (end of cycle) with proration calculations
-   **Refund workflow** — Admin-initiated refunds with audit trail, automatic Razorpay refund API
-   **Revenue recognition** — Track recognized vs deferred revenue for accounting compliance

### 10.5 Search & Discovery

-   **Global search** — Unified search bar across jobs, discussions, company reviews, community posts, interview experiences, company packs, mentors
-   **Search infrastructure** — PostgreSQL full-text search with tsvector/tsquery (upgradeable to Elasticsearch later)
-   **Smart recommendations** — "People like you also..." based on role/city/skills collaborative filtering
-   **Trending content** — Most discussed threads, most liked posts, most applied jobs, trending skills
-   **Search analytics** — Track what users search for to identify content gaps and feature demand

### 10.6 Content Moderation & Trust

-   **Report/flag system** — Users can flag posts, reviews, discussions, job postings as spam/inappropriate/misleading
-   **Moderation queue** — Admin panel showing all flagged content with context, reporter info, and action buttons
-   **Auto-moderation** — AI-powered content screening for spam, profanity, fake reviews, misleading salary data
-   **Trust scores** — User reputation based on verified email, completed profile, contribution quality, account age
-   **Community guidelines** — Published guidelines with enforcement tiers (warn → mute → suspend → ban)
-   **Verified badges** — Verified employee badge for company reviews (email domain verification)

### 10.7 Data Compliance & Security

-   **GDPR/DPDP compliance** — Account deletion workflow (right to be forgotten), full data export (JSON/CSV download)
-   **Privacy controls** — Granular visibility settings: salary, profile, activity (public/connections/private)
-   **Sensitive data encryption** — Encrypt salary data, personal info at rest using Rails encrypted attributes
-   **Request rate limiting** — Rack::Attack middleware for DDoS protection and abuse prevention
-   **Session management** — View/revoke active sessions, force logout on password change
-   **Security audit log** — Login attempts, profile changes, payment actions, data exports

### 10.8 Performance & Reliability

-   **Caching layer** — Fragment caching for dashboard widgets, Russian doll caching for feeds, counter caches for counts
-   **Background job expansion** — Email delivery jobs, scheduled digest jobs, data cleanup jobs, webhook retry with exponential backoff
-   **Error tracking** — Sentry integration for production error monitoring with source maps
-   **Uptime monitoring** — Health check endpoints, external monitoring (UptimeRobot/Pingdom), alerting via Slack/PagerDuty
-   **Database optimization** — N+1 query detection, query analysis, connection pooling, read replicas preparation
-   **CDN for assets** — CloudFront/Cloudflare for static assets, uploaded files, and generated PDFs

## Revenue Strategy

-   Employer Portal subscriptions: ₹25,000--₹1,00,000/month per company
-   Per-hire fees: ₹15,000--₹50,000 per successful placement
-   Invoice/billing compliance unlocks enterprise sales (GST requirement)
-   Notification engine drives 20-30% improvement in retention → more renewals

## Phase 7 Metrics

-   Admin dashboard operational with <5 min incident response
-   50+ employer accounts onboarded
-   Email open rate > 25%, notification CTR > 8%
-   Content moderation response time < 4 hours
-   Invoice compliance: 100% of payments have GST-compliant invoices
-   Search usage: 30% of active users use global search weekly
-   GDPR compliance: Account deletion within 72 hours
-   Uptime: 99.9% availability

------------------------------------------------------------------------

# 11. Phase 8 Requirements (Month 36--42)

## Objectives

-   Build internal business intelligence for data-driven decision making
-   Reduce content management dependency on engineering deploys
-   Launch mobile presence to capture daily-use habits
-   Create integration ecosystem to embed into existing workflows
-   Achieve Series A metrics with defensible unit economics

## Features

### 11.1 Analytics & Business Intelligence Portal

-   **Cohort analysis** — Retention curves by signup month, acquisition channel, plan type
-   **Conversion funnels** — Signup → Onboarding → First Report → Subscription → Renewal with drop-off analysis
-   **Feature adoption matrix** — Which features drive retention vs. which are dead weight
-   **Revenue forecasting** — Predict MRR/ARR based on growth trends, churn patterns, seasonal effects
-   **User health scoring** — Composite score identifying at-risk users before they churn (activity, engagement, NPS)
-   **A/B testing infrastructure** — Feature flag system with experiment tracking and statistical significance
-   **Exportable reports** — PDF/CSV exports of all analytics for board meetings and investor updates

### 11.2 Content Management System

-   **Lesson editor** — Rich text editor for creating/editing interview prep content without code deploys
-   **Company pack builder** — Form-based tool to add new company interview packs with rounds, tips, questions
-   **Challenge scheduler** — Queue up daily challenges weeks in advance with difficulty balancing
-   **Skill trend importer** — Semi-automated data pipeline from job boards (Naukri, LinkedIn) to update trends
-   **Banner & announcement system** — Admin can publish site-wide banners, feature announcements, maintenance notices
-   **Content versioning** — Track changes to lessons, packs, and challenges with rollback capability

### 11.3 Mobile App (PWA → Native)

-   **Progressive Web App** — Add to home screen, offline access for cached content, push notifications
-   **Mobile-optimized flows** — Daily challenge, quick 5-min revision, notification center, community feed
-   **Native app wrapper** — React Native or Capacitor shell for Play Store/App Store presence
-   **Mobile-specific features** — Swipe-based daily challenges, voice-based mock interview practice
-   **Offline mode** — Cache lesson content, saved problems, study materials for offline access
-   **Deep linking** — Open specific pages from notifications, emails, and shared links

### 11.4 AI Personalization Engine

-   **Personalized dashboard** — Dynamically reorder dashboard sections based on user behavior patterns
-   **Smart onboarding paths** — Different journeys for "job seekers" vs "skill builders" vs "salary negotiators"
-   **Predictive career insights** — "Based on your trajectory, you should focus on [Skill] this month"
-   **Engagement scoring** — Predict optimal time/channel to send notifications per user
-   **Content recommendations** — "Users in your role found these resources most helpful"
-   **Adaptive difficulty** — Interview prep, challenges, and coding problems adjust to user skill level

### 11.5 Integration Ecosystem

-   **Outgoing webhooks** — Let employers/API users subscribe to events (new candidates, application updates)
-   **Zapier/Make integration** — Connect with 1000+ apps for workflow automation
-   **Calendar integration** — Sync peer practice sessions, mock interviews, study group meetings with Google/Outlook Calendar
-   **Slack/Teams bot** — Daily challenges in workspace channels, streak reminders, team leaderboards
-   **Job board syndication** — Auto-post marketplace jobs to external boards (LinkedIn Jobs, Naukri, Indeed)
-   **SSO for Enterprise** — SAML/OIDC single sign-on for enterprise HR dashboard customers

### 11.6 Advanced Marketplace Features

-   **Candidate matching algorithm** — ML-powered scoring: skill fit (40%), salary alignment (25%), career trajectory (20%), cultural fit (15%)
-   **Skill verification badges** — Auto-awarded from mock interview scores, coding playground results, peer ratings
-   **Employer analytics dashboard** — Talent pool insights: available candidates by skill/city, salary benchmarks, hiring velocity
-   **Referral hiring** — Employees can refer candidates through the platform with commission tracking
-   **Interview scheduling** — Integrated calendar booking between employer and candidate
-   **Offer management** — Employers create offers in-platform, candidates compare offers side-by-side

## Revenue Strategy

-   Analytics portal: Included for enterprise tier, drives enterprise upgrades
-   CMS: Internal efficiency gain (reduce engineering hours on content)
-   Mobile app: Drives daily engagement → higher retention → more renewals
-   Integration ecosystem: Stickiness multiplier, reduces churn
-   Advanced marketplace: Per-hire fee increase to ₹25,000--₹75,000 with matching quality

## Phase 8 Metrics

-   Mobile installs: 25,000+ (Play Store + PWA)
-   Daily active user ratio > 40%
-   Churn rate < 5% monthly
-   Enterprise clients: 25+
-   Employer accounts: 100+
-   Successful placements: 500+ (marketplace)
-   API customers: 50+
-   ARR: ₹2Cr+ (Series A ready)

------------------------------------------------------------------------

# 12. System Architecture

Frontend: - Rails 8 + Hotwire (Turbo + Stimulus) - TailwindCSS v4.2

Backend: - Ruby on Rails 8.0 - PostgreSQL (JSONB heavy usage) -
Solid Queue - Solid Cache - Solid Cable

AI Layer: - Google Gemini API (Structured JSON Output with Response Schemas)

Payments: - Razorpay (One-time + Subscription + Webhooks)

Storage: - AWS S3 (Private Buckets) - Active Storage

Auth: - Devise + Google OAuth2

Monitoring: - Sentry (Phase 7) - NewRelic (Phase 7) - Lograge

Deployment: - Kamal (Docker-based)

------------------------------------------------------------------------

# 13. Data & Security

-   OAuth-only authentication (Google)
-   Private S3 storage with signed URLs
-   Webhook signature validation (Razorpay)
-   Rails encrypted credentials
-   Rate limiting on AI endpoints
-   API key authentication for public APIs
-   GDPR/DPDP compliance workflows (Phase 7)
-   Sensitive data encryption at rest (Phase 7)
-   Rack::Attack request rate limiting (Phase 7)
-   Audit logging for sensitive operations (Phase 7)

------------------------------------------------------------------------

# 14. 42-Month Strategic Outcome

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

-   India's most comprehensive AI interview training system
-   Company-specific interview intelligence database
-   High daily engagement via gamification and streaks
-   Peer practice network creating organic growth
-   Coding assessment and evaluation engine

By end of Phase 6, platform additionally owns:

-   Two-sided talent marketplace with employer revenue
-   Public API platform with external developer adoption
-   Community-driven content and mentorship network
-   AI resume builder and career path simulation engine
-   Verified skills badge ecosystem trusted by employers

By end of Phase 7, platform additionally owns:

-   Production-grade operational infrastructure (admin, monitoring, alerting)
-   Dedicated employer portal with hiring pipeline and analytics
-   Notification engine driving measurable retention improvement
-   GST-compliant billing system enabling enterprise sales
-   Content moderation system protecting community trust
-   Platform-wide search enabling discovery across 50+ features
-   GDPR/DPDP compliance infrastructure for legal readiness

By end of Phase 8, platform additionally owns:

-   Internal BI portal for data-driven product and business decisions
-   Content management system eliminating engineering bottleneck for content
-   Mobile presence (PWA + native) capturing daily usage habits
-   AI personalization engine adapting experience to each user
-   Integration ecosystem (Zapier, Slack, Calendar, SSO) creating platform stickiness
-   ML-powered candidate matching making marketplace defensible

Positioned for:

-   Series A fundraising (₹5--10Cr target) with strong unit economics
-   Recruitment marketplace with ₹25K--75K per-hire revenue
-   API-as-a-product for HR tech ecosystem (50+ customers)
-   Integration partnerships with job portals (Naukri, LinkedIn, Indeed)
-   Enterprise sales motion with SSO, invoicing, and dedicated success
-   Potential acqui-hire interest from major HR tech players
-   Path to profitability within 6 months of Series A

------------------------------------------------------------------------

# 15. Phase 9 Requirements (Month 42--48) — Operational Hardening & Real-Time

## Objectives

-   Achieve production-grade observability and incident response
-   Enable real-time user experience via WebSocket notifications
-   Drive retention through automated re-engagement campaigns
-   Surface trending content and search intelligence

## Features

### 15.1 Monitoring & Infrastructure

-   **Error tracking** — Sentry integration for production error monitoring with source maps and alerting
-   **Health check dashboard** — Admin panel showing job queue depth, error rates, DB connection stats, storage usage
-   **ActionCable real-time notifications** — WebSocket channels for live notification push to connected users
-   **Session management** — User-facing page to view active sessions and revoke them
-   **CDN configuration** — CloudFront/Cloudflare for static assets, uploaded files, and generated PDFs

### 15.2 Re-engagement & Smart Nudges

-   **Re-engagement campaigns** — Automated email sequences for users inactive 7/14/30 days
-   **Context-aware smart nudges** — "3 new jobs match your profile", "Your readiness score improved 12%"
-   **Trending content aggregation** — Most liked posts, most discussed threads, most applied jobs, trending skills
-   **Search analytics** — Track search queries to identify content gaps and feature demand

## Phase 9 Metrics

-   Error detection MTTD < 5 minutes
-   Re-engagement email open rate > 20%
-   Real-time notification delivery < 2 seconds
-   Trending content engagement +15%

------------------------------------------------------------------------

# 16. Phase 10 Requirements (Month 48--54) — Employer Intelligence & Trust

## Objectives

-   Unlock employer revenue via hiring analytics and marketplace intelligence
-   Build automated trust and safety systems for community content
-   Enable privacy-first user controls for data visibility

## Features

### 16.1 Employer Analytics & Marketplace Depth

-   **Hiring analytics dashboard** — Time-to-hire, cost-per-hire, conversion rates per pipeline stage
-   **Employer talent pool insights** — Available candidates by skill/city, salary benchmarks, hiring velocity
-   **Interview scheduling** — Integrated calendar booking between employer and candidate
-   **Smart candidate matching** — ML-powered scoring: skill fit (40%), salary alignment (25%), career trajectory (20%), cultural fit (15%)
-   **Offer management** — Employers create offers in-platform, candidates compare offers side-by-side
-   **Referral hiring** — Employees refer candidates through platform with commission tracking

### 16.2 Trust, Moderation & Privacy

-   **AI auto-moderation** — Gemini-powered content screening for spam, profanity, fake reviews, misleading data
-   **User trust scores** — Composite score from profile completeness, contribution quality, account age, verified email
-   **Privacy controls** — Granular visibility settings for salary, profile, and activity (public/connections/private)
-   **Community guidelines enforcement** — Tiered system: warn → mute → suspend → ban with admin tooling
-   **Revenue recognition** — Track recognized vs deferred revenue for accounting compliance

## Phase 10 Metrics

-   50+ employer accounts with hiring analytics enabled
-   Auto-moderation catches 80% of flagged content before manual review
-   100% of users have default privacy settings applied
-   Trust score coverage: 90% of active users

------------------------------------------------------------------------

# 17. Phase 11 Requirements (Month 54--60) — Intelligence & Integrations

## Objectives

-   Build AI-driven personalization that adapts to each user's behavior
-   Create integration ecosystem for workflow stickiness
-   Reduce churn through predictive interventions

## Features

### 17.1 AI Personalization Engine

-   **User health scoring** — Churn risk prediction based on activity, engagement, and payment patterns
-   **Predictive career insights** — "Based on your trajectory, focus on [Skill] this month"
-   **Content recommendations** — "Users in your role found these resources most helpful"
-   **Adaptive difficulty** — Challenges, coding problems, and interview prep adjust to user skill level
-   **Engagement scoring** — Predict optimal time and channel to send notifications per user

### 17.2 External Integrations

-   **Calendar integration** — Google/Outlook Calendar sync for peer practice, mock interviews, study groups
-   **Slack/Teams bot** — Daily challenges in workspace channels, streak reminders, team leaderboards
-   **Job board syndication** — Auto-post marketplace jobs to LinkedIn Jobs, Naukri, Indeed
-   **Zapier/Make webhook triggers** — Standard webhook format for workflow automation with 1000+ apps
-   **SSO for Enterprise** — SAML/OIDC single sign-on for enterprise HR dashboard customers

## Phase 11 Metrics

-   Health score predicts churn with >70% accuracy
-   Calendar integration adoption: 20% of active users
-   Slack bot installed in 50+ workspaces
-   SSO enabled for 10+ enterprise clients

------------------------------------------------------------------------

# 18. Phase 12 Requirements (Month 60--66) — Polish & Scale Readiness

## Objectives

-   Build experimentation infrastructure for data-driven product decisions
-   Achieve content independence from engineering team
-   Prepare for Series A with polished reporting and mobile presence

## Features

### 18.1 Experimentation & Reporting

-   **A/B testing infrastructure** — Feature flag system with experiment tracking and statistical significance
-   **Exportable analytics reports** — PDF/CSV exports for board meetings and investor updates
-   **Revenue recognition** — Recognized vs deferred revenue tracking for accounting compliance

### 18.2 Content & Mobile Polish

-   **Content versioning** — Track changes to CMS content with diff view and rollback capability
-   **Skill trend importer** — Semi-automated pipeline from job boards (Naukri, LinkedIn) to update trends
-   **Deep linking** — Open specific pages from notifications, emails, and shared links
-   **Native app wrapper** — Capacitor shell for Play Store/App Store presence

## Phase 12 Metrics

-   3+ A/B tests running concurrently
-   Content team creates 100% of lessons without engineering
-   Play Store listing with 4+ star rating
-   Series A deck metrics fully automated from analytics portal

------------------------------------------------------------------------

# 19. Updated Strategic Outcome (66-Month Vision)

By end of Phase 12, platform additionally owns:

-   Production-grade observability with <5 min incident response
-   Real-time notification delivery via WebSockets
-   AI-powered trust and safety system protecting community
-   Predictive churn prevention saving 15-20% of at-risk users
-   Integration ecosystem (Slack, Calendar, Zapier, SSO) creating lock-in
-   ML-powered candidate matching making marketplace defensible
-   Experimentation culture with data-driven product decisions
-   Mobile presence on Play Store/App Store

------------------------------------------------------------------------

End of Master PRD
