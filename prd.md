# Career Growth AI - Product Requirement Document (PRD)

## Version: 1.1 (MVP + Future Roadmap)
Platform: Web SaaS  
Primary Market: India  
Tech Stack: Ruby on Rails (Full Stack)  
Authentication: Google OAuth Only  

---

# 1. Product Overview

## Vision
To become the income acceleration platform for young Indian IT professionals by providing:
- Real salary benchmarking
- Skill ROI intelligence
- Structured 12-month growth roadmap
- Interview readiness scoring

Core Promise:
"Know your real market value and how to double your income."

---

# 2. Problem Statement

Indian IT professionals:
- Don’t know if they’re underpaid
- Choose skills randomly
- Switch jobs blindly
- Lack structured growth plan
- Waste 2–3 years at low compensation

---

# 3. Target Audience (MVP Scope)

Primary ICP:
- Age: 22–30
- Experience: 1–6 years
- Salary: ₹4–15 LPA
- Roles: Software Developers, QA Engineers, Data Analysts, DevOps Engineers

---

# 4. User Journey

1. Landing Page → “Check If You’re Underpaid”
2. Google OAuth Login
3. Onboarding Form (salary, city, role, experience)
4. Resume Upload (PDF/DOCX)
5. Free Analysis Preview
6. Payment (₹999 via Razorpay)
7. Full Career Blueprint + PDF Download

---

# 5. Functional Requirements

## Authentication
- Google OAuth only
- Automatic account creation
- Secure session management

## Resume Upload & Parsing
- Upload resume
- Extract structured data
- Background processing via Sidekiq
- Store parsed JSON in PostgreSQL (JSONB)

## Salary Benchmark Engine
expected_salary = median_salary  
underpaid_percentage = ((expected_salary - user_salary) / expected_salary) * 100

## Skill ROI Formula
skill_roi_score = (salary_uplift_index * demand_index) / learning_difficulty_index

## Interview Score Formula
interview_score =
(skill_match_percentage * 0.5) +
(experience_score * 0.3) +
(project_depth_score * 0.2)

## Payment Integration
- Razorpay
- One-time payment ₹999
- Webhook validation

---

# 6. Non-Functional Requirements

- Page load < 2 seconds
- Resume parsing < 30 seconds
- HTTPS only
- Secure storage
- Scalable to 10k users

---

# 7. MVP Timeline (8 Weeks)

Week 1: Google OAuth + DB setup  
Week 2: Salary Benchmark Engine  
Week 3–4: Resume Upload + Parsing  
Week 5: Skill Gap Analyzer  
Week 6: Roadmap Generator  
Week 7: Payment Integration  
Week 8: Testing + Beta Launch  

---

# 8. Future Roadmap

## Phase 2 (Months 3–6)
- Subscription model (₹499/month)
- AI Salary Negotiation Generator
- AI Mock Interview Simulator
- Resume ATS scoring
- Offer letter analyzer

## Phase 3 (Months 6–12)
- Salary crowdsourcing engine
- Peer benchmarking dashboard
- Skill demand analytics
- Referral growth loop

## Phase 4 (Year 2)
- LinkedIn integration
- Personalized job recommendations
- Enterprise HR analytics version
- AI Career Coach chatbot
- International expansion

---

End of PRD
