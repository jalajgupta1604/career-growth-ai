# Career Growth AI - Product Requirement Document (PRD)

## Version: 1.0 (MVP)

Platform: Web SaaS\
Primary Market: India\
Tech Stack: Ruby on Rails (Full Stack)\
Authentication: Google OAuth Only

------------------------------------------------------------------------

# 1. Product Overview

## Vision

To become the income acceleration platform for young Indian IT
professionals by providing: - Real salary benchmarking - Skill ROI
intelligence - Structured 12-month growth roadmap - Interview readiness
scoring

Core Promise: "Know your real market value and how to double your
income."

------------------------------------------------------------------------

# 2. Problem Statement

Indian IT professionals: - Don't know if they're underpaid - Choose
skills randomly - Switch jobs blindly - Lack structured growth plan -
Waste 2--3 years at low compensation

Existing tools do not provide personalized salary intelligence or
ROI-based career planning.

------------------------------------------------------------------------

# 3. Target Audience (MVP Scope)

Primary ICP: - Age: 22--30 - Experience: 1--6 years - Salary: ₹4--15
LPA - Roles: Software Developers, QA Engineers, Data Analysts, DevOps
Engineers

------------------------------------------------------------------------

# 4. User Journey

1.  Landing Page → "Check If You're Underpaid"
2.  Google OAuth Login
3.  Onboarding Form (salary, city, role, experience)
4.  Resume Upload (PDF/DOCX)
5.  Free Analysis Preview
6.  Payment (₹999 via Razorpay)
7.  Full Career Blueprint + PDF Download

------------------------------------------------------------------------

# 5. Functional Requirements

## 5.1 Authentication

-   Google OAuth only
-   Automatic account creation
-   Secure session management

### Users Table

-   id
-   email
-   full_name
-   google_uid
-   profile_picture_url
-   created_at
-   updated_at

------------------------------------------------------------------------

## 5.2 Resume Upload & Parsing

-   Upload resume
-   Extract structured data (experience, skills, projects)
-   Background processing via Sidekiq
-   Store parsed JSON in PostgreSQL (JSONB)

### Resumes Table

-   id
-   user_id
-   file_url
-   parsed_data (JSONB)
-   parsing_status

------------------------------------------------------------------------

## 5.3 Salary Benchmark Engine

### salary_benchmarks Table

-   role
-   city
-   experience_range
-   min_salary
-   median_salary
-   max_salary
-   company_type

### Calculation

expected_salary = median_salary\
underpaid_percentage = ((expected_salary - user_salary) /
expected_salary) \* 100

------------------------------------------------------------------------

## 5.4 Skill Gap Analyzer

### skills Table

-   name
-   category
-   demand_index
-   salary_uplift_index
-   learning_difficulty_index

### role_skill_mapping Table

-   role
-   skill_id
-   importance_weight

### Skill ROI Formula

skill_roi_score = (salary_uplift_index \* demand_index) /
learning_difficulty_index

------------------------------------------------------------------------

## 5.5 Interview Probability Score

interview_score = (skill_match_percentage \* 0.5) + (experience_score \*
0.3) + (project_depth_score \* 0.2)

Output: 0--100 scale

------------------------------------------------------------------------

## 5.6 Career Roadmap Generator

-   12-month structured roadmap
-   Skill learning timeline
-   Certifications
-   Project recommendations
-   Expected salary after switch

Stored in:

### career_reports Table

-   id
-   user_id
-   salary_gap_percentage
-   skill_gap_data (JSONB)
-   roadmap_data (JSONB)
-   interview_score
-   payment_status
-   pdf_url
-   created_at

------------------------------------------------------------------------

## 5.7 Payment Integration

-   Razorpay
-   One-time payment ₹999
-   Webhook validation

------------------------------------------------------------------------

## 5.8 PDF Generation

-   Generate downloadable report
-   Include salary analysis, skill ranking, roadmap, and projections
-   Background job processing

------------------------------------------------------------------------

# 6. Non-Functional Requirements

-   Page load \< 2 seconds
-   Resume parsing \< 30 seconds
-   HTTPS only
-   Secure S3 storage
-   Scalable to 10k users
-   OAuth-only authentication

------------------------------------------------------------------------

# 7. System Architecture

Frontend: - Rails 7 + Hotwire - TailwindCSS

Backend: - Ruby on Rails - PostgreSQL - Redis - Sidekiq

AI Layer: - External LLM API (Structured JSON output)

Storage: - AWS S3 (Private bucket)

Deployment: - Render / Fly.io / AWS EC2

Monitoring: - Sentry - Lograge - NewRelic

------------------------------------------------------------------------

# 8. Analytics

Track: - Login conversion rate - Resume upload rate - Free → paid
conversion - Skill demand trends - Underpayment distribution

Tool: PostHog or Mixpanel

------------------------------------------------------------------------

# 9. MVP Timeline (8 Weeks)

Week 1: Google OAuth + DB setup\
Week 2: Salary Benchmark Engine\
Week 3--4: Resume Upload + Parsing\
Week 5: Skill Gap Analyzer\
Week 6: Roadmap Generator\
Week 7: Payment Integration\
Week 8: Testing + Beta Launch

------------------------------------------------------------------------

# 10. Success Metrics

-   1,000 users
-   100 paid users
-   ₹1L+ revenue
-   10--15% conversion rate
-   \<5% refund rate

------------------------------------------------------------------------

End of PRD
