# IndAI 3.0.0 — Redux Toolkit + Thunk edition

This is the complete frontend architecture migration of the supplied IndAI 2.0.0 project. The original UI, Express backend, SQLite migrations, financial services and permissions are retained. All application JSON/media-upload requests originate in named Redux Thunks; React reads backend domain data from feature slices. React Query has been removed.

## Install and run

Use **Node.js 24 or newer** and npm. Extract `IndAI_Redux.zip`, open its `IndAI` folder in VS Code, then run:

```powershell
npm install
npm run setup
npm run dev
```

Open **http://localhost:5173**. Setup copies `.env.example` to `.env` if absent and creates a local demo SQLite database in `data/`. It applies all existing migrations and installs the bundled catalogue. The ZIP contains migrations/seeding logic, not private runtime database contents. An existing local `.env` is not overwritten; choose `DEMO_MODE=true` and `MARKET_SOURCE=demo` for offline academic verification. Never run seeding/reset exercises against your only production database.

Demo password: **IndAI-Demo-2026**. Quick-login buttons cover Free (`student1@indai.test`), Pro (`student201@indai.test`), Plus (`student261@indai.test`), Instructor (`instructor1@indai.test`), Course Provider (`provider1@indai.test`), Admin (`users@indai.test`) and Super Admin (`super@indai.test`). User Admin and Payment Admin responsibilities share the existing unified `admin` permissions; no new actor or permission was introduced.

For the built application:

```powershell
npm run build
npm start
```

Open **http://localhost:3000** for the default built server. For deployment set PUBLIC_URL to the actual origin and configure the existing production requirements described below. The development command serves Vite on PUBLIC_URL's port and proxies `/api` to PORT (3000 by default).

## GitHub integration and team work

The migration is prepared on `redux-migration` in the existing repository. `main` and the annotated `pre-redux-82fbbea` tag preserve the original implementation. This supplied Express/SQLite application replaces the old NestJS/JSON architecture; it does not automatically migrate old accounts/data or retain every old institution/scheduling workflow. Review the compatibility notes before approving a merge.

See [GITHUB_MIGRATION_REPORT.md](GITHUB_MIGRATION_REPORT.md) for measured differences, executed checks, version references and exact PowerShell commands. [TEAM_CONTRIBUTIONS.md](TEAM_CONTRIBUTIONS.md) documents genuine historical credit, proposed React-focused ownership and per-member viva preparation. The import is honestly attributed to its authorized integrator with AI assistance disclosed; proposed ownership does not imply authorship of imported code.

## Redux documentation and verification

- [REDUX_ARCHITECTURE.md](REDUX_ARCHITECTURE.md): complete slices, CRUD, named Thunks, request lifecycles, polling, session isolation and ownership.
- [REDUX_VIVA_GUIDE.md](REDUX_VIVA_GUIDE.md): React/Redux definitions, actual examples, viva questions and five live modifications per member.
- [REDUX_MIGRATION_REPORT.md](REDUX_MIGRATION_REPORT.md): exact changes, dependencies, actual verification and genuine Git migration procedure.
- [docs/redux-verification.json](docs/redux-verification.json): machine-readable final command results.

```powershell
npm test
npm run build
npm run test:smoke
npm run test:catalog-ui
npx playwright install chromium
npm run test:e2e
npm run test:trading-ui
```

Verification uses isolated databases and simulated funds. Do not initiate real payments for academic tests. Hosted Razorpay, live Upstox access, SMTP and real external transfers need separately configured operator test accounts; those services were not claimed as verified by this migration. Private `.env`, tokens, administrator secrets, data directories, node_modules, screenshots and build output are excluded from the ZIP. Only non-sensitive theme preference is persisted by the frontend.

The remaining sections retain the supplied feature and operations guide; current migration results are in the documents above. Earlier environment-specific integration statements in inherited docs describe the original project, not new verification claims.

---

# IndAI

IndAI is a React JavaScript and Express platform for trading education, instructor guidance, and simulated NSE equity trading. Pages, components, hooks, routes, services, migrations, and tests are separated into their respective folders.

## Run locally

Install Node.js 24 LTS. Extract this update into a **new folder** to get the revised initial data. Open a terminal inside the extracted IndAI folder and run the following commands.

```powershell
npm install
npm run setup
npm run dev
```

