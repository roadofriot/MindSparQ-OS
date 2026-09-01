# PRODUCTION DATA POLICY

## Strict Mandate
1. **Never create fake schools.**
2. **Never create fake teachers.**
3. **Never create fake payments.**
4. **Never create fake attendance.**
5. **Never create fake financial records.**
6. **Never create fake GPS events.**
7. **Never hardcode demo statistics.**

## Presentation Rules
- **Empty States**: Use `AppEmptyState` or professional zero/empty fallback indicators (`0`, `Rs. 0`, `—`) when data does not exist in the database.
- **Loading States**: Use `AppSkeletonCard` or `AppLoadingIndicator` while data is loading.
- **Error States**: Use `AppErrorBanner` when network requests fail.

## Test & Development Isolation
- Development fixtures and mock repositories belong **strictly in `test/`** test files.
- Development fixtures must never be committed to or referenced within production application code (`lib/`).
