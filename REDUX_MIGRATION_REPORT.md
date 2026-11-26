> Scope note: this earlier document compares the supplied intermediate Express/React application with its Redux migration. For the actual NestJS/JSON GitHub baseline, current clone verification, one nonfunctional trailing-space cleanup, preserved history and honest attribution, read [GITHUB_MIGRATION_REPORT.md](GITHUB_MIGRATION_REPORT.md). It is not a claim that the GitHub backend was unchanged.

# IndAI Redux migration report — 3.0.0

## Delivery and scope

The release is `IndAI_Redux.zip`. Extract its `IndAI/` folder and run `npm install`, `npm run setup`, `npm run dev` with Node 24+. The input in this workspace was an already extracted complete application, so no input archive extraction was necessary.

The existing application has been migrated, including its full page tree, shared components, market/chart data, media uploads, checkout requests, staff/member operations and learning/commercial workflows. It uses Redux Toolkit 2.15.0 and React Redux 9.3.1 with Toolkit's built-in Thunk middleware. There are 17 feature slices plus the session-generation marker. No RTK Query or React Query remains in application source/dependencies. The retained useResource/useAction names now implement Redux selection and named Thunk dispatch.

## Dependency and version changes

| Item | Before | After |
| --- | --- | --- |
| Project version | 2.0.0 | 3.0.0 |
| @tanstack/react-query | 5.108.0 | Removed, including lockfile entries and render-check usage |
| @reduxjs/toolkit | Absent | 2.15.0, exact pinned |
| react-redux | Absent | 9.3.1, exact pinned |
| Thunk middleware | No explicit Redux architecture | Toolkit default middleware; no separate manual Redux Thunk dependency needed |
| React, Vite, Router, SQLite, chart/form/validation/payment stack | Supplied versions | Retained |

`package-lock.json` is updated consistently with package.json. Install completed successfully. No forced major upgrade of the existing backend/test dependencies was applied.

## Old-to-new state mapping

| Previous location | New authoritative state/workflow |
| --- | --- |
| QueryClient/Provider in main.jsx | configureStore and React Redux Provider; BrowserRouter/StrictMode/Suspense preserved |
| useResource/useQuery | Redux feature resource selector + effect subscription + named read thunk |
| useAction/useMutation | Supported endpoint resolves to a named mutation thunk; operation-specific state and unwrap |
| Global invalidateQueries | Affected feature invalidation and mounted-resource refetch after successful writes |
| Current-user query + direct auth | authSlice and named login/register/verify/logout/recovery/password thunks |
| Theme Context state | themeSlice; only browser theme preference persists |
| Local active watchlist | watchlistSlice.activeWatchlist and memoized selector |
| Market Query polling | One per-key runtime timer and in-flight request; marketSlice stores quotes/catalogue/candles |
| Paper account/ledger/journal queries | portfolioSlice, retaining backend-owned financial values |
| OrderTicket direct request and local outcome | placeOrder thunk and selected operation result; stable clientKey retry and synchronous ref guard |
| Course/quiz/task/provider/member queues | Dedicated feature slices with parameterized resources and named thunks |
| QuizBuilder/QuizResponse direct calls | quizSlice mutation thunks, existing controlled forms retained |
| Resources raw component fetch | resourceSlice upload thunk + shared transport; authorized links/streams preserved |
| Plans direct API calls | paymentSlice requests; native Razorpay widget stays in the component |
| Notification preview direct request | Explicit dispatch of fetchNotifications and Redux result |
| Logout cache clearing | Account-wide store reset, request abort/invalidation and session generation checks |

## Backend, database and UI preservation

**Backend changes: none.** Every backend file, migration, bundled catalogue and supplied PDF/video is byte-identical to the inspected baseline. Existing private runtime database contents were not edited by the migration tests; tests used in-memory or isolated temporary SQLite databases. Runtime data is excluded from the ZIP; schema, seed and migrations recreate the demo locally. Setup's existing behavior with a pre-existing .env is preserved.

