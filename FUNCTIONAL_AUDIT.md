# MindSparQ OS — Complete Functional Audit

> **Document Type**: Comprehensive Forensic Engineering Audit  
> **Date**: September 1, 2026  
> **Repository**: `MindSparQ-OS`  
> **Visual Reference**: Google Stitch (Project `13746084714856879502`)  
> **Scope**: Screen-by-Screen & Component-by-Component Functional Inventory

---

## Executive Summary

MindSparQ OS features a high-fidelity visual foundation strictly adhering to the Google Stitch Design System, with responsive layouts, tokenized themes, and clean architecture primitives.

However, an exhaustive audit reveals that while **Navigation Shell**, **Authentication UI**, **Dashboard Cockpit**, and the **Teachers Module** have operational data/state plumbing, **Schools**, **Attendance/Gate**, **Finance**, **Inventory**, **Emergency**, and **Settings** currently function primarily as presentation templates with placeholder callbacks (`onPressed: () {}`) and unlinked backend data pipelines.

---

## Audit Methodology & Criteria

Every interactive element is evaluated across **13 rigorous dimensions**:
1. **Current UI**: Component type and visual representation.
2. **Current Action**: Actual runtime handler/callback behavior.
3. **Navigation**: Does the element trigger active routing (`GoRouter`)?
4. **Business Logic**: Does application domain logic execute?
5. **Backend Integration**: Is there an active API/Supabase communication?
6. **State Management**: Is state managed via Riverpod (`StateNotifier`, `FutureProvider`, etc.)?
7. **Validation**: Is input sanitization, form validation, or constraint enforcement present?
8. **Error Handling**: Are network/timeout/parsing errors caught and presented gracefully?
9. **Loading State**: Are skeleton cards, spinners, or disable states displayed during async work?
10. **Empty State**: Are zero-data conditions handled with `AppEmptyState`?
11. **Permissions / Security**: Are role-based permissions or sensitive data masks enforced?
12. **Persistence**: Does the action persist changes to remote or local storage?
13. **Production Ready**: Is this feature ready for end-user deployment? (YES / NO / PARTIAL)

---

## Screen-by-Screen & Component-by-Component Audit

### 1. Application Shell & Global Navigation (`ShellScreen`, `DesktopNavSidebar`, `MobileBottomNav`, `AppHeader`)

#### 1.1 Desktop Navigation Sidebar (`DesktopNavSidebar`)
* **Component: Quick Action Button `"नयाँ विद्यालय (New School)"`**
  1. *Current UI*: `AppButton` (Primary Blue, Full Width, `Icons.add`).
  2. *Current Action*: `context.go(RouteConstants.schools)`.
  3. *Navigation*: **YES** (Navigates to `/schools`).
  4. *Business Logic*: **NO** (Only switches tab; does not open creation dialog).
  5. *Backend Integration*: **NO**.
  6. *State Management*: **NO**.
  7. *Validation*: **N/A**.
  8. *Error Handling*: **N/A**.
  9. *Loading State*: **NO**.
  10. *Empty State*: **N/A**.
  11. *Permissions/Security*: **NO** (Visible to all users, even read-only viewers).
  12. *Persistence*: **N/A**.
  13. *Production Ready*: **PARTIAL** (Navigates, but create dialog missing).

* **Components: 8 Navigation Menu Items (Dashboard, Schools, Teachers, Attendance, Finance, Inventory, Emergency, Settings)**
  1. *Current UI*: Custom `InkWell` with bilingual labels (`titleNe (titleEn)`), active indicator pill.
  2. *Current Action*: `context.go(item.route)`.
  3. *Navigation*: **YES** (All 8 routes mapped and navigate).
  4. *Business Logic*: **YES** (Maintains active tab styling based on route).
  5. *Backend Integration*: **N/A**.
  6. *State Management*: **YES** (GoRouter state listener).
  7. *Validation*: **N/A**.
  8. *Error Handling*: **YES** (GoRouter fallback route).
  9. *Loading State*: **N/A**.
  10. *Empty State*: **N/A**.
  11. *Permissions/Security*: **NO** (All roles see all tabs; no menu hiding for viewers/teachers).
  12. *Persistence*: **YES** (URL path persisted in browser history).
  13. *Production Ready*: **YES** (Navigation functions correctly).

* **Component: Footer Link `"सहयोग (Help)"`**
  1. *Current UI*: Icon `help_outline` with text.
  2. *Current Action*: Non-clickable static `Row`.
  3. *Navigation*: **NO**.
  4. *Business Logic*: **NO**.
  5. *Backend Integration*: **NO**.
  6. *State Management*: **NO**.
  7. *Validation*: **N/A**.
  8. *Error Handling*: **N/A**.
  9. *Loading State*: **N/A**.
  10. *Empty State*: **N/A**.
  11. *Permissions/Security*: **NO**.
  12. *Persistence*: **NO**.
  13. *Production Ready*: **NO**.

#### 1.2 Mobile Navigation Dock (`MobileBottomNav`)
* **Components: 4 Bottom Navigation Tabs (Dashboard, Schools, Attendance, Settings)**
  1. *Current UI*: Bottom bar with icons, labels, and active color indicators.
  2. *Current Action*: `context.go(item.route)`.
  3. *Navigation*: **YES**.
  4. *Business Logic*: **YES** (Active state highlights).
  5. *Backend Integration*: **N/A**.
  6. *State Management*: **YES**.
  7. *Validation*: **N/A**.
  8. *Error Handling*: **N/A**.
  9. *Loading State*: **N/A**.
  10. *Empty State*: **N/A**.
  11. *Permissions/Security*: **NO**.
  12. *Persistence*: **YES**.
  13. *Production Ready*: **YES**.

