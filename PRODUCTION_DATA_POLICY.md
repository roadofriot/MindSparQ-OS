# MindSparQ OS — Production Data Policy

This repository operates under a strict **Zero-Fake Data** standard.

---

## 1. Core Directives

1. **No Fake Schools**: Never seed, hardcode, or return artificial school entities.
2. **No Fake Teachers**: Never inject dummy faculty or staff member records into production repositories.
3. **No Fake Payments**: Financial figures must strictly reflect verified ledger records.
4. **No Fake Attendance**: Gate logs must represent genuine verified check-in/check-out entries.
5. **No Fake Financial Records**: Never fabricate accounts, revenue charts, or outstanding fees.
6. **No Fake GPS Events**: Spatial coordinates must originate from authenticated device sensor readings.
7. **No Hardcoded Demo Statistics**: Never display hardcoded mock metrics (e.g., `128 schools`, `486 teachers`, `Rs. 1,250,000`). If database tables are unpopulated or unconfigured, render `0`, `Rs. 0`, or `—`.

---

## 2. UI Fallback Hierarchy

When backend data is absent or unavailable:
* **Empty States**: Present [`AppEmptyState`](lib/core/design_system/components/feedback/app_empty_state.dart) with contextual icon, explanatory message, and an action CTA (e.g. `New School`, `Add Teacher`).
* **Loading States**: Display [`AppSkeletonCard`](lib/core/design_system/components/feedback/app_loading.dart) or [`AppLoadingIndicator`](lib/core/design_system/components/feedback/app_loading.dart) while awaiting network responses.
* **Error States**: Display [`AppErrorBanner`](lib/core/design_system/components/feedback/app_error.dart) with retry mechanisms when network queries fail.

---

## 3. Strict Boundary Isolation

* **Production Code (`lib/`)**: Must only communicate with real backend clients (e.g., Supabase) and return real domain entities or empty collections.
* **Test Fixtures (`test/`)**: Fakes, stubs, and unit test fixtures are strictly quarantined within the `test/` directory and must never leak into application code.