**CSS changes: none.** Existing CSS hashes match the baseline. Routes, layouts, forms, icon/font imports, responsive behavior, chart controls, role gates and native checkout/dialog communication were preserved. The only markup-level infrastructure changes supply Redux and the existing data interfaces. Browser checks validate layout constraints at 1440, 390 and 320px. No original-versus-new pixel-diff suite was run.

**Permissions changes: none.** The supplied code already unified User Admin and Payment Admin permissions under `admin`. Its actual active roles remain student, instructor, provider, admin and superadmin. Free/Pro/Plus are student plans. The six requested academic responsibilities are mapped to these existing permissions, with separate work/study ownership for user versus payment administration.

## Request correctness and bounded state

Read requests are keyed by canonical URL and guarded by requestId, invalidation revision and session epoch. A response for a prior course/symbol/filter does not replace another resource. Existing data remains visible during refresh; failed quotes stay non-executable through a retry until success. A successful write refetches relevant mounted feature resources rather than the entire application; incomplete `{id}`/`{ok}` write responses never invent domain records or balances.

Each action-hook instance tracks operation state by endpoint and method, allowing independent statuses for different concurrent actions. Private request bodies, uploaded Files, timers, promises, chart objects and DOM nodes stay outside Redux. Completed operation entries are cleared on component unmount/reset. Resource snapshots remain in the browser's session store until session reset; there is no persistence of private domain state.

The synchronous CRUD reducers support complete verified records. Normal UI mutations reconcile authoritative server snapshots through targeted reads, because the original write APIs intentionally return small acknowledgements. Unsupported deletion/editing operations were not invented.

## Actual verification — 2026-11-26, Asia/Calcutta

| Check | Final result | Evidence/scope |
| --- | --- | --- |
| npm install (Redux installation and final pinned dependency validation) | Passed | Final `npm install --ignore-scripts --registry=https://registry.npmjs.org` exit 0; earlier normal dependency install also completed |
| npm run setup | Passed | Demo mode and a separate setup-data directory; existing user database untouched |
| npm test | Passed | 8 files, 68 passed, 0 failed, 0 skipped; 48 existing tests and 20 new Redux tests |
| npm run build | Passed | Vite production build, 130 modules transformed |
| npm run test:smoke | Passed | Development API proxy and built server SPA refresh/API 404 from another working directory |
| npm run test:catalog-ui | Passed | 2,779-instrument picker, pagination/empty state, Redux-provider watchlist/explorer rendering |
| npx playwright install chromium | Passed | Downloaded Chromium and headless shell before browser checks |
| npm run test:e2e | Passed | Existing full end-to-end suite; all seven demo quick logins and role/navigation/learning/trading/billing/admin scenarios |
| npm run test:trading-ui | Passed | Watchlist CRUD/reorder/persistence, charts/reset/fullscreen, special-symbol stock selection, dark/responsive layouts, zero page errors |
| Source boundaries | Passed | No React Query application imports; no component/page fetch or direct api transport; lockfile contains no TanStack Query package |
| Backend/CSS hash preservation | Passed | Zero backend and CSS files changed from the inspected baseline |
| npm audit, official registry with network access | Advisories remain | 5 dependency nodes: 1 moderate, 2 high, 2 critical; see docs/npm-audit.json |

The new Redux unit tests cover initialization, CRUD reducers, useful error payloads, independent parameterized resources, pre-write response invalidation, private request arguments, login/current-user loading, logout/late responses, expired sessions, account switching, shared polling, no overlapping polling, stale quote retry protection, active-watchlist selection and source boundaries. New full-stack tests drive the actual frontend transport/thunks into Express/SQLite for courses, resource upload/delete, watchlist CRUD, idempotent trading/cancellation, account/journal, assignments/reviews, quiz draft/submit/manual grading, simulated payment, provider counteroffer/acceptance/publication/earning/settlement, member search, support and unread counts.

All browser and full-stack tests used isolated demo data and simulated funds. Node's experimental SQLite warning is expected. Vite's ignored upstream React Router `use client` directives do not prevent the build. The notification audit-failure regression intentionally logs a simulated backend error while its rollback test passes.

