# Review Writing Flow - User Dashboard

## Overview
This document explains the complete flow for users to write reviews in the Ayurveda Care Platform.

## Flow Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                    USER DASHBOARD                                │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │  Sidebar Navigation                                       │   │
│  │  └─ Account Section                                       │   │
│  │     └─ "My Reviews" (Click here)                         │   │
│  └──────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────────┐
│              MY REVIEWS PAGE                                    │
│  URL: /user/dashboard/reviews                                    │
│                                                                  │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │  Header with Action Buttons:                              │  │
│  │  • "Review Hospital" → /user/hospitals                    │  │
│  │  • "Review Product" → /user/products                       │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                  │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │  Tabs:                                                    │  │
│  │  • Hospital Reviews (shows existing hospital reviews)     │  │
│  │  • Product Reviews (shows existing product reviews)       │  │
│  └──────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────┘
                            │
                            ▼
        ┌───────────────────┴───────────────────┐
        │                                       │
        ▼                                       ▼
┌──────────────────────┐              ┌──────────────────────┐
│  HOSPITAL PAGE       │              │  PRODUCT PAGE         │
│  /user/hospitals     │              │  /user/products       │
│                      │              │                       │
│  User browses        │              │  User browses         │
│  hospitals and       │              │  products and         │
│  clicks on a         │              │  clicks on a          │
│  hospital            │              │  product              │
└──────────────────────┘              └──────────────────────┘
        │                                       │
        ▼                                       ▼
┌──────────────────────┐              ┌──────────────────────┐
│  HOSPITAL PROFILE    │              │  PRODUCT DETAILS      │
│  /hospitals/{id}      │              │  /products/{slug}    │
│                      │              │                       │
│  [Write Review]      │              │  [Write Review]       │
│  Button (to be added) │              │  Button (to be added) │
└──────────────────────┘              └──────────────────────┘
        │                                       │
        ▼                                       ▼
┌─────────────────────────────────────────────────────────────────┐
│              REVIEW FORM PAGE                                   │
│  URL: /user/review/submit?type={hospital|product}&id={id}      │
│                                                                  │
│  For Hospital Reviews:                                          │
│  • Overall Rating (1-5 stars)                                   │
│  • Review Text (required)                                        │
│  • Treatment Taken                                               │
│  • Treatment Rating                                              │
│  • Accommodation Rating                                          │
│  • Staff Rating                                                  │
│  • Food Rating                                                   │
│  • Value for Money Rating                                        │
│                                                                  │
│  For Product Reviews:                                           │
│  • Overall Rating (1-5 stars)                                   │
│  • Review Title                                                  │
│  • Review Comment (required)                                    │
│  • Pros (what you liked)                                        │
│  • Cons (what could be better)                                  │
│  • Recommend checkbox                                           │
│                                                                  │
│  [Submit Review] Button                                         │
└─────────────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────────┐
│              REVIEW SUBMITTED                                   │
│  POST /user/review/hospital/{id}                               │
│  POST /user/review/product/{id}                                │
│                                                                  │
│  • Review saved to database                                     │
│  • Status set to PENDING                                        │
│  • Success message displayed                                    │
│  • Redirect to /user/dashboard/reviews                           │
└─────────────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────────┐
│              MY REVIEWS PAGE (Updated)                           │
│  • New review appears in appropriate tab                         │
│  • Status shows as "Pending" or "Published"                     │
│  • User can see all their reviews                               │
└─────────────────────────────────────────────────────────────────┘
```

## Step-by-Step Instructions

### Method 1: From User Dashboard

1. **Login to User Dashboard**
   - Navigate to `/user/dashboard`
   - User must be logged in

2. **Navigate to Reviews Section**
   - In the sidebar, go to **Account** section
   - Click on **"My Reviews"**
   - URL: `/user/dashboard/reviews`

3. **Choose Review Type**
   - Click **"Review Hospital"** button → Goes to `/user/hospitals`
   - OR
   - Click **"Review Product"** button → Goes to `/user/products`

4. **Select Item to Review**
   - Browse hospitals or products
   - Click on the hospital/product you want to review
   - On the detail page, click **"Write Review"** button (to be added)

5. **Fill Review Form**
   - Form loads at `/user/review/submit?type={type}&id={id}`
   - Fill in all required fields
   - Add ratings and comments
   - Click **"Submit Review"**

6. **Review Submitted**
   - Success message displayed
   - Redirected back to `/user/dashboard/reviews`
   - Review appears in appropriate tab with "Pending" status

### Method 2: Direct from Hospital/Product Page

1. **Browse Hospital/Product**
   - Navigate to hospital profile: `/hospitals/{id}`
   - OR product details: `/products/{slug}`

2. **Click Write Review**
   - Find **"Write Review"** button on the page
   - Click to open review form

3. **Submit Review**
   - Fill form and submit
   - Review saved and user redirected to reviews dashboard

## Current Implementation Status

### ✅ Completed
- [x] User dashboard reviews page (`/user/dashboard/reviews`)
- [x] Review form page (`/user/review/submit`)
- [x] Review submission endpoints (POST)
- [x] Navigation link in user dashboard sidebar
- [x] Display existing reviews in dashboard
- [x] Tabbed interface for Hospital/Product reviews

### ⚠️ To Be Added
- [ ] "Write Review" button on hospital profile page
- [ ] "Write Review" button on product details page
- [ ] Check if user already reviewed (show "Edit Review" instead)
- [ ] Direct links from orders to review products
- [ ] Direct links from bookings to review hospitals

## URLs Reference

| Page | URL | Method |
|------|-----|--------|
| My Reviews Dashboard | `/user/dashboard/reviews` | GET |
| Review Form | `/user/review/submit?type={type}&id={id}` | GET |
| Submit Hospital Review | `/user/review/hospital/{hospitalId}` | POST |
| Submit Product Review | `/user/review/product/{productId}` | POST |

## Review Status Flow

1. **PENDING** - Review submitted, awaiting moderation
2. **APPROVED** - Review approved and visible to public
3. **REJECTED** - Review rejected (not visible)

## Notes

- Users can only submit one review per hospital/product
- Reviews are moderated before being published
- Hospital reviews can include detailed sub-ratings
- Product reviews can include pros/cons and recommendation
- All reviews are linked to the user's account