#### 1.3 Global Header Bar (`AppHeader`)
* **Component: Search Field (`Search...`)**
  1. *Current UI*: Pill container with search icon and placeholder.
  2. *Current Action*: Non-functional static text container.
  3. *Navigation*: **NO**.
  4. *Business Logic*: **NO** (No global search dispatcher).
  5. *Backend Integration*: **NO**.
  6. *State Management*: **NO**.
  7. *Validation*: **NO**.
  8. *Error Handling*: **NO**.
  9. *Loading State*: **NO**.
  10. *Empty State*: **NO**.
  11. *Permissions/Security*: **NO**.
  12. *Persistence*: **NO**.
  13. *Production Ready*: **NO**.

* **Component: Notification Bell Icon (`IconButton`)**
  1. *Current UI*: `IconButton(Icons.notifications_none)`.
  2. *Current Action*: `onPressed: () {}` (No-op).
  3. *Navigation*: **NO**.
  4. *Business Logic*: **NO** (No notification drawer/popup).
  5. *Backend Integration*: **NO**.
  6. *State Management*: **NO**.
  7. *Validation*: **N/A**.
  8. *Error Handling*: **N/A**.
  9. *Loading State*: **NO**.
  10. *Empty State*: **NO**.
  11. *Permissions/Security*: **NO**.
  12. *Persistence*: **NO**.
  13. *Production Ready*: **NO**.

* **Component: Operator Avatar Pill**
  1. *Current UI*: Pill with avatar circle `A` and `"व्यवस्थापक (Admin)"` label.
  2. *Current Action*: Static container (non-clickable).
  3. *Navigation*: **NO** (No profile menu / logout drawer).
  4. *Business Logic*: **NO** (Hardcoded "Admin" label; does not reflect logged-in user profile).
  5. *Backend Integration*: **NO**.
  6. *State Management*: **NO**.
  7. *Validation*: **N/A**.
  8. *Error Handling*: **N/A**.
  9. *Loading State*: **NO**.
  10. *Empty State*: **N/A**.
  11. *Permissions/Security*: **NO**.
  12. *Persistence*: **NO**.
  13. *Production Ready*: **NO**.

* **Component: Backend Connection Status Pill**
  1. *Current UI*: Green/Grey pill with live dot (`Live Backend` / `Production Standby`).
  2. *Current Action*: Real-time watcher of `backendConnectionStatusProvider`.
  3. *Navigation*: **N/A**.
  4. *Business Logic*: **YES** (Detects Supabase connection state).
  5. *Backend Integration*: **YES** (`SupabaseClientProvider`).
  6. *State Management*: **YES** (`ref.watch`).
  7. *Validation*: **N/A**.
  8. *Error Handling*: **YES** (Catches null client).
  9. *Loading State*: **N/A**.
  10. *Empty State*: **N/A**.
  11. *Permissions/Security*: **N/A**.
  12. *Persistence*: **N/A**.
  13. *Production Ready*: **YES**.

---

### 2. Authentication Screen (`LoginScreen`)

* **Component: Email Input Field (`TextFormField`)**
  1. *Current UI*: `TextFormField` with `Icons.mail_outline` prefix, Nepali placeholder.
  2. *Current Action*: Text input controller with form binding.
  3. *Navigation*: **N/A**.
  4. *Business Logic*: **YES** (Email trim, validation).
  5. *Backend Integration*: **YES** (Passed to `AuthRepository.signIn`).
  6. *State Management*: **YES** (`TextEditingController`).
  7. *Validation*: **YES** (Non-empty check, `@` format verification).
  8. *Error Handling*: **YES** (Inline error text).
  9. *Loading State*: **YES** (Disabled while logging in).
  10. *Empty State*: **N/A**.
  11. *Permissions/Security*: **YES** (Sanitized input).
  12. *Persistence*: **NO** (No "Remember Me" credential caching).
  13. *Production Ready*: **YES**.

* **Component: Password Input Field (`TextFormField`)**
  1. *Current UI*: Obscured text field with `Icons.lock_outline` prefix.
  2. *Current Action*: Text input controller with obscure state toggle.
  3. *Navigation*: **N/A**.
  4. *Business Logic*: **YES** (Password masking).
  5. *Backend Integration*: **YES** (Passed to Supabase Auth).
  6. *State Management*: **YES** (`StatefulWidget`).
  7. *Validation*: **YES** (Required field check).
  8. *Error Handling*: **YES** (Inline error text).
  9. *Loading State*: **YES** (Disabled during submission).
  10. *Empty State*: **N/A**.
  11. *Permissions/Security*: **YES** (Obscured text entry).
  12. *Persistence*: **NO**.
  13. *Production Ready*: **YES**.

* **Component: Password Visibility Toggle Icon (`IconButton`)**
  1. *Current UI*: `Icons.visibility_outlined` / `Icons.visibility_off_outlined`.
  2. *Current Action*: `setState(() => _obscurePassword = !_obscurePassword)`.
  3. *Navigation*: **N/A**.
  4. *Business Logic*: **YES** (Toggles mask).
  5. *Backend Integration*: **N/A**.
  6. *State Management*: **YES**.
  7. *Validation*: **N/A**.
  8. *Error Handling*: **N/A**.
  9. *Loading State*: **N/A**.
  10. *Empty State*: **N/A**.
  11. *Permissions/Security*: **YES**.
  12. *Persistence*: **N/A**.
  13. *Production Ready*: **YES**.

