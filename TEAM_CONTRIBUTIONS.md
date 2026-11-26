# IndAI team responsibilities and genuine contribution record

## Authorship status

The original five commits are preserved. GitHub's public commit API associates them with the usernames below. The current Redux application was prepared with AI assistance and imported by the user-authorized integrator, **Praneeth <174439533+me-coder7@users.noreply.github.com>**. The import is not split into five invented author commits. No teammate co-authorship has been asserted. A future file assignment is not evidence that its assignee authored the imported code.

Praneeth's supplied institutional email `mohansaipraneeth.p24@iiits.in` was not verified as GitHub-associated. The existing noreply address was verified through historical commit metadata and explicitly selected by the user. The other four supplied emails match commit metadata associated by GitHub with their expected accounts; this does not expose or verify private email settings.

## Measured historical work

All recorded deletions in the five baseline commits are zero. These are Git measurements, not effort scores.

| Username | Historical commit | Source added | Dataset added | Lockfile added | Documentation added | Asset text lines | Configuration added |
| --- | --- | ---: | ---: | ---: | ---: | --- | ---: |

| Jeswanth09052007 | `82fbbea` | 9,801 | 136,718 | 3,166 | 1,585 | 74 + binary assets | 141 |
| me-coder7 | `15962aa` | 2,794 | 0 | 0 | 78 | 0 + binary assets | 0 |
| Purvaj-P22 | `fdfd040` | 2,962 | 0 | 1,170 | 77 | 0 + binary assets | 19 |
| BharanRajP | `5cd2768` | 4,869 | 0 | 0 | 78 | 0 + binary assets | 0 |
| gurwinder-s24 | `0aaf233` | 2,412 | 0 | 0 | 80 | 0 + binary assets | 0 |


Jeswanth's 136,718 CSV lines and 3,166 lockfile lines explain most of the displayed imbalance. Git also counts 74 text lines in an old PDF asset; excluding those asset lines gives the screenshot's 151,411 additions. No tracked node_modules, build-output or vendor directory was found. Source additions are still not a complete measure of complexity or actual effort.

## Proposed review/development footprint

The figures below assign each changed source file to one **primary coordination owner** to avoid double counting. Shared functions are listed separately. They are actual Git-diff lines in the import's review scope, not lines credited to five authors. The honest import commit credits only its authorized integrator. Generated data, lockfiles, configuration, documentation and binary assets are excluded from source-line columns. Planning percentages are estimates, not measured productivity.

| Member | Actor | Assigned files | Added source lines in review scope | Deleted source lines in review scope | Estimated workload |
| --- | --- | --- | ---: | ---: | --- |

| Jeswanth09052007 | Learner | 32 primary current files; see lists/JSON | 3,185 | 2,393 | 22% planning estimate |
| me-coder7 | Instructor | 15 primary current files; see lists/JSON | 2,280 | 2,317 | 20% planning estimate |
| Purvaj-P22 | Course Provider | 14 primary current files; see lists/JSON | 1,941 | 4,871 | 18% planning estimate |
| BharanRajP | User Admin and Super Admin | 57 primary current files; see lists/JSON | 4,945 | 10,035 | 21% planning estimate |
| gurwinder-s24 | Payment Admin and shared integration | 39 primary current files; see lists/JSON | 3,416 | 3,192 | 19% planning estimate |


The exact full comparison is docs/github-file-comparison.csv. Current assignments and shared function scopes are in docs/team-ownership.json. Do not delete/restore files, make whitespace-only edits, duplicate code or create empty commits to balance numbers.

## React evaluation coverage

Every member owns meaningful frontend behavior and prepares components/props (2 marks), state/events (1), controlled forms (1), effects/cleanup (1), explanation/viva/live modification (5). The group demonstrates trading, courses/progress, quizzes/assignments, guidance, billing and admin/support workflows for the 10-mark group assessment. Database and reporting support are additional responsibilities, not substitutes for each member's React work.


## Member 1: Jeswanth — Learner