Open [http://localhost:5173](http://localhost:5173). The homepage links to registration and login. Demo login includes all learner plans, instructors, course providers, Admin, and Super Admin. Workspaces open at /overview.

Setup applies SQL migrations and seeds a fresh database. Existing databases are preserved, so their member distributions and historical relationships retain their existing values. The local setup runs without Docker, SMTP, or a separate database server.

To run the built frontend with the API, stop development processes and run these commands.

```powershell
npm run build
npm start
```

Open [http://localhost:3000](http://localhost:3000). The built server supports direct route refresh and structured API 404 responses.

## Demo data and passwords

Every fictional demo account uses **IndAI-Demo-2026**.

| Account | Email | Initial paper funds |
| --- | --- | --- |
| Free learner | student1@indai.test | ₹1,00,000 |
| Pro learner | student201@indai.test | ₹1,50,000 |
| Plus learner | student261@indai.test | ₹2,00,000 |
| Pending learner | student4@indai.test | Access awaits approval |
| Instructor | instructor1@indai.test | ₹10,00,000 |
| Course provider | provider1@indai.test | — |
| Admin | users@indai.test | — |
| Super admin | super@indai.test | — |

The initial dataset has **352 accounts**, consisting of 300 learners, 32 instructors, 18 course providers, one Admin, and one Super Admin.

| Learner email range | Plan | Count |
| --- | --- | --- |
| student1 through student200 @indai.test | Free | 200 |
| student201 through student260 @indai.test | Pro | 60 |
| student261 through student300 @indai.test | Plus | 40 |

Free is displayed in the interface and stored as basic in the API. Some Free accounts are pending, rejected, or suspended to demonstrate approval workflows. The initial paid plans have active demo entitlements.

Instructor rosters vary from zero to five active learners. Instructor1 has student261 through student265. Pro learners can request course providers. Plus learners can request course providers and instructors. Instructor2 has four learners, Instructor5 has three, Instructor6 has two, Instructor7 has one, and Instructor8 has zero. Use Guidance or My learners to inspect each roster. The first 12 instructors and 40 learners have sample paper histories. The catalog includes enrollments, lesson progress, assignments, submissions, feedback, learning plans, milestones, and quizzes.

## Member administration

Admin and Super Admin can open **All members**, search and filter every role, and select a member.

The member record includes profile and account state, paper portfolio, orders, cash ledger, watchlists, journal, course levels and progress, assignments and feedback, quiz results, teaching rosters, authored courses and quizzes, learning plans, milestones, payment records, provider settlements, notes, and activity. Long lists are paginated.

Member actions include editing contact and specialist profile data, approving or rejecting pending accounts, suspending, archiving, restoring access, revoking sessions, starting password recovery, adding internal notes, and explicitly ending relationships. Reasons are recorded. Admin manages ordinary learner and staff accounts. Super Admin manages privileged accounts and role permissions. Role changes require active relationships, paid learner terms, and open positions to be resolved as applicable. At least one approved Super Admin is retained.

Password hashes, session tokens, and MFA secrets are excluded from member detail responses.

## Paper funds

| Actor or plan | Initial funding |
| --- | --- |
| Free learner | ₹1,00,000 |
| Pro learner | ₹1,50,000 |
| Plus learner | ₹2,00,000 |
| Instructor | ₹10,00,000 |

These are simulated INR balances. The engine supports fully funded, long-only equity orders, reserved cash and shares, linked stop-loss and take-profit exits, a cash ledger, watchlists, portfolio, and a private journal. Working orders are processed in the server worker.

An instructor can award additional paper funds to an actively assigned eligible learner after reviewing a submission. Each learner can receive **up to ₹10,000 across the previous seven days**, including awards by previous instructors. Each reviewed submission may support one award. A reason and the work reference are retained in the award record, ledger, notification, and audit log.

Moving to a higher paid plan adds any missing initial funding when the account is next accessed. Expiry or downgrade preserves existing simulated account history and cash. Reset restores the highest funding already granted plus earned awards. Reset retains the award history and weekly cap.

## Courses, resources, and quizzes

Instructors and providers can create course drafts, organize lessons and modules, and submit content for administrator review. The provider has a separate **Provider workspace** with its owned catalog, commercial proposals, learner engagement counts, and settlement records.

Video and PDF resources can be attached optionally to courses, lessons, assignments, unreviewed learner submissions, and draft quizzes. Uploads accept PDF, MP4, and WebM up to 100 MB per file, with an extension and file-signature check. Resources are stored transactionally in SQLite and delivered only after authorization. Video playback supports byte ranges. Each item allows up to ten resources.

All seeded courses include the supplied PDF and video. The PDF is The Complete Guide to Trading from Corporate Finance Institute. The video demonstrates an external platform's short-selling workflow. It remains a reference resource while IndAI supports long-only equity practice.

Instructors can create an optional quiz linked to an assignment or a standalone quiz for selected active learners. Course providers create quizzes for their own courses. Quizzes support multiple-choice questions, short answers, long answers, required and optional questions, point values, deadlines, and draft authoring. Published quizzes accept one final response per learner. Learners can save a draft and return later. MCQs are scored automatically and written responses receive manual grades and feedback. Final scores are shown after grading.

Create an assignment first, then use its resource upload controls or Add optional assignment quiz. The same approach applies to courses, lessons, and quiz resources.

## Provider commercial workflow

A provider submits a one-time course licensing fee proposal. Payment Admin can accept, reject, or counteroffer. The provider accepts or declines a counteroffer. Content publication requires an agreed proposal and Super Admin approval.

After a course is published, Payment Admin records its agreed licensing earning once. A settlement can be marked paid using the reference of a completed external transfer. These are accounting records. Automatic bank transfers and payout-provider integration remain external to this build.

Support Admin and Super Admin use the support operations queue and ticket replies. They have no personal Help & support menu or ticket-creation form.

## Audit coverage

Successful state-changing API requests receive a persistent audit event with the actor, request path, status, correlation ID, and timestamp. Sensitive request bodies are excluded. Member profile, status and role changes, session revocation, member-record views, resource views, relationship interventions, paper executions, funding changes, commercial decisions, and scheduled guidance changes have additional event details. Super Admin can search and paginate the audit queue.

## Credentials and integrations

The release excludes private .env files. Setup copies the credential-free .env.example for an offline demo; configure integrations locally when needed.

| Setting | Use |
| --- | --- |
| RAZORPAY_KEY_ID, RAZORPAY_KEY_SECRET, RAZORPAY_WEBHOOK_SECRET | Server-created checkout orders, capture verification, and signed payment/refund webhooks |
| UPSTOX_ANALYTICS_TOKEN, optional UPSTOX_ACCESS_TOKEN | Upstox historical and quote APIs, subject to account access |
| MARKET_SOURCE | demo or upstox |
| PRO_PRICE_PAISE, PLUS_PRICE_PAISE | Server-owned paid term prices |
| SMTP_HOST, SMTP_PORT, SMTP_USER, SMTP_PASS, SMTP_FROM | Verification and recovery delivery outside demo mode |
| BOOTSTRAP_ADMIN_EMAIL, BOOTSTRAP_ADMIN_PASSWORD, BOOTSTRAP_ADMIN_TOTP_SECRET | Initial production Super Admin |
| DATA_DIR | Persistent database directory |

Supply SMTP and Upstox credentials only in your local environment. Subscription payments, licensing records and paper balances retain their independent backend lifecycles.

## Deployment and recovery

Use one application process with persistent storage. SQLite runs with WAL, foreign keys, synchronous writes, and transactional mutations. PostgreSQL, Prisma, Redis, and distributed workers remain deferred.

Set NODE_ENV=production, DEMO_MODE=false, MARKET_SOURCE=upstox, an HTTPS PUBLIC_URL, SMTP settings, and a separate DATA_DIR. Put the service behind one trusted HTTPS proxy. Production staff login requires a TOTP secret. Staff accounts can be provisioned from member administration or npm run staff:provision with the instructor, provider, or admin role.

The /api/health and /api/ready endpoints expose liveness and database/worker readiness. Provider failures appear on the corresponding screens. Back up the full data directory while the application is stopped or use SQLite's online backup mechanism. Restore into a separate directory and verify the restored service before switching traffic.

## Remaining verification and scope

Razorpay hosted checkout and refunds, Upstox account permissions, and SMTP delivery require checks against your accounts and deployment host. The Playwright suite and targeted trading UI checks passed using headless shell. See docs/verification.md for the verified scenarios and commands.

The complete NSE catalogue described below supersedes the early eight-equity sample. Demo prices are synthetic and labeled. Fills are full fills at a sampled quote with a 10 basis-point simulated fee rounded up to one paise. There is no separate slippage model. Validity is 24 hours or 30 days. Production media storage currently shares the SQLite database and requires storage-capacity planning.

Institution mode, backtesting, derivatives, short selling, separate course purchases, recurring bank debits, direct messaging, automatic bank payouts, and legacy-data import remain deferred.

## Verification commands

```powershell
npm test
npm run build
npm run test:smoke
npx playwright install chromium
npm run test:e2e
```

See docs/verification.md for the executed checks and docs/api.md for the endpoint map.


## This update

- Course Provider combines course content, licensing, Pro and Plus guidance, learning plans and milestones. Admin handles member operations, support, payments, and notifications. Super Admin also handles course review, the audit queue, and privileged account management. Existing User Admin and Payments Admin accounts retain their sign-ins and share the unified Admin permissions. Retired course/support admin accounts in existing databases are archived and their sessions revoked; coordinator accounts become providers with the same IDs and assignments.
- Quotes refresh every two seconds. Demo ticks and current candles share one price model; intraday charts refresh every five seconds without resetting the viewport. Upstox timestamps are parsed as ISO, milliseconds or seconds. Stale/unavailable quotes disable orders; real provider failures never switch silently to demo prices.
- Portfolio positions include direct Buy/Sell actions using the shared order ticket. Buy shares opens an instrument picker. The dialog supports Escape, focus restoration and mobile scrolling.
- Light/dark mode is available on public, authentication and workspace pages and remembered on this browser. Instructor1 and Instructor2 each own a default course with the bundled video and PDF in a fresh seed.
- Private environment values and runtime databases are excluded from the Redux release. See the Redux migration report for current verification.

Editable portfolio UX reference: https://www.figma.com/design/JInneEirdrNjbbvXzJMwMl


## Complete NSE equity catalogue

The ZIP bundles **2,779 NSE EQ-series equity instruments** from the official Upstox NSE instrument master. It replaces the eight-symbol sample list. Search by symbol or company name in Paper trading, or choose Change stock in the Portfolio order dialog. Results show 40 instruments per page; exact symbols appear first when searching. Ampersands, digits and hyphens in symbols work throughout chart links, watchlists and orders.

Setup and server startup install the bundled catalogue into both new and existing databases without resetting accounts, positions, orders or existing demo price anchors. No new environment values or API credentials are required to browse it locally. The safe .env.example defaults to MARKET_SOURCE=demo; opt into upstox in your private local environment. When the exchange is open it requests live Upstox quotes; when closed it replays each stock’s own most recent available five-minute candles. An explicit MARKET_SOURCE=demo remains available for offline simulated prices; those are not current market prices. Live Upstox quotes require a valid market-data token and provider entitlement.

Only selected stocks, the active watchlist and portfolio holdings request quotes. The catalogue is cached separately and does not trigger polling for every stock. Server quote requests use batches of 100 keys with at most four concurrent provider requests. A failed batch remains unavailable without replacing live prices with synthetic values.

To refresh the list for new listings, run `npm run stocks:sync` while the app is stopped, then restart it. This downloads the public master, validates NSE EQ instruments and duplicates, and retains the existing catalogue if download or validation fails. The catalogue snapshot is bundled for offline local setup. Source: https://upstox.com/developer/api-documentation/instruments/ . This update covers the platform's NSE cash-equity universe; BSE, derivatives and overseas exchanges are separate integrations.

Catalogue UI rendering check: `npm run test:catalog-ui`. API and domain checks: `npm test`.


## Trading explorer and closed-market replay

Paper trading now gives the chart and order ticket the full workspace. Open Stocks & watchlists (or the change-stock arrow) for a wide explorer drawer with Search stocks and Watchlists tabs. The tabs preserve the current search and selected watchlist. Company names flow across readable lines without fixed-height clipping. On smaller screens, the explorer drawer uses the screen width. Back to chart or Escape returns to the terminal.

Watchlists support creating and switching between up to 12 lists, each with up to 40 stocks. Select a stock, choose Save to a watchlist and Add to list. Rename and Delete list are visible actions. Reorder exposes Up/Down controls for each saved stock, and each row has a labelled remove button. Deleting a list requires an inline confirmation and preserves portfolio holdings and orders. Changes persist in the database.

With MARKET_SOURCE=upstox and MARKET_REPLAY_WHEN_CLOSED=true, an exchange status other than NORMAL_OPEN starts historical replay. Each stock loads its own recent intraday session, falling back through the previous two weeks when today's data is absent or sparse. The recorded candle closes advance every REPLAY_CANDLE_MS milliseconds (default 2,000), loop at the end, and switch back to live quotes after the exchange reports NORMAL_OPEN. The chart, portfolio and watchlist use the matching replay prices. The screen displays the recorded date, replay progress and loop count. Recorded timestamps remain separate from refresh timestamps.

Missing history or an unknown market status remains unavailable; it never borrows a different stock's candles or silently becomes synthetic data. Live orders cannot execute on replay prices. Replay orders and attached exits retain their recorded-session date and are cancelled when that replay session ends. The instrument catalogue is separate from the available historical feed: a newly listed or data-restricted stock can appear in search while its replay remains unavailable.

Configure MARKET_SOURCE=upstox and MARKET_REPLAY_WHEN_CLOSED=true locally to enable this integration. Credentials are not distributed. No real brokerage orders are placed; entitlements depend on the operator's Upstox account.


## Refined trading workspace

The primary trading view restores a large chart beside the order ticket on laptop and desktop screens. The instrument strip groups the full company name, quote, feed status and available paper cash. Search and watchlist management open in an accessible same-page drawer, keeping their selection and search state when closed; hidden watchlists do not poll quotes.

Chart controls include candlesticks or line view, 1D/1M/3M/1Y ranges, Reset chart view and full-screen expansion. Scroll zoom and drag-to-pan remain available. Quote refreshes preserve the viewport. Historical replay dates and source labels, all stock symbols, and every multi-watchlist operation remain available.