* **Component: "पासवर्ड बिर्सनुभयो?" (Forgot Password Link)**
  1. *Current UI*: Text link (`AppColors.primary`).
  2. *Current Action*: `onTap: () {}` (No-op).
  3. *Navigation*: **NO** (No password reset route).
  4. *Business Logic*: **NO** (No OTP/email recovery flow).
  5. *Backend Integration*: **NO** (`supabase.auth.resetPasswordForEmail` unlinked).
  6. *State Management*: **NO**.
  7. *Validation*: **NO**.
  8. *Error Handling*: **NO**.
  9. *Loading State*: **NO**.
  10. *Empty State*: **NO**.
  11. *Permissions/Security*: **NO**.
  12. *Persistence*: **NO**.
  13. *Production Ready*: **NO**.

* **Component: "लगइन गर्नुहोस्" (Submit Button)**
  1. *Current UI*: `AppButton` (Primary, trailing arrow, full width).
  2. *Current Action*: Invokes `_handleLogin()` -> `AuthController.signInWithEmailPassword()`.
  3. *Navigation*: **YES** (Redirects to `/dashboard` on success).
  4. *Business Logic*: **YES** (Form validation check, error parsing).
  5. *Backend Integration*: **YES** (Supabase Auth).
  6. *State Management*: **YES** (Riverpod `AsyncNotifier`).
  7. *Validation*: **YES** (`FormState.validate()`).
  8. *Error Handling*: **YES** (`AppBannerCard` error alert on failure).
  9. *Loading State*: **YES** (`isLoading` spinner on button).
  10. *Empty State*: **N/A**.
  11. *Permissions/Security*: **YES** (Session token generation).
  12. *Persistence*: **YES** (Supabase auth session in local secure storage).
  13. *Production Ready*: **YES**.

* **Component: Biometric Fingerprint Button**
  1. *Current UI*: Circular 64x64px button with fingerprint icon.
  2. *Current Action*: `onTap: () {}` (No-op).
  3. *Navigation*: **NO**.
  4. *Business Logic*: **NO** (`local_auth` plugin uncalled).
  5. *Backend Integration*: **NO**.
  6. *State Management*: **NO**.
  7. *Validation*: **NO**.
  8. *Error Handling*: **NO**.
  9. *Loading State*: **NO**.
  10. *Empty State*: **NO**.
  11. *Permissions/Security*: **NO**.
  12. *Persistence*: **NO**.
  13. *Production Ready*: **NO**.

* **Component: "साइन अप गर्नुहोस्" (Sign Up Link)**
  1. *Current UI*: Underlined text link.
  2. *Current Action*: `onTap: () {}` (No-op).
  3. *Navigation*: **NO** (No registration route).
  4. *Business Logic*: **NO**.
  5. *Backend Integration*: **NO**.
  6. *State Management*: **NO**.
  7. *Validation*: **NO**.
  8. *Error Handling*: **NO**.
  9. *Loading State*: **NO**.
  10. *Empty State*: **NO**.
  11. *Permissions/Security*: **NO**.
  12. *Persistence*: **NO**.
  13. *Production Ready*: **NO**.

---

### 3. Dashboard Screen (`DashboardScreen` & Widgets)

* **Component: Overview Stat Cards (Total Schools, Active Teachers, Monthly Revenue, Outstanding)**
  1. *Current UI*: 4 `DashboardStatCard`s with top-right 8% opacity watermark icons.
  2. *Current Action*: Non-clickable summary display.
  3. *Navigation*: **NO** (Not linked to respective module routes).
  4. *Business Logic*: **YES** (Zero-safe numeric formatting, fallback checks).
  5. *Backend Integration*: **YES** (`DashboardRepository` queries Supabase counts).
  6. *State Management*: **YES** (`dashboardOverviewProvider`).
  7. *Validation*: **N/A**.
  8. *Error Handling*: **YES** (Graceful fallback to `0` or `Rs. 0`).
  9. *Loading State*: **YES** (`AppSkeletonCard` grid).
  10. *Empty State*: **YES** (Displays `0` / `Rs. 0` without breaking).
  11. *Permissions/Security*: **NO** (Revenue figures visible to all roles without financial authorization check).
  12. *Persistence*: **N/A**.
  13. *Production Ready*: **PARTIAL** (Works, but needs financial role masking and drill-down navigation).

* **Component: Recent Schools "View All" Link**
  1. *Current UI*: `TextButton("View All")` inside table header.
  2. *Current Action*: Unwired callback parameter (`onViewAll: null`).
  3. *Navigation*: **NO** (Does not navigate to `/schools`).
  4. *Business Logic*: **NO**.
  5. *Backend Integration*: **N/A**.
  6. *State Management*: **NO**.
  7. *Validation*: **N/A**.
  8. *Error Handling*: **N/A**.
  9. *Loading State*: **N/A**.
  10. *Empty State*: **N/A**.
  11. *Permissions/Security*: **NO**.
  12. *Persistence*: **N/A**.
  13. *Production Ready*: **NO**.

* **Component: Recent Schools Data Rows**
  1. *Current UI*: `DataTable` with Status Badges (`ACTIVE`, `PENDING SETUP`, `INACTIVE`).
  2. *Current Action*: Static table rows (non-clickable).
  3. *Navigation*: **NO** (Cannot tap a school to view school profile).
  4. *Business Logic*: **YES** (Date formatting, active programs counting).
  5. *Backend Integration*: **YES** (Fed from `data.recentSchools`).
  6. *State Management*: **YES**.
  7. *Validation*: **N/A**.
  8. *Error Handling*: **YES**.
  9. *Loading State*: **YES** (Handled by parent skeleton).
  10. *Empty State*: **YES** (`AppEmptyState` when list is empty).
  11. *Permissions/Security*: **NO**.
  12. *Persistence*: **N/A**.
  13. *Production Ready*: **PARTIAL** (Display works, but row navigation missing).