Initial sandbox worker/server/browser attempts failed with EPERM, and Chromium was initially missing. Approved reruns and the browser installation removed these execution blockers. Early migration errors (Provider name collision and frozen initial-state assignment on session reset) were fixed, covered and followed by successful final runs. An in-sandbox audit returned an incomplete empty advisory result; the network-enabled official-registry audit is the one recorded here.

Machine-readable results: [docs/redux-verification.json](docs/redux-verification.json). Full dependency audit: [docs/npm-audit.json](docs/npm-audit.json).

## Known limitations and checks not executed

- The retained Nodemailer 7.0.13, Zod 3.25.76 and Vitest 3.2.7 dependency trees have five reported vulnerable nodes: nodemailer (high), zod (high), vitest (critical), tinypool (critical), @vitest/mocker (moderate). The official audit proposes major-version upgrades. These are existing stack dependencies, not the newly added Redux packages. A separate upgrade and compatibility review is needed before deployment; this frontend migration does not claim a clean dependency audit.
- Real Razorpay hosted checkout/refunds, live Upstox credentials/entitlements/open-market execution, SMTP delivery and real external bank transfers were not exercised. Existing code paths remain, but each needs an operator-controlled sandbox/deployment verification. No real financial transaction was initiated.
- The real Upstox network feed was not used. Replay/domain tests exercise deterministic fixtures, and demo browser tests exercise the preserved UI and safeguards. Inherited live-provider assertions in docs/verification.md are explicitly labelled historical notes.
- No private original database or .env is shipped. Use setup for fresh fictional demo data, or securely configure an existing installation yourself. The source backend and migrations are retained intact.
- No fake commits, authors, dates, tags or contribution history were created. No production deployment or GitHub push was performed.

## Exact source inventory

### Newly created files

- `REDUX_ARCHITECTURE.md`
- `REDUX_MIGRATION_REPORT.md`
- `REDUX_VIVA_GUIDE.md`
- `docs/npm-audit.json`
- `docs/redux-verification.json`
- `frontend/src/hooks/request.js`
- `frontend/src/redux/hooks.js`
- `frontend/src/redux/routes.js`
- `frontend/src/redux/selectors/index.js`
- `frontend/src/redux/slices/authSlice.js`
- `frontend/src/redux/slices/commerceSlice.js`
- `frontend/src/redux/slices/courseSlice.js`
- `frontend/src/redux/slices/dashboardSlice.js`
- `frontend/src/redux/slices/guidanceSlice.js`
- `frontend/src/redux/slices/marketSlice.js`
- `frontend/src/redux/slices/notificationSlice.js`
- `frontend/src/redux/slices/paymentSlice.js`
- `frontend/src/redux/slices/portfolioSlice.js`
- `frontend/src/redux/slices/quizSlice.js`
- `frontend/src/redux/slices/resourceSlice.js`
- `frontend/src/redux/slices/supportSlice.js`
- `frontend/src/redux/slices/taskSlice.js`
- `frontend/src/redux/slices/themeSlice.js`
- `frontend/src/redux/slices/tradingSlice.js`
- `frontend/src/redux/slices/userSlice.js`
- `frontend/src/redux/slices/watchlistSlice.js`
- `frontend/src/redux/store.js`
- `frontend/src/redux/utilities/requests.js`
- `frontend/src/redux/utilities/resourceState.js`
- `frontend/src/redux/utilities/runtime.js`
- `frontend/src/redux/utilities/session.js`
- `release-manifest.json`
- `tests/redux-api.test.js`
- `tests/redux.test.js`

The generated `release-manifest.json` is also included; it records SHA-256 hashes for release files other than itself.

### Modified files