GitHub: [Jeswanth09052007](https://github.com/Jeswanth09052007). Verified historical email: `jeswanthreddyreddem@gmail.com`. Historical commit: [`82fbbea`](https://github.com/me-coder7/New_33_IndAI_React/commit/82fbbea349aab6014f152d15742d531060f52626).

Actual new contribution: no new authored implementation commit has been claimed; responsibilities below are proposed genuine future work/review.

### React and Redux files to prepare

- `frontend/src/components/CandleChart.jsx`
- `frontend/src/components/InstrumentPicker.jsx`
- `frontend/src/components/MarketExplorerDialog.jsx`
- `frontend/src/components/MarketFeedNotice.jsx`
- `frontend/src/components/OrderDialog.jsx`
- `frontend/src/components/OrderTicket.jsx`
- `frontend/src/components/Orders.jsx`
- `frontend/src/components/TradingSidebar.jsx`
- `frontend/src/components/WatchlistRow.jsx`
- `frontend/src/components/Watchlists.jsx`
- `frontend/src/hooks/chartData.js`
- `frontend/src/hooks/useMarket.js`
- `frontend/src/hooks/useWatchlists.js`
- `frontend/src/pages/Portfolio.jsx`
- `frontend/src/pages/Trading.jsx`
- `frontend/src/redux/slices/marketSlice.js`
- `frontend/src/redux/slices/portfolioSlice.js`
- `frontend/src/redux/slices/tradingSlice.js`
- `frontend/src/redux/slices/watchlistSlice.js`
- `frontend/src/styles/trading.css`

### Backend, tests and supporting files

- `back-end/assets/catalog/nse-equities.json`
- `back-end/routes/trading.js`
- `back-end/services/capital.js`
- `back-end/services/instruments.js`
- `back-end/services/market.js`
- `back-end/services/replay.js`
- `back-end/services/trading.js`
- `scripts/sync-instruments.js`
- `tests/catalog.test.js`
- `tests/market.test.js`
- `tests/replay.test.js`
- `tests/trading-browser.js`

### Shared function coordination

- `frontend/src/pages/Quizzes.jsx`: Learner response interaction review
- `frontend/src/pages/Guidance.jsx`: Learner request behavior
- `frontend/src/pages/Overview.jsx`: LearnerOverview()
- `frontend/src/components/Common.jsx`: Trading/result consumers
- `frontend/src/main.jsx`: Trading routes
- `frontend/src/redux/routes.js`: Trading endpoints
- `frontend/src/redux/selectors/index.js`: Quotes/watchlists derivations
- `back-end/seed.js`: Market/trading fixtures
- `tests/redux-api.test.js`: Trading coverage

### React concepts, APIs and live changes

Trading passes instrument/account to OrderTicket; explorer selection callbacks update route state. Quantity/order fields are controlled useState values. useMarket subscription effects clean polling; CandleChart refs/effects own the chart. Selectors read quotes/account/watchlists and placeOrder unwraps backend outcomes.

APIs: `/trading/catalog`, `/trading/quotes`, `/trading/instruments/:symbol/candles`, `/trading/orders`, `/trading/orders/:id/cancel`, `/trading/account`, `/trading/watchlists`, `/trading/journal`.

1. Add a selector for loaded working-order counts.
2. Add an accessible controlled watchlist filter.
3. Test rapid symbol selection with an obsolete response.
4. Improve retry feedback while keeping stale quotes non-executable.
5. Add a focused regression for stable order retry keys.


### Exact PowerShell commands for future genuine work

These commands were **not** executed to fabricate five commits. Run from a clean worktree when the member is ready to work; preserve any unrelated edits and stage only reviewed hunks. No change means no commit.

```powershell
Set-Location -LiteralPath 'C:\Users\mohan sai praneeth\Music\IndAI_Redux\IndAI\New_33_IndAI_React'
git status --short
$memberBranch = 'feature/jeswanth09052007-reviewed-work'
if (git branch --list $memberBranch) { git switch $memberBranch } else { git switch -c $memberBranch redux-migration }
# Perform and review an actual change first. Run these staging commands only
# for genuine work by this member, with their authorization.
$ownedPaths = @(
    'back-end/routes/trading.js',
    'back-end/services/capital.js',
    'back-end/services/instruments.js',
    'back-end/services/market.js',
    'back-end/services/replay.js',
    'back-end/services/trading.js',
    'frontend/src/components/CandleChart.jsx',
    'frontend/src/components/InstrumentPicker.jsx',
    'frontend/src/components/MarketExplorerDialog.jsx',
    'frontend/src/components/MarketFeedNotice.jsx',
    'frontend/src/components/OrderDialog.jsx',
    'frontend/src/components/OrderTicket.jsx',
    'frontend/src/components/Orders.jsx',
    'frontend/src/components/TradingSidebar.jsx',
    'frontend/src/components/WatchlistRow.jsx',
    'frontend/src/components/Watchlists.jsx',
    'frontend/src/hooks/chartData.js',
    'frontend/src/hooks/useMarket.js',
    'frontend/src/hooks/useWatchlists.js',
    'frontend/src/pages/Portfolio.jsx',
    'frontend/src/pages/Trading.jsx',
    'frontend/src/redux/slices/marketSlice.js',
    'frontend/src/redux/slices/portfolioSlice.js',
    'frontend/src/redux/slices/tradingSlice.js',
    'frontend/src/redux/slices/watchlistSlice.js',
    'frontend/src/styles/trading.css',
    'scripts/sync-instruments.js',
    'tests/catalog.test.js',
    'tests/market.test.js',
    'tests/replay.test.js',
    'tests/trading-browser.js'
)
git --literal-pathspecs add -- @ownedPaths
git add -p -- 'frontend/src/pages/Quizzes.jsx' # stage only the assigned reviewed functions
git add -p -- 'frontend/src/pages/Guidance.jsx' # stage only the assigned reviewed functions
git add -p -- 'frontend/src/pages/Overview.jsx' # stage only the assigned reviewed functions
git add -p -- 'frontend/src/components/Common.jsx' # stage only the assigned reviewed functions
git add -p -- 'frontend/src/main.jsx' # stage only the assigned reviewed functions
git add -p -- 'frontend/src/redux/routes.js' # stage only the assigned reviewed functions
git add -p -- 'frontend/src/redux/selectors/index.js' # stage only the assigned reviewed functions
git add -p -- 'back-end/seed.js' # stage only the assigned reviewed functions
git add -p -- 'tests/redux-api.test.js' # stage only the assigned reviewed functions
powershell -NoProfile -File 'scripts/Test-StagedSecrets.ps1'
git diff --cached --check
git diff --cached --stat
git diff --cached --name-status
git diff --cached
npm test
npm run build
npm run test:trading-ui
# The integrator is the committer; --author is allowed only for verified genuine work.
git -c user.name='Praneeth' -c user.email='174439533+me-coder7@users.noreply.github.com' commit --author='Jeswanth <jeswanthreddyreddem@gmail.com>' -m 'feat(trading): improve reviewed Redux trading and watchlist workflows'
git log -1 --format="%h | author=%an <%ae> | committer=%cn <%ce> | %s"
```


## Member 2: Praneeth — Instructor

GitHub: [me-coder7](https://github.com/me-coder7). Verified historical email: `174439533+me-coder7@users.noreply.github.com`. Historical commit: [`15962aa`](https://github.com/me-coder7/New_33_IndAI_React/commit/15962aa0a62c9113344dbee0de440c40f5b85ced).

Actual new contribution: authorized integration and verification work; the honest import is recorded under the selected integrator identity.

### React and Redux files to prepare

- `frontend/src/components/QuizAttempt.jsx`
- `frontend/src/components/QuizAttempts.jsx`
- `frontend/src/components/QuizBuilderForm.jsx`
- `frontend/src/components/QuizResponse.jsx`
- `frontend/src/pages/Guidance.jsx`
- `frontend/src/pages/Learners.jsx`
- `frontend/src/pages/Quizzes.jsx`
- `frontend/src/pages/Tasks.jsx`
- `frontend/src/redux/slices/guidanceSlice.js`
- `frontend/src/redux/slices/quizSlice.js`
- `frontend/src/redux/slices/taskSlice.js`

### Backend, tests and supporting files

- `back-end/routes/guidance.js`
- `back-end/routes/quizzes.js`
- `back-end/services/subscription-reminders.js`
- `tests/expanded.test.js`

### Shared function coordination

- `frontend/src/pages/Quizzes.jsx`: Quizzes/Quiz/QuizBuilder and assessment integration
- `frontend/src/pages/Guidance.jsx`: Directory/Guidance request and roster workflows
- `frontend/src/pages/Overview.jsx`: InstructorSummary()
- `frontend/src/components/Common.jsx`: Assessment form consumers
- `frontend/src/main.jsx`: Teaching routes
- `frontend/src/redux/routes.js`: Teaching endpoints
- `back-end/routes/learning.js`: Tasks/assignments/submissions/milestones/learning-plan blocks
- `back-end/routes/members.js`: Teaching roster and paper-fund award routes
- `back-end/seed.js`: Teaching fixtures
- `tests/redux-api.test.js`: Assignments/quizzes coverage

### React concepts, APIs and live changes

Guidance/Tasks compose reusable forms and resources. QuizBuilderForm receives courses/learners as props and edits controlled question state. QuizResponse controls answer inputs; callbacks dispatch save/submit. Effects fetch selected resources; quiz/guidance/task slices retain lifecycle state.

APIs: `/teaching/learners`, `/teaching/learners/:id/award`, `/staff`, `/guidance`, `/tasks`, `/assignments`, `/submissions/:id/review`, `/quizzes`, `/quizzes/:id/draft`, `/quizzes/:id/submit`, `/quiz-attempts/:id/grade`.

1. Add a controlled active/pending guidance filter.
2. Show a selector-derived overdue-assignment count.
3. Improve written-answer validation feedback.
4. Add a reset for unsaved local quiz answers.
5. Test grading failure preserving the prior result.


### Exact PowerShell commands for future genuine work

These commands were **not** executed to fabricate five commits. Run from a clean worktree when the member is ready to work; preserve any unrelated edits and stage only reviewed hunks. No change means no commit.

```powershell
Set-Location -LiteralPath 'C:\Users\mohan sai praneeth\Music\IndAI_Redux\IndAI\New_33_IndAI_React'
git status --short
$memberBranch = 'feature/me-coder7-reviewed-work'
if (git branch --list $memberBranch) { git switch $memberBranch } else { git switch -c $memberBranch redux-migration }
# Perform and review an actual change first. Run these staging commands only
# for genuine work by this member, with their authorization.
$ownedPaths = @(
    'back-end/routes/guidance.js',
    'back-end/routes/quizzes.js',
    'back-end/services/subscription-reminders.js',
    'frontend/src/components/QuizAttempt.jsx',
    'frontend/src/components/QuizAttempts.jsx',
    'frontend/src/components/QuizBuilderForm.jsx',
    'frontend/src/components/QuizResponse.jsx',
    'frontend/src/pages/Learners.jsx',
    'frontend/src/pages/Tasks.jsx',
    'frontend/src/redux/slices/guidanceSlice.js',
    'frontend/src/redux/slices/quizSlice.js',
    'frontend/src/redux/slices/taskSlice.js',
    'tests/expanded.test.js'
)
git --literal-pathspecs add -- @ownedPaths
git add -p -- 'frontend/src/pages/Quizzes.jsx' # stage only the assigned reviewed functions
git add -p -- 'frontend/src/pages/Guidance.jsx' # stage only the assigned reviewed functions
git add -p -- 'frontend/src/pages/Overview.jsx' # stage only the assigned reviewed functions
git add -p -- 'frontend/src/components/Common.jsx' # stage only the assigned reviewed functions
git add -p -- 'frontend/src/main.jsx' # stage only the assigned reviewed functions
git add -p -- 'frontend/src/redux/routes.js' # stage only the assigned reviewed functions
git add -p -- 'back-end/routes/learning.js' # stage only the assigned reviewed functions
git add -p -- 'back-end/routes/members.js' # stage only the assigned reviewed functions
git add -p -- 'back-end/seed.js' # stage only the assigned reviewed functions
git add -p -- 'tests/redux-api.test.js' # stage only the assigned reviewed functions
powershell -NoProfile -File 'scripts/Test-StagedSecrets.ps1'
git diff --cached --check
git diff --cached --stat
git diff --cached --name-status
git diff --cached
npm test
npm run build
npm run test:e2e
# The integrator is the committer; --author is allowed only for verified genuine work.
git -c user.name='Praneeth' -c user.email='174439533+me-coder7@users.noreply.github.com' commit --author='Praneeth <174439533+me-coder7@users.noreply.github.com>' -m 'feat(teaching): improve reviewed guidance assignments and quiz thunks'
git log -1 --format="%h | author=%an <%ae> | committer=%cn <%ce> | %s"
```


## Member 3: Purvaj — Course Provider

GitHub: [Purvaj-P22](https://github.com/Purvaj-P22). Verified historical email: `pentapurvaj07@gmail.com`. Historical commit: [`fdfd040`](https://github.com/me-coder7/New_33_IndAI_React/commit/fdfd040a6d8954529834fb49a3cdbe7b111d607f).

Actual new contribution: no new authored implementation commit has been claimed; responsibilities below are proposed genuine future work/review.

### React and Redux files to prepare

- `frontend/src/components/HomePreview.jsx`
- `frontend/src/components/Resources.jsx`
- `frontend/src/pages/Courses.jsx`
- `frontend/src/pages/Home.jsx`
- `frontend/src/pages/Provider.jsx`
- `frontend/src/redux/slices/courseSlice.js`
- `frontend/src/redux/slices/resourceSlice.js`
- `frontend/src/styles/home.css`

### Backend, tests and supporting files

- `back-end/assets/paper-trading-tutorial.mp4`
- `back-end/assets/trading-guide.pdf`
- `back-end/routes/learning.js`
- `back-end/routes/resources.js`
- `back-end/services/learning-access.js`
- `back-end/services/resources.js`

### Shared function coordination

- `frontend/src/pages/Provider.jsx`: Provider(): course dashboard and provider-side proposal forms
- `frontend/src/pages/Quizzes.jsx`: Course-scoped audience and Resources integration
- `frontend/src/pages/Guidance.jsx`: Provider relationship behavior
- `frontend/src/pages/Overview.jsx`: Provider overview links
- `frontend/src/components/Common.jsx`: Course form consumers
- `frontend/src/hooks/request.js`: Raw upload headers
- `frontend/src/main.jsx`: Course routes
- `frontend/src/redux/routes.js`: Course/media endpoints
- `back-end/routes/learning.js`: Course/lesson/enrollment/review route blocks
- `back-end/seed.js`: Course/media fixtures
- `tests/redux-api.test.js`: Course/media coverage

### React concepts, APIs and live changes

Courses uses selected Redux data and passes course/resource IDs to children. Resources handles native file selection and dispatches uploadResource. Course forms retain validation/controlled editing. Home composes HomePreview using reusable presentation; effect subscriptions fetch course snapshots.

APIs: `/courses`, `/courses/:id`, `/courses/:id/lessons`, `/courses/:id/submit`, `/courses/:id/enroll`, `/resources/:kind/:id`, `/resources/:kind/:id/upload`, `/resource-files/:id`, `/provider`, `/courses/:id/terms`.

1. Add a controlled difficulty filter over loaded courses.
2. Show a page-scoped draft-course count selector.
3. Add a course-description character counter.
4. Improve resource type/size feedback.
5. Test a rejected upload without losing existing resources.


### Exact PowerShell commands for future genuine work

These commands were **not** executed to fabricate five commits. Run from a clean worktree when the member is ready to work; preserve any unrelated edits and stage only reviewed hunks. No change means no commit.

```powershell
Set-Location -LiteralPath 'C:\Users\mohan sai praneeth\Music\IndAI_Redux\IndAI\New_33_IndAI_React'
git status --short
$memberBranch = 'feature/purvaj-p22-reviewed-work'
if (git branch --list $memberBranch) { git switch $memberBranch } else { git switch -c $memberBranch redux-migration }
# Perform and review an actual change first. Run these staging commands only
# for genuine work by this member, with their authorization.
$ownedPaths = @(
    'back-end/routes/resources.js',
    'back-end/services/learning-access.js',
    'back-end/services/resources.js',
    'frontend/src/components/HomePreview.jsx',
    'frontend/src/components/Resources.jsx',
    'frontend/src/pages/Courses.jsx',
    'frontend/src/pages/Home.jsx',
    'frontend/src/redux/slices/courseSlice.js',
    'frontend/src/redux/slices/resourceSlice.js',
    'frontend/src/styles/home.css'
)
git --literal-pathspecs add -- @ownedPaths
git add -p -- 'frontend/src/pages/Provider.jsx' # stage only the assigned reviewed functions
git add -p -- 'frontend/src/pages/Quizzes.jsx' # stage only the assigned reviewed functions
git add -p -- 'frontend/src/pages/Guidance.jsx' # stage only the assigned reviewed functions
git add -p -- 'frontend/src/pages/Overview.jsx' # stage only the assigned reviewed functions
git add -p -- 'frontend/src/components/Common.jsx' # stage only the assigned reviewed functions
git add -p -- 'frontend/src/hooks/request.js' # stage only the assigned reviewed functions
git add -p -- 'frontend/src/main.jsx' # stage only the assigned reviewed functions
git add -p -- 'frontend/src/redux/routes.js' # stage only the assigned reviewed functions
git add -p -- 'back-end/routes/learning.js' # stage only the assigned reviewed functions
git add -p -- 'back-end/seed.js' # stage only the assigned reviewed functions
git add -p -- 'tests/redux-api.test.js' # stage only the assigned reviewed functions
powershell -NoProfile -File 'scripts/Test-StagedSecrets.ps1'
git diff --cached --check
git diff --cached --stat
git diff --cached --name-status
git diff --cached
npm test
npm run build
npm run test:e2e
# The integrator is the committer; --author is allowed only for verified genuine work.
git -c user.name='Praneeth' -c user.email='174439533+me-coder7@users.noreply.github.com' commit --author='Purvaj <pentapurvaj07@gmail.com>' -m 'feat(learning): improve reviewed course CRUD and media workflows'
git log -1 --format="%h | author=%an <%ae> | committer=%cn <%ce> | %s"
```


## Member 4: Bharan — User Admin and Super Admin

GitHub: [BharanRajP](https://github.com/BharanRajP). Verified historical email: `bharanraj.p24@iiits.in`. Historical commit: [`5cd2768`](https://github.com/me-coder7/New_33_IndAI_React/commit/5cd27683dee4475a31481e738eb111ca45daa3ed).

Actual new contribution: no new authored implementation commit has been claimed; responsibilities below are proposed genuine future work/review.

### React and Redux files to prepare

- `frontend/src/components/DemoLogins.jsx`
- `frontend/src/components/ProfileDialog.jsx`
- `frontend/src/components/Shell.jsx`
- `frontend/src/hooks/useDemoLogin.js`
- `frontend/src/pages/Auth.jsx`
- `frontend/src/pages/Members.jsx`
- `frontend/src/pages/Operations.jsx`
- `frontend/src/pages/Overview.jsx`
- `frontend/src/redux/slices/authSlice.js`
- `frontend/src/redux/slices/dashboardSlice.js`
- `frontend/src/redux/slices/notificationSlice.js`
- `frontend/src/redux/slices/supportSlice.js`
- `frontend/src/redux/slices/userSlice.js`
- `frontend/src/styles/auth.css`

### Backend, tests and supporting files

- `back-end/app.js`
- `back-end/config.js`
- `back-end/db.js`
- `back-end/migrations/001-initial.sql`
- `back-end/migrations/002-staff-and-plans.sql`
- `back-end/migrations/003-learning-and-member-tools.sql`
- `back-end/migrations/004-merged-roles.sql`
- `back-end/migrations/005-instructor-starters.sql`
- `back-end/migrations/006-replay-order-scope.sql`
- `back-end/migrations/007-notification-delivery.sql`
- `back-end/migrations/008-unified-admin.sql`
- `back-end/routes/auth.js`
- `back-end/routes/members.js`
- `back-end/routes/operations.js`
- `back-end/seed.js`
- `back-end/server.js`
- `back-end/services/access.js`
- `back-end/services/auth.js`
- `back-end/validation.js`
- `scripts/provision-staff.js`
- `scripts/setup.js`
- `tests/api.test.js`
- `tests/notifications.test.js`
- `tests/redux-api.test.js`

### Shared function coordination

- `frontend/src/pages/Operations.jsx`: Notifications/Broadcast/Support/Ticket and account/staff/course queues
- `frontend/src/pages/Overview.jsx`: Overview role gates and admin/shared composition
- `frontend/src/components/Common.jsx`: Validation/security/error review
- `frontend/src/hooks/api.js`: Transport/security review
- `frontend/src/hooks/request.js`: Cookie/header/timeout/error boundaries
- `frontend/src/main.jsx`: Workspace/Gate/auth redirects
- `frontend/src/redux/store.js`: Session resets, permissions and private-state review
- `frontend/src/redux/routes.js`: Auth/admin mappings
- `frontend/src/redux/hooks.js`: Cancellation/session review
- `frontend/src/redux/selectors/index.js`: Current-user/theme review
- `back-end/routes/members.js`: Member CRUD/status/permission/session/notes routes
- `back-end/db.js`: Database/transaction owner; shared schema coordination
- `back-end/seed.js`: Common seed/schema coordination
- `tests/redux-api.test.js`: Auth/member/support coverage

### React concepts, APIs and live changes

Auth dispatches named auth thunks and unwraps failures. Shell receives the selected user and passes outlet context; ProfileDialog is controlled through callbacks. Members controls search/role/status/page values. Effects coordinate sessions/dialog focus. Auth/user/support/notification slices handle authorized backend data.

APIs: `/auth/login`, `/auth/register`, `/auth/verify`, `/auth/logout`, `/me`, `/members`, `/members/:id/profile`, `/members/:id/status`, `/members/:id/permissions`, `/admin`, `/notifications`, `/support`, `/courses/:id/review`.

1. Add an explicit clear-search control for Members.
2. Add a selector for the selected member display name.
3. Improve a controlled support-status filter.
4. Test a 401 clearing every private slice.
5. Improve a role-forbidden state without weakening backend checks.


### Additional primary configuration/documentation files

- `.env.example`
- `CONTRIBUTING.md`
- `GITHUB_MIGRATION_REPORT.md`
- `README.md`
- `REDUX_ARCHITECTURE.md`
- `REDUX_MIGRATION_REPORT.md`
- `REDUX_VIVA_GUIDE.md`
- `TEAM_CONTRIBUTIONS.md`
- `THIRD_PARTY_NOTICES.md`
- `docs/api.md`
- `docs/github-file-comparison.csv`
- `docs/github-migration-statistics.json`
- `docs/github-original-contributions.json`
- `docs/github-verification.json`
- `docs/npm-audit.json`
- `docs/redux-verification.json`
- `docs/team-ownership.json`
- `docs/verification.md`
- `docs/workflows.md`


### Exact PowerShell commands for future genuine work

These commands were **not** executed to fabricate five commits. Run from a clean worktree when the member is ready to work; preserve any unrelated edits and stage only reviewed hunks. No change means no commit.

```powershell
Set-Location -LiteralPath 'C:\Users\mohan sai praneeth\Music\IndAI_Redux\IndAI\New_33_IndAI_React'
git status --short
$memberBranch = 'feature/bharanrajp-reviewed-work'
if (git branch --list $memberBranch) { git switch $memberBranch } else { git switch -c $memberBranch redux-migration }
# Perform and review an actual change first. Run these staging commands only
# for genuine work by this member, with their authorization.
$ownedPaths = @(
    '.env.example',
    'back-end/app.js',
    'back-end/config.js',
    'back-end/migrations/001-initial.sql',
    'back-end/migrations/002-staff-and-plans.sql',
    'back-end/migrations/003-learning-and-member-tools.sql',
    'back-end/migrations/004-merged-roles.sql',
    'back-end/migrations/005-instructor-starters.sql',
    'back-end/migrations/006-replay-order-scope.sql',
    'back-end/migrations/007-notification-delivery.sql',
    'back-end/migrations/008-unified-admin.sql',
    'back-end/routes/auth.js',
    'back-end/routes/operations.js',
    'back-end/server.js',
    'back-end/services/access.js',
    'back-end/services/auth.js',
    'back-end/validation.js',
    'frontend/src/components/DemoLogins.jsx',
    'frontend/src/components/ProfileDialog.jsx',
    'frontend/src/components/Shell.jsx',
    'frontend/src/hooks/useDemoLogin.js',
    'frontend/src/pages/Auth.jsx',
    'frontend/src/pages/Members.jsx',
    'frontend/src/redux/slices/authSlice.js',
    'frontend/src/redux/slices/dashboardSlice.js',
    'frontend/src/redux/slices/notificationSlice.js',
    'frontend/src/redux/slices/supportSlice.js',
    'frontend/src/redux/slices/userSlice.js',
    'frontend/src/styles/auth.css',
    'scripts/provision-staff.js',
    'scripts/setup.js',
    'tests/api.test.js',
    'tests/notifications.test.js'
)
git --literal-pathspecs add -- @ownedPaths
git add -p -- 'frontend/src/pages/Operations.jsx' # stage only the assigned reviewed functions
git add -p -- 'frontend/src/pages/Overview.jsx' # stage only the assigned reviewed functions
git add -p -- 'frontend/src/components/Common.jsx' # stage only the assigned reviewed functions
git add -p -- 'frontend/src/hooks/api.js' # stage only the assigned reviewed functions
git add -p -- 'frontend/src/hooks/request.js' # stage only the assigned reviewed functions
git add -p -- 'frontend/src/main.jsx' # stage only the assigned reviewed functions
git add -p -- 'frontend/src/redux/store.js' # stage only the assigned reviewed functions
git add -p -- 'frontend/src/redux/routes.js' # stage only the assigned reviewed functions
git add -p -- 'frontend/src/redux/hooks.js' # stage only the assigned reviewed functions
git add -p -- 'frontend/src/redux/selectors/index.js' # stage only the assigned reviewed functions
git add -p -- 'back-end/routes/members.js' # stage only the assigned reviewed functions
git add -p -- 'back-end/db.js' # stage only the assigned reviewed functions
git add -p -- 'back-end/seed.js' # stage only the assigned reviewed functions
git add -p -- 'tests/redux-api.test.js' # stage only the assigned reviewed functions
powershell -NoProfile -File 'scripts/Test-StagedSecrets.ps1'
git diff --cached --check
git diff --cached --stat
git diff --cached --name-status
git diff --cached
npm test
npm run build
npm run test:e2e
# The integrator is the committer; --author is allowed only for verified genuine work.
git -c user.name='Praneeth' -c user.email='174439533+me-coder7@users.noreply.github.com' commit --author='Bharan <bharanraj.p24@iiits.in>' -m 'feat(admin): improve reviewed sessions members and support workflows'
git log -1 --format="%h | author=%an <%ae> | committer=%cn <%ce> | %s"
```


## Member 5: Gurwinder — Payment Admin and shared integration

GitHub: [gurwinder-s24](https://github.com/gurwinder-s24). Verified historical email: `gaurav98498@gmail.com`. Historical commit: [`0aaf233`](https://github.com/me-coder7/New_33_IndAI_React/commit/0aaf23324adb60a1854d5e670298bd5e904aa367).

Actual new contribution: no new authored implementation commit has been claimed; responsibilities below are proposed genuine future work/review.

### React and Redux files to prepare

- `frontend/index.html`
- `frontend/src/components/Common.jsx`
- `frontend/src/components/Icon.jsx`
- `frontend/src/components/ThemeToggle.jsx`
- `frontend/src/hooks/api.js`
- `frontend/src/hooks/request.js`
- `frontend/src/hooks/useTheme.jsx`
- `frontend/src/main.jsx`
- `frontend/src/pages/Plans.jsx`
- `frontend/src/redux/hooks.js`
- `frontend/src/redux/routes.js`
- `frontend/src/redux/selectors/index.js`
- `frontend/src/redux/slices/commerceSlice.js`
- `frontend/src/redux/slices/paymentSlice.js`
- `frontend/src/redux/slices/themeSlice.js`
- `frontend/src/redux/store.js`
- `frontend/src/redux/utilities/requests.js`
- `frontend/src/redux/utilities/resourceState.js`
- `frontend/src/redux/utilities/runtime.js`
- `frontend/src/redux/utilities/session.js`
- `frontend/src/style.css`
- `frontend/vite.config.js`

### Backend, tests and supporting files

- `back-end/routes/payments.js`
- `back-end/routes/provider.js`
- `back-end/services/payments.js`
- `scripts/Stage-Migration.ps1`
- `scripts/Summarize-Contributions.ps1`
- `scripts/Test-StagedSecrets.ps1`
- `scripts/check-catalog-ui.js`
- `scripts/dev.js`
- `scripts/smoke.js`
- `tests/browser.js`
- `tests/redux.test.js`

### Shared function coordination

- `frontend/src/pages/Provider.jsx`: Commerce(): admin licensing and settlement workflows; provider commercial callbacks
- `frontend/src/pages/Operations.jsx`: AdminActions(): payment queue and refunds; shared queue integration
- `frontend/src/components/Common.jsx`: Form/Action/Result and reusable props contracts
- `frontend/src/hooks/api.js`: Shared Redux-backed hooks and formatting exports
- `frontend/src/hooks/request.js`: JSON/upload transport integration
- `frontend/src/main.jsx`: Provider/router/lazy page integration
- `frontend/src/redux/store.js`: Central reducer/middleware integration
- `frontend/src/redux/routes.js`: Endpoint routing and targeted refresh integration
- `frontend/src/redux/hooks.js`: Subscriptions and operation-specific action hooks
- `frontend/src/redux/selectors/index.js`: Selector contracts
- `back-end/db.js`: Financial transaction review
- `back-end/seed.js`: Payment/commerce fixtures
- `tests/redux-api.test.js`: Full-stack integration harness

### React concepts, APIs and live changes

Plans keeps native checkout state local while payment Thunks own backend communication. Commerce forms control accept/counter/reject values and settlement references. Common Form/Action/Result demonstrate props and callback reuse. Shared effects/subscriptions connect the store; payment/commerce/theme and middleware are coordinated with the security owner.

APIs: `/plans`, `/payments`, `/payments/:id/demo`, `/payments/:id/reconcile`, `/admin/payments/:id/refund`, `/commerce`, `/commerce/:id/decision`, `/commerce/:id/earning`, `/settlements/:id/paid`.

1. Add a pending-payment count selector.
2. Add a controlled settlement-status filter.
3. Improve payment-reconciliation retry feedback in demo mode.
4. Show proposal decision loading independently.
5. Test a rejected refund preserving recorded payment data.


### Additional primary configuration/documentation files

- `.gitignore`
- `.node-version`
- `.nvmrc`
- `package-lock.json`
- `package.json`
- `vitest.config.js`


### Exact PowerShell commands for future genuine work

These commands were **not** executed to fabricate five commits. Run from a clean worktree when the member is ready to work; preserve any unrelated edits and stage only reviewed hunks. No change means no commit.

```powershell
Set-Location -LiteralPath 'C:\Users\mohan sai praneeth\Music\IndAI_Redux\IndAI\New_33_IndAI_React'
git status --short
$memberBranch = 'feature/gurwinder-s24-reviewed-work'
if (git branch --list $memberBranch) { git switch $memberBranch } else { git switch -c $memberBranch redux-migration }
# Perform and review an actual change first. Run these staging commands only
# for genuine work by this member, with their authorization.
$ownedPaths = @(
    '.gitignore',
    '.node-version',
    '.nvmrc',
    'back-end/routes/payments.js',
    'back-end/routes/provider.js',
    'back-end/services/payments.js',
    'frontend/index.html',
    'frontend/src/components/Icon.jsx',
    'frontend/src/components/ThemeToggle.jsx',
    'frontend/src/hooks/useTheme.jsx',
    'frontend/src/pages/Plans.jsx',
    'frontend/src/redux/slices/commerceSlice.js',
    'frontend/src/redux/slices/paymentSlice.js',
    'frontend/src/redux/slices/themeSlice.js',
    'frontend/src/redux/utilities/requests.js',
    'frontend/src/redux/utilities/resourceState.js',
    'frontend/src/redux/utilities/runtime.js',
    'frontend/src/redux/utilities/session.js',
    'frontend/src/style.css',
    'frontend/vite.config.js',
    'package-lock.json',
    'package.json',
    'scripts/Stage-Migration.ps1',
    'scripts/Summarize-Contributions.ps1',
    'scripts/Test-StagedSecrets.ps1',
    'scripts/check-catalog-ui.js',
    'scripts/dev.js',
    'scripts/smoke.js',
    'tests/browser.js',
    'tests/redux.test.js',
    'vitest.config.js'
)
git --literal-pathspecs add -- @ownedPaths
git add -p -- 'frontend/src/pages/Provider.jsx' # stage only the assigned reviewed functions
git add -p -- 'frontend/src/pages/Operations.jsx' # stage only the assigned reviewed functions
git add -p -- 'frontend/src/components/Common.jsx' # stage only the assigned reviewed functions
git add -p -- 'frontend/src/hooks/api.js' # stage only the assigned reviewed functions
git add -p -- 'frontend/src/hooks/request.js' # stage only the assigned reviewed functions
git add -p -- 'frontend/src/main.jsx' # stage only the assigned reviewed functions
git add -p -- 'frontend/src/redux/store.js' # stage only the assigned reviewed functions
git add -p -- 'frontend/src/redux/routes.js' # stage only the assigned reviewed functions
git add -p -- 'frontend/src/redux/hooks.js' # stage only the assigned reviewed functions
git add -p -- 'frontend/src/redux/selectors/index.js' # stage only the assigned reviewed functions
git add -p -- 'back-end/db.js' # stage only the assigned reviewed functions
git add -p -- 'back-end/seed.js' # stage only the assigned reviewed functions
git add -p -- 'tests/redux-api.test.js' # stage only the assigned reviewed functions
powershell -NoProfile -File 'scripts/Test-StagedSecrets.ps1'
git diff --cached --check
git diff --cached --stat
git diff --cached --name-status
git diff --cached
npm test
npm run build
npm run test:trading-ui
npm run test:e2e
# The integrator is the committer; --author is allowed only for verified genuine work.
git -c user.name='Praneeth' -c user.email='174439533+me-coder7@users.noreply.github.com' commit --author='Gurwinder <gaurav98498@gmail.com>' -m 'feat(billing): improve reviewed checkout commerce and integration'
git log -1 --format="%h | author=%an <%ae> | committer=%cn <%ce> | %s"
```


## Identity handling and genuine collaboration

The command blocks retain the actual integrator as committer and name a teammate as author only for real work they performed and authorized. When a teammate personally makes their commit, they may instead set repository-local user.name/user.email to their own verified identity, then restore the integrator's local identity afterward. Do not change global settings. The GitHub account used to push is independent of both metadata fields; no teammate password or token is required for attribution.

Use a Co-authored-by trailer only when the named people actually developed the same change and agreed to attribution. Shared files use function-level review and git add -p, not competing full-file replacements. Do not claim any proposed future exercise as completed work.

The Contributors graph generally reflects commits merged into the default branch and linked account emails; cached results can lag. See [GitHub's contributor documentation](https://docs.github.com/en/enterprise-cloud%40latest/repositories/viewing-activity-and-data-for-your-repository/viewing-a-projects-contributors), [email and branch contribution rules](https://docs.github.com/en/account-and-profile/how-tos/contribution-settings/troubleshooting-missing-contributions), and [statistics cache behavior](https://docs.github.com/en/rest/metrics/statistics).


## Confirmed module ownership and prepared work branches

The coordinator explicitly confirmed the following allocation. These local branches start from the current merged Redux main; creating a branch does not add a commit or establish authorship.

| GitHub account | Module | Local work branch |
| --- | --- | --- |
| Jeswanth09052007 | Learner | `feature/learner-jeswanth` |
| me-coder7 | Instructor | `feature/instructor-praneeth` |
| Purvaj-P22 | Course Provider | `feature/course-provider-purvaj` |
| BharanRajP | User Admin + Super Admin | `feature/admin-bharan` |
| gurwinder-s24 | Payment Admin | `feature/payments-gurwinder` |

Each member implements or meaningfully revises their module's agreed change and authorizes their commit. Existing imported code is not retroactively attributed to five names. Shared Provider, Operations, Quizzes, Guidance and infrastructure files retain function-level coordination and partial staging.

The draft `.github/CODEOWNERS` mirrors this allocation. GitHub uses CODEOWNERS from a pull request's base branch and requires listed owners to have write access. Those access settings have not been verified or changed here. This draft must be reviewed and committed before it can take effect on GitHub.

See [TEAM_COMMIT_PLAN.md](TEAM_COMMIT_PLAN.md) for the current detailed primary/shared file lists, actual exports, partial-staging scopes, and executable per-member commit commands. The plan does not assert new teammate authorship.