* **Component: Entry Guard Widget Status Pills (`PRESENT`, `LATE`, `ABSENT`)**
  1. *Current UI*: 3 semantic status containers with colored circular dots.
  2. *Current Action*: Non-clickable summary.
  3. *Navigation*: **NO** (Does not navigate to `/attendance`).
  4. *Business Logic*: **YES** (Displays live counts).
  5. *Backend Integration*: **YES** (Queries `attendance_logs`).
  6. *State Management*: **YES**.
  7. *Validation*: **N/A**.
  8. *Error Handling*: **YES**.
  9. *Loading State*: **YES**.
  10. *Empty State*: **YES** (Renders `0` cleanly).
  11. *Permissions/Security*: **NO**.
  12. *Persistence*: **N/A**.
  13. *Production Ready*: **PARTIAL** (Display works, tap-to-drill-down missing).

* **Component: Upcoming Activities "View Calendar" Button**
  1. *Current UI*: `AppButton` (Outline, full width).
  2. *Current Action*: Unwired parameter (`onViewCalendar: null`).
  3. *Navigation*: **NO**.
  4. *Business Logic*: **NO**.
  5. *Backend Integration*: **NO**.
  6. *State Management*: **NO**.
  7. *Validation*: **N/A**.
  8. *Error Handling*: **N/A**.
  9. *Loading State*: **N/A**.
  10. *Empty State*: **N/A**.
  11. *Permissions/Security*: **NO**.
  12. *Persistence*: **N/A**.
  13. *Production Ready*: **NO**.

* **Component: Upcoming Activities Timeline Items**
  1. *Current UI*: Connected node timeline with icon badges.
  2. *Current Action*: Static display (non-clickable).
  3. *Navigation*: **NO**.
  4. *Business Logic*: **YES** (Date & 12-hour AM/PM formatting).
  5. *Backend Integration*: **YES** (Queries `activities` table).
  6. *State Management*: **YES**.
  7. *Validation*: **N/A**.
  8. *Error Handling*: **YES**.
  9. *Loading State*: **YES**.
  10. *Empty State*: **YES** (Empty calendar icon with clear message).
  11. *Permissions/Security*: **NO**.
  12. *Persistence*: **N/A**.
  13. *Production Ready*: **PARTIAL**.

---

### 4. Teachers Directory (`TeachersScreen`)

* **Component: "शिक्षक थप्नुहोस् (New Teacher)" Action Button**
  1. *Current UI*: `AppButton` (Primary, `Icons.person_add_alt`).
  2. *Current Action*: `onPressed: () {}` (No-op).
  3. *Navigation*: **NO** (No Add Teacher modal/screen).
  4. *Business Logic*: **NO**.
  5. *Backend Integration*: **NO**.
  6. *State Management*: **NO**.
  7. *Validation*: **NO**.
  8. *Error Handling*: **NO**.
  9. *Loading State*: **NO**.
  10. *Empty State*: **N/A**.
  11. *Permissions/Security*: **NO** (No role restriction check).
  12. *Persistence*: **NO**.
  13. *Production Ready*: **NO**.

* **Component: Search Field (`AppSearchField`)**
  1. *Current UI*: Reusable search field with clear button.
  2. *Current Action*: Updates `teacherSearchQueryProvider`.
  3. *Navigation*: **N/A**.
  4. *Business Logic*: **YES** (Triggers real-time filtering in `teacherListProvider`).
  5. *Backend Integration*: **YES** (Applies ILIKE query or client-side filter).
  6. *State Management*: **YES** (`StateProvider<String>`).
  7. *Validation*: **N/A**.
  8. *Error Handling*: **YES**.
  9. *Loading State*: **YES** (`autoDispose` triggers skeleton on query change).
  10. *Empty State*: **YES** (`AppEmptyState` displayed when query yields 0 results).
  11. *Permissions/Security*: **N/A**.
  12. *Persistence*: **NO** (Query resets on screen exit).
  13. *Production Ready*: **YES**.

* **Component: "Filters" Button**
  1. *Current UI*: `AppButton` (Outline, `Icons.filter_list`).
  2. *Current Action*: `onPressed: () {}` (No-op).
  3. *Navigation*: **NO** (No filter bottom sheet or dropdown menu).
  4. *Business Logic*: **NO** (No subject/school/status filter state).
  5. *Backend Integration*: **NO**.
  6. *State Management*: **NO**.
  7. *Validation*: **N/A**.
  8. *Error Handling*: **N/A**.
  9. *Loading State*: **NO**.
  10. *Empty State*: **N/A**.
  11. *Permissions/Security*: **NO**.
  12. *Persistence*: **NO**.
  13. *Production Ready*: **NO**.

* **Component: Teacher Directory Cards (`TeacherCard`)**
  1. *Current UI*: `SoftCard` with Avatar, Name, Designation, Experience, Star Rating, Attendance Rate, and School Count.
  2. *Current Action*: `context.go('/teachers/${teacher.id}')`.
  3. *Navigation*: **YES** (Opens `TeacherProfileScreen`).
  4. *Business Logic*: **YES** (Calculates initial, percentage formatting).
  5. *Backend Integration*: **YES** (Data passed from repository).
  6. *State Management*: **YES**.
  7. *Validation*: **N/A**.
  8. *Error Handling*: **YES**.
  9. *Loading State*: **YES**.
  10. *Empty State*: **YES** (Root list has `AppEmptyState`).
  11. *Permissions/Security*: **YES** (Does not expose sensitive PAN/salary on card).
  12. *Persistence*: **N/A**.
  13. *Production Ready*: **YES**.