- `.gitignore`
- `README.md`
- `docs/verification.md`
- `frontend/src/components/OrderTicket.jsx`
- `frontend/src/components/ProfileDialog.jsx`
- `frontend/src/components/QuizBuilderForm.jsx`
- `frontend/src/components/QuizResponse.jsx`
- `frontend/src/components/Resources.jsx`
- `frontend/src/components/Shell.jsx`
- `frontend/src/hooks/api.js`
- `frontend/src/hooks/useDemoLogin.js`
- `frontend/src/hooks/useMarket.js`
- `frontend/src/hooks/useTheme.jsx`
- `frontend/src/hooks/useWatchlists.js`
- `frontend/src/main.jsx`
- `frontend/src/pages/Auth.jsx`
- `frontend/src/pages/Courses.jsx`
- `frontend/src/pages/Members.jsx`
- `frontend/src/pages/Operations.jsx`
- `frontend/src/pages/Plans.jsx`
- `frontend/src/pages/Trading.jsx`
- `package-lock.json`
- `package.json`
- `scripts/check-catalog-ui.js`

### Removed source files

None.

No React page/component/backend file was deleted. React Query's installed packages/lock entries were removed; generated old build files are outside the release. The original API helper file remains and exports the Redux-backed hooks/formatters; reusable HTTP transport was extracted into hooks/request.js.

## Proposed five-member preparation and genuine Git organization

This is a suggested allocation, not evidence of who authored the migration. All teammates should understand their actual assigned code and record their own genuine work.

| Member | Feature ownership | Suggested genuine commit subject |
| --- | --- | --- |
| 1 — Student | trading/market/watchlist/portfolio slices; Trading, Portfolio, OrderTicket, market/watchlist hooks and chart integration | `feat(trading): migrate paper trading and watchlists to Redux thunks` |
| 2 — Instructor | guidance/task/quiz slices; Learners, Guidance, Tasks, quiz builder/attempt/review components | `feat(teaching): manage guidance assignments and quizzes with Redux` |
| 3 — Course Provider | course/resource slices; Courses, Resources and provider content coordination | `feat(learning): migrate course CRUD and media resources to Redux` |
| 4 — User Admin/Super Admin | auth/user/support/notification slices; Auth, Shell, Members, Operations; shared store/provider/session integration | `feat(admin): integrate Redux sessions members support and notifications` |
| 5 — Payment Admin | payment/commerce slices; Plans and commercial/admin-payment sections | `feat(billing): move subscription and licensing workflows to Redux` |

Shared files require review: package files, store.js, routes.js, hooks.js, selectors, runtime/transport utilities, main.jsx, Operations.jsx, Provider.jsx and test/documentation records. dashboard/theme are shared support features. Do not duplicate slices for actor ownership. Each member has five concrete live-code exercises in REDUX_VIVA_GUIDE.md.

Suggested procedure in the team's existing GitHub repository:

```powershell
# Begin on the actual original commit/branch in your existing repository.
git status
git switch -c redux-migration
# Copy/review this release's source; keep private .env/data out of staging.
# Stage only the files each teammate actually owns and has reviewed.
# Make genuine feature commits under the teammate's own identity.
# Integrate shared wiring after the feature slices are present.
npm install
npm run setup
npm test
npm run build
npm run test:smoke
npm run test:catalog-ui
npm run test:e2e
npm run test:trading-ui
git diff --check
# Review .gitignore and staged contents, then push your real branch:
git push -u origin redux-migration
```

Keep the original branch as the real React baseline. Open a pull request explaining the architecture change and actual verification. Suggested additional genuine commits: `test(redux): cover lifecycle polling isolation and actor workflows`, `docs(redux): add architecture viva and verification guides`, and `chore(state): pin Toolkit and React Redux dependencies`. Use these only for work actually performed and reviewed. Do not generate backdated or fabricated attribution.

## Release hygiene

The ZIP excludes node_modules, data, frontend/dist, private .env variants, databases/journals, logs, temporary migration scripts, browser outputs and Git metadata. .env.example keeps credentials empty and defaults to demo market data. .gitignore now also covers private environment variants, SQLite sidecars, database files, logs and ZIPs. Existing real environment values are checked for accidental inclusion without printing them. Source hashes and archive-integrity checks validate that the packaged code is the modified project.