---

### 5. Teacher Profile Screen (`TeacherProfileScreen`)

* **Component: Breadcrumbs Link (`Teachers`)**
  1. *Current UI*: Text link with right chevron.
  2. *Current Action*: `context.go(RouteConstants.teachers)`.
  3. *Navigation*: **YES** (Returns to directory).
  4. *Business Logic*: **YES**.
  5. *Backend Integration*: **N/A**.
  6. *State Management*: **N/A**.
  7. *Validation*: **N/A**.
  8. *Error Handling*: **N/A**.
  9. *Loading State*: **N/A**.
  10. *Empty State*: **N/A**.
  11. *Permissions/Security*: **N/A**.
  12. *Persistence*: **N/A**.
  13. *Production Ready*: **YES**.

* **Component: Profile Action "Message" Button**
  1. *Current UI*: `AppButton` (Outline).
  2. *Current Action*: `onPressed: () {}` (No-op).
  3. *Navigation*: **NO** (No messaging route).
  4. *Business Logic*: **NO**.
  5. *Backend Integration*: **NO**.
  6. *State Management*: **NO**.
  7. *Validation*: **NO**.
  8. *Error Handling*: **NO**.
  9. *Loading State*: **NO**.
  10. *Empty State*: **N/A**.
  11. *Permissions/Security*: **NO**.
  12. *Persistence*: **NO**.
  13. *Production Ready*: **NO**.

* **Component: Profile Action "Edit Profile" Button**
  1. *Current UI*: `AppButton` (Primary).
  2. *Current Action*: `onPressed: () {}` (No-op).
  3. *Navigation*: **NO** (No edit form dialog/route).
  4. *Business Logic*: **NO**.
  5. *Backend Integration*: **NO**.
  6. *State Management*: **NO**.
  7. *Validation*: **NO**.
  8. *Error Handling*: **NO**.
  9. *Loading State*: **NO**.
  10. *Empty State*: **N/A**.
  11. *Permissions/Security*: **NO** (Should require admin role).
  12. *Persistence*: **NO**.
  13. *Production Ready*: **NO**.

* **Component: 5 Profile Tabs (Overview, Schools, Schedule, Attendance, Training)**
  1. *Current UI*: `TabBar` with custom indicator line.
  2. *Current Action*: Switches active tab view in `_tabController`.
  3. *Navigation*: **YES** (Internal tab switching).
  4. *Business Logic*: **YES** (Renders corresponding sub-view).
  5. *Backend Integration*: **YES** (Populated from `Teacher` domain model).
  6. *State Management*: **YES** (`StatefulWidget`).
  7. *Validation*: **N/A**.
  8. *Error Handling*: **YES**.
  9. *Loading State*: **YES**.
  10. *Empty State*: **YES** (Each tab has independent `AppEmptyState`).
  11. *Permissions/Security*: **YES**.
  12. *Persistence*: **NO** (Tab resets to 0 on reload).
  13. *Production Ready*: **YES**.

* **Component: Document Vault Sensitive Data Protection (`DocumentVaultCard`)**
  1. *Current UI*: Container with shield icon, PAN Card row, Bank Details row, Salary Structure row.
  2. *Current Action*: Eye icons toggle local reveal state; permission manager evaluates authorization.
  3. *Navigation*: **N/A**.
  4. *Business Logic*: **YES** (Field-level masking via `RolePermissions.maskValue`).
  5. *Backend Integration*: **YES**.
  6. *State Management*: **YES** (`rolePermissionsProvider`).
  7. *Validation*: **N/A**.
  8. *Error Handling*: **YES**.
  9. *Loading State*: **YES**.
  10. *Empty State*: **YES** (Shows `—` for null fields).
  11. *Permissions/Security*: **YES** (Enforces strict `superAdmin` / `schoolAdmin` / `teacher` / `viewer` access; locks salary with red lock icon for unauthorized roles).
  12. *Persistence*: **N/A**.
  13. *Production Ready*: **YES**.

---

### 6. Schools Screen (`SchoolsScreen`)

* **Component: "नयाँ विद्यालय (Add School)" Action Button**
  1. *Current UI*: `AppButton` (Primary, `Icons.domain_add`).
  2. *Current Action*: `onPressed: () {}` (No-op).
  3. *Navigation*: **NO** (No registration modal/route).
  4. *Business Logic*: **NO**.
  5. *Backend Integration*: **NO** (`SchoolRepository.createSchool` is never invoked).
  6. *State Management*: **NO**.
  7. *Validation*: **NO**.
  8. *Error Handling*: **NO**.
  9. *Loading State*: **NO**.
  10. *Empty State*: **N/A**.
  11. *Permissions/Security*: **NO**.
  12. *Persistence*: **NO**.
  13. *Production Ready*: **NO**.

* **Component: Search Bar**
  1. *Current UI*: Fake container styled as search box with placeholder.
  2. *Current Action*: Non-functional static container (cannot type).
  3. *Navigation*: **NO**.
  4. *Business Logic*: **NO**.
  5. *Backend Integration*: **NO**.
  6. *State Management*: **NO**.
  7. *Validation*: **NO**.
  8. *Error Handling*: **NO**.
  9. *Loading State*: **NO**.
  10. *Empty State*: **NO**.
  11. *Permissions/Security*: **NO**.
  12. *Persistence*: **NO**.
  13. *Production Ready*: **NO**.

* **Component: "फिल्टर (Filters)" Button**
  1. *Current UI*: `AppButton` (Outline, `Icons.filter_list`).
  2. *Current Action*: `onPressed: () {}` (No-op).
  3. *Navigation*: **NO**.
  4. *Business Logic*: **NO**.
  5. *Backend Integration*: **NO**.
  6. *State Management*: **NO**.
  7. *Validation*: **NO**.
  8. *Error Handling*: **NO**.
  9. *Loading State*: **NO**.
  10. *Empty State*: **NO**.
  11. *Permissions/Security*: **NO**.
  12. *Persistence*: **NO**.
  13. *Production Ready*: **NO**.

* **Component: Schools Table Data**
  1. *Current UI*: Hardcoded static `AppEmptyState`.
  2. *Current Action*: Displays empty state regardless of database contents.
  3. *Navigation*: **NO**.
  4. *Business Logic*: **NO** (No real query or list builder).
  5. *Backend Integration*: **NO** (Does not call Supabase `schools` table).
  6. *State Management*: **NO** (No Riverpod controller).
  7. *Validation*: **NO**.
  8. *Error Handling*: **NO**.
  9. *Loading State*: **NO**.
  10. *Empty State*: **YES** (Static empty state only).
  11. *Permissions/Security*: **NO**.
  12. *Persistence*: **NO**.
  13. *Production Ready*: **NO** (Entire screen is a template).

---

### 7. Attendance Screen (`AttendanceScreen`)

* **Component: "स्क्यानर सुरु गर्नुहोस् (Scan QR)" Button**
  1. *Current UI*: `AppButton` (Primary, `Icons.qr_code_scanner`).
  2. *Current Action*: `onPressed: () {}` (No-op).
  3. *Navigation*: **NO** (Does not launch QR scanner camera or dialog).
  4. *Business Logic*: **NO**.
  5. *Backend Integration*: **NO**.
  6. *State Management*: **NO**.
  7. *Validation*: **NO**.
  8. *Error Handling*: **NO**.
  9. *Loading State*: **NO**.
  10. *Empty State*: **N/A**.
  11. *Permissions/Security*: **NO** (Camera permissions unhandled).
  12. *Persistence*: **NO**.
  13. *Production Ready*: **NO**.

* **Component: "दैनिक प्रतिवेदन (Export Log)" Button**
  1. *Current UI*: `AppButton` (Outline, `Icons.download`).
  2. *Current Action*: `onPressed: () {}` (No-op).
  3. *Navigation*: **NO**.
  4. *Business Logic*: **NO** (No CSV / PDF export logic).
  5. *Backend Integration*: **NO**.
  6. *State Management*: **NO**.
  7. *Validation*: **NO**.
  8. *Error Handling*: **NO**.
  9. *Loading State*: **NO**.
  10. *Empty State*: **N/A**.
  11. *Permissions/Security*: **NO**.
  12. *Persistence*: **NO**.
  13. *Production Ready*: **NO**.

* **Component: Attendance Content / Table**
  1. *Current UI*: Hardcoded static `AppEmptyState`.
  2. *Current Action*: Fixed empty message.
  3. *Navigation*: **NO**.
  4. *Business Logic*: **NO** (Does not implement Entry Guard telemetry from `ENTRY_GUARD_SPEC.md`).
  5. *Backend Integration*: **NO** (Does not query `attendance_logs` or real-time GPS stream).
  6. *State Management*: **NO**.
  7. *Validation*: **NO**.
  8. *Error Handling*: **NO**.
  9. *Loading State*: **NO**.
  10. *Empty State*: **YES** (Static empty state only).
  11. *Permissions/Security*: **NO**.
  12. *Persistence*: **NO**.
  13. *Production Ready*: **NO** (Entire screen is a template).

---

### 8. Finance Screen (`FinanceScreen`)

* **Component: "बैंक सिंक (Bank Sync)" Action Button**
  1. *Current UI*: `AppButton` (Outline, `Icons.sync`).
  2. *Current Action*: `onPressed: () {}` (No-op).
  3. *Navigation*: **NO**.
  4. *Business Logic*: **NO** (No OpenBanking / ConnectIPS / API sync).
  5. *Backend Integration*: **NO**.
  6. *State Management*: **NO**.
  7. *Validation*: **NO**.
  8. *Error Handling*: **NO**.
  9. *Loading State*: **NO**.
  10. *Empty State*: **N/A**.
  11. *Permissions/Security*: **NO** (Should require finance admin permission).
  12. *Persistence*: **NO**.
  13. *Production Ready*: **NO**.

* **Component: "नयाँ रसिद (New Receipt)" Action Button**
  1. *Current UI*: `AppButton` (Primary, `Icons.add`).
  2. *Current Action*: `onPressed: () {}` (No-op).
  3. *Navigation*: **NO** (No receipt creation voucher dialog).
  4. *Business Logic*: **NO**.
  5. *Backend Integration*: **NO**.
  6. *State Management*: **NO**.
  7. *Validation*: **NO**.
  8. *Error Handling*: **NO**.
  9. *Loading State*: **NO**.
  10. *Empty State*: **N/A**.
  11. *Permissions/Security*: **NO**.
  12. *Persistence*: **NO**.
  13. *Production Ready*: **NO**.

* **Component: Ledger Vouchers Table**
  1. *Current UI*: Hardcoded static `AppEmptyState`.
  2. *Current Action*: Fixed empty text.
  3. *Navigation*: **NO**.
  4. *Business Logic*: **NO** (No fiscal calculation, cash flow aggregation, or fee ledger).
  5. *Backend Integration*: **NO** (Does not query `invoices`, `fees`, or `payments`).
  6. *State Management*: **NO**.
  7. *Validation*: **NO**.
  8. *Error Handling*: **NO**.
  9. *Loading State*: **NO**.
  10. *Empty State*: **YES** (Static empty state only).
  11. *Permissions/Security*: **NO**.
  12. *Persistence*: **NO**.
  13. *Production Ready*: **NO** (Entire screen is a template).

---

### 9. Inventory Screen (`InventoryScreen`)

* **Component: "सामग्री थप्नुहोस् (Add Item)" Action Button**
  1. *Current UI*: `AppButton` (Primary, `Icons.add_box_outlined`).
  2. *Current Action*: `onPressed: () {}` (No-op).
  3. *Navigation*: **NO** (No asset creation dialog).
  4. *Business Logic*: **NO**.
  5. *Backend Integration*: **NO**.
  6. *State Management*: **NO**.
  7. *Validation*: **NO**.
  8. *Error Handling*: **NO**.
  9. *Loading State*: **NO**.
  10. *Empty State*: **N/A**.
  11. *Permissions/Security*: **NO**.
  12. *Persistence*: **NO**.
  13. *Production Ready*: **NO**.

* **Component: Inventory Items Table**
  1. *Current UI*: Hardcoded static `AppEmptyState`.
  2. *Current Action*: Fixed empty text.
  3. *Navigation*: **NO**.
  4. *Business Logic*: **NO** (No stock tracking, checkout logs, or reorder levels).
  5. *Backend Integration*: **NO** (Does not query `inventory_items`).
  6. *State Management*: **NO**.
  7. *Validation*: **NO**.
  8. *Error Handling*: **NO**.
  9. *Loading State*: **NO**.
  10. *Empty State*: **YES** (Static empty state only).
  11. *Permissions/Security*: **NO**.
  12. *Persistence*: **NO**.
  13. *Production Ready*: **NO** (Entire screen is a template).

---

### 10. Emergency Screen (`EmergencyScreen`)

* **Component: "आपतकालीन तालाबन्दी (Initiate Emergency Protocol)" Button**
  1. *Current UI*: `AppButton` (Destructive Red, `Icons.lock_person`).
  2. *Current Action*: `onPressed: () {}` (No-op).
  3. *Navigation*: **NO**.
  4. *Business Logic*: **NO** (No confirmation barrier, lockdown broadcast, or SMS/Push dispatcher).
  5. *Backend Integration*: **NO**.
  6. *State Management*: **NO**.
  7. *Validation*: **NO** (Lacks double-confirmation modal).
  8. *Error Handling*: **NO**.
  9. *Loading State*: **NO**.
  10. *Empty State*: **N/A**.
  11. *Permissions/Security*: **NO** (Any user viewing screen can tap destructive button).
  12. *Persistence*: **NO**.
  13. *Production Ready*: **NO** (Critical safety hazard if unconfirmed).

---

### 11. Settings Screen (`SettingsScreen`)

* **Component: Database Connection Card**
  1. *Current UI*: `SoftCard` displaying `isConnected` status pill and environment string (`development`).
  2. *Current Action*: Read-only status.
  3. *Navigation*: **N/A**.
  4. *Business Logic*: **YES** (Reads `EnvConfig` and `backendConnectionStatusProvider`).
  5. *Backend Integration*: **YES**.
  6. *State Management*: **YES** (`ref.watch`).
  7. *Validation*: **N/A**.
  8. *Error Handling*: **YES**.
  9. *Loading State*: **N/A**.
  10. *Empty State*: **N/A**.
  11. *Permissions/Security*: **NO**.
  12. *Persistence*: **N/A**.
  13. *Production Ready*: **PARTIAL** (Read-only; cannot re-test or edit configuration).

* **Component: Language & Localization Chips (`English (US)`, `नेपाली (Nepal)`)**
  1. *Current UI*: Two static `Chip`s.
  2. *Current Action*: Non-clickable visual elements.
  3. *Navigation*: **NO**.
  4. *Business Logic*: **NO** (Cannot switch language; no locale provider).
  5. *Backend Integration*: **NO**.
  6. *State Management*: **NO**.
  7. *Validation*: **N/A**.
  8. *Error Handling*: **N/A**.
  9. *Loading State*: **N/A**.
  10. *Empty State*: **N/A**.
  11. *Permissions/Security*: **N/A**.
  12. *Persistence*: **NO** (No SharedPreferences or Hive locale persistence).
  13. *Production Ready*: **NO**.

---

## Comprehensive Metrics & Gap Analysis

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                      MINDSPARQ OS AUDIT SUMMARY TOTALS                      │
├──────────────────────────────────────────────────────┬──────────────────────┤
│ Metric Category                                      │ Count / Status       │
├──────────────────────────────────────────────────────┼──────────────────────┤
│ Total Screens Audited                                │ 11 Screens           │
│ Fully Working Screens                                │ 4 Screens (36%)      │
│ Non-Working / Template-Only Screens                  │ 7 Screens (64%)      │
│ Total Interactive Elements Audited                   │ 48 Elements          │
│ Working Interactive Elements                         │ 22 Elements (46%)    │
│ Non-Working / Dummy Callback Elements                │ 26 Elements (54%)    │
└──────────────────────────────────────────────────────┴──────────────────────┘
```

### Breakdown by Category

1. **Total Screens**: **11**
   - Shell (`ShellScreen` / `AppHeader` / Navbars)
   - Login (`LoginScreen`)
   - Dashboard (`DashboardScreen`)
   - Teachers Directory (`TeachersScreen`)
   - Teacher Profile (`TeacherProfileScreen`)
   - Schools (`SchoolsScreen`)
   - Attendance (`AttendanceScreen`)
   - Finance (`FinanceScreen`)
   - Inventory (`InventoryScreen`)
   - Emergency (`EmergencyScreen`)
   - Settings (`SettingsScreen`)

2. **Working Screens**: **4**
   - `LoginScreen` (Authenticates real Supabase accounts, validates inputs, handles errors)
   - `DashboardScreen` (Fetches live counts from Supabase, handles empty states, responsive grid)
   - `TeachersScreen` (Real-time search, responsive card grid, empty states, profile navigation)
   - `TeacherProfileScreen` (Full tabs, contact dossier, role-based sensitive data protection)

3. **Non-Working / Template-Only Screens**: **7**
   - `SchoolsScreen` (No repository, no database query, static empty state, dummy buttons)
   - `AttendanceScreen` (No Entry Guard logic, no GPS/QR scanner, static empty state)
   - `FinanceScreen` (No ledger queries, no bank sync, no voucher creation, static empty state)
   - `InventoryScreen` (No asset queries, no stock checkout, static empty state)
   - `EmergencyScreen` (No lockdown protocol, no confirmation modal, dummy broadcast button)
   - `SettingsScreen` (Read-only display; language chips are non-clickable; no persistence)
   - `DesktopNavSidebar` / `AppHeader` (Header search, notification bell, user avatar menu non-functional)

4. **Total Interactive Elements**: **48**
   - Working: **22** (Tab switches, search field in teachers, login submit, password visibility toggle, nav items, breadcrumbs, eye toggles in document vault, status pill watchers)
   - Non-working: **26** (Buttons with `onPressed: () {}` or static non-clickable links)

5. **Missing Navigation Flows**:
   - `Forgot Password` -> `/auth/reset-password` (Missing route)
   - `Sign Up` -> `/auth/register` (Missing route)
   - `Dashboard Recent Schools "View All"` -> `/schools` (Unlinked)
   - `Dashboard School Row Click` -> `/schools/:id` (Missing route)
   - `Dashboard Upcoming Activities "View Calendar"` -> `/calendar` (Missing route)
   - `Teachers "Add Teacher"` -> `/teachers/new` or Add Dialog (Missing)
   - `Teachers "Filters"` -> Filter bottom sheet / modal (Missing)
   - `Schools "Add School"` -> `/schools/new` or Add Dialog (Missing)
   - `Attendance "Scan QR"` -> Camera QR scanner overlay (Missing)
   - `Finance "New Receipt"` -> Financial voucher creation dialog (Missing)
   - `Header Operator Avatar` -> User profile drawer & Logout flow (Missing)

6. **Missing Backend Logic & Database Operations**:
   - `schools`: CRUD operations missing (`getSchools`, `createSchool`, `updateSchool`).
   - `attendance_logs`: Real-time geofence check-in and checkout mutations missing.
   - `finance_vouchers` / `payments`: Invoicing, payment collection, and ledger reconciliation missing.
   - `inventory_items`: Asset catalog, stock adjustments, and room allocations missing.
   - `emergency_broadcasts`: Multi-channel push/SMS incident escalation engine missing.

7. **Missing Authentication & Security**:
   - Role-based route guards in `GoRouter` (`redirect` currently allows unauthenticated access to all internal routes without login check).
   - Biometric authentication trigger via `local_auth` plugin.
   - Session expiration and token refresh handling.
   - User profile & Logout action in Header.

8. **Missing Localization**:
   - Hardcoded dual English/Nepali strings instead of structured `AppLocalizations` (Flutter `intl` or `.arb` files).
   - Language switchers in `SettingsScreen` are static chips with no state.

9. **Missing Settings Functionality**:
   - No dark/light theme toggle provider.
   - No offline sync interval configuration.
   - No school profile configuration.

10. **Missing Validation & Error Handling**:
    - Input forms for Schools, Vouchers, Inventory items do not exist yet.
    - Global HTTP error interceptor for Supabase token expiration is absent.

11. **Missing Tests**:
    - Automated tests currently cover Design System, Login, Dashboard, Shell, and Teachers (28 tests total).
    - Zero unit or widget tests exist for Schools, Attendance, Finance, Inventory, Emergency, and Settings.

---

## Critical Production Blockers

| Priority | Blocker ID | Description | Impact |
| :--- | :--- | :--- | :--- |
| **P0** | `BLK-001` | **Unprotected Route Navigation**: `app_router.dart` lacks auth redirect guards. Direct navigation to `/dashboard` succeeds even when unauthenticated. | Critical Security Vulnerability |
| **P0** | `BLK-002` | **Missing Schools Management Backend**: Schools module has no Supabase repository implementation or creation modal. Cannot register client institutions. | Core Business Blocker |
| **P0** | `BLK-003` | **Entry Guard Implementation Missing**: `AttendanceScreen` lacks GPS fence monitoring and biometric check-in/out specified in `ENTRY_GUARD_SPEC.md`. | Core Product Blocker |
| **P1** | `BLK-004` | **Missing Financial Ledger Engine**: `FinanceScreen` has zero database integration or transaction recording capabilities. | Operational Blocker |
| **P1** | `BLK-005` | **Unprotected Emergency Button**: Emergency lockdown has no double-confirmation dialog or authorization requirement. | High Risk UX Hazard |
| **P1** | `BLK-006` | **Header Profile & Logout Missing**: Logged-in administrators cannot view their active account or log out. | Usability & Security |
| **P2** | `BLK-007` | **Static Localization**: Strings are hardcoded rather than utilizing `flutter_localizations`. | Maintainability & i18n |
