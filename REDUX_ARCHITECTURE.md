> Scope note: this earlier document compares the supplied intermediate Express/React application with its Redux migration. For the actual NestJS/JSON GitHub baseline, current clone verification, one nonfunctional trailing-space cleanup, preserved history and honest attribution, read [GITHUB_MIGRATION_REPORT.md](GITHUB_MIGRATION_REPORT.md). It is not a claim that the GitHub backend was unchanged.

# IndAI Redux architecture — version 3.0.0

## 1. Scope and the architecture before migration

The extracted application was version 2.0.0. `main.jsx` created a TanStack QueryClient; `hooks/api.js` implemented `useResource` using useQuery and `useAction` using useMutation. Successful writes invalidated the entire Query cache. Authentication, orders, Razorpay requests, quiz submission/authoring, password changes and media uploads also made direct requests in UI code. Theme used Context and the active watchlist used component state.

The original routes, components, CSS, forms, responsive trading workspace, chart rendering, session cookies, Express routes, eight SQLite migrations, catalogue and bundled reference media remain. No backend source, database schema, permission or financial calculation was changed. The input was already extracted in `react/IndAI`; there was no input ZIP to re-extract in this workspace.

## 2. Architecture after migration

```text
React event/effect
  -> dispatch(named createAsyncThunk)
  -> hooks/request.js transport
  -> existing Express endpoint and authorization
  -> existing SQLite transaction/service
  -> JSON response
  -> pending / fulfilled / rejected feature reducers
  -> Redux store
  -> useSelector / memoized selectors
  -> existing UI and reusable child props
```

Toolkit reduces handwritten store configuration and uses Immer for immutable reducer updates. React Redux connects the store to React. Thunk is the default Toolkit middleware for asynchronous workflows; this project deliberately uses explicit createAsyncThunk operations. There is no RTK Query and no remaining TanStack Query dependency, import, provider or alternative application cache.

## 3. Complete Redux directory

```text
frontend/src/redux/
    hooks.js
    routes.js
    selectors/index.js
    slices/authSlice.js
    slices/commerceSlice.js
    slices/courseSlice.js
    slices/dashboardSlice.js
    slices/guidanceSlice.js
    slices/marketSlice.js
    slices/notificationSlice.js
    slices/paymentSlice.js
    slices/portfolioSlice.js
    slices/quizSlice.js
    slices/resourceSlice.js
    slices/supportSlice.js
    slices/taskSlice.js
    slices/themeSlice.js
    slices/tradingSlice.js
    slices/userSlice.js
    slices/watchlistSlice.js
    store.js
    utilities/requests.js
    utilities/resourceState.js
    utilities/runtime.js
    utilities/session.js
```

## 4. State shape and ownership

There are 17 feature slices plus a small session-generation marker. Each functional slice owns `resources` and `operations`. These are two kinds of state within that feature, not separate application-wide caches.

```js
course: {
  resources: {
    '/courses': { data: [/* backend rows */], status: 'fulfilled', error: null, updatedAt: 0 },
    '/courses/42': { data: {/* backend detail */}, status: 'fulfilled', error: null, updatedAt: 0 }
  },
  operations: {
    'component-operation-id': { status: 'pending', error: null, requestId: '...' }
  }
}
```

`resourceKey` sorts query parameters and treats page zero consistently. Different member filters, pagination, course IDs, quote symbol sets and candle ranges have independent keys. A failed/late response for one key cannot populate another key. Backend list and detail endpoints are intentionally stored as their respective projections; there is no additional copied entities array. Reusable children receive their selected Redux data through props. Server projections embedded in member details or account responses retain the backend response format.

`routes.js` is a readable endpoint-to-feature and endpoint-to-named-thunk table verified against the backend. It rejects unmapped writes. Admin queue resources go to the corresponding feature: members/staff to user, payments to payment, review to course, tickets to support and audit to dashboard. Course licensing endpoints go to commerce, not course. Both user-admin and payment-admin study responsibilities use the existing unified backend `admin` role.

| Slice | Purpose |
| --- | --- |
| `authSlice.js` | Current session, login, verification, registration, recovery and password changes. |
| `commerceSlice.js` | Provider workspace, licensing proposals, decisions, recorded earnings and external settlements. |
| `courseSlice.js` | Course lists/details, draft CRUD, lessons, enrollment, progress and review queues. |
| `dashboardSlice.js` | Public configuration, health/readiness and administrative audit projections. |
| `guidanceSlice.js` | Specialist directory, requests, active relationships, instructor roster and paper-fund awards. |
| `marketSlice.js` | Stock catalogue, parameterized quotes, single instruments and candle histories. |
| `notificationSlice.js` | Inbox, unread count, read/open actions, broadcast preview and broadcast submission. |
| `paymentSlice.js` | Billing overview, demo/live checkout requests, reconciliation, renewal and admin refund records. |
| `portfolioSlice.js` | Backend paper account, positions, ledger and append-only trading journal. |
| `quizSlice.js` | Quiz lists/details, authoring, drafts, publication, final attempts and written-answer grading. |
| `resourceSlice.js` | Authorized media metadata, raw upload and resource-link deletion. |
| `supportSlice.js` | Tickets, replies, closure and the administrator support queue. |
| `taskSlice.js` | Assignments, submissions, reviews, provider milestones and learning plans. |
| `themeSlice.js` | Shared light/dark preference. Only this preference is stored in localStorage. |
| `tradingSlice.js` | Orders, order outcomes, cancellation and paper-account reset. No editable executed trades. |
| `userSlice.js` | Member lists/details, account status, staff creation, approvals, permissions and member notes. |
| `watchlistSlice.js` | Watchlist lists, CRUD operations and shared active watchlist ID. |

## 5. CRUD and asynchronous lifecycle inventory

Every functional slice has named createAsyncThunk exports and a builder callback with explicit pending, fulfilled and rejected registrations. Transport and repetitive lifecycle assignments are shared in short utilities; the feature ownership, named operations, synchronous reducer exports and lifecycle cases remain visible in each slice.

The `set...` reducers replace an authoritative resource snapshot. `add...`, `update...Record` and `remove...` reducers modify already loaded server collections; their payload is `{path,item}` or `{path,id}`. Composite resources can specify `collection`, for example `{path:'/tasks',collection:'assignments',item}`. Member lists use their `members` array and notification pages use `items`. A member detail update can update its nested `user`. These synchronous reducers are useful when a caller has a complete, verified server record; they perform no I/O.

The normal application write flow uses named mutation thunks and targeted authoritative refetching. Most existing POST/PUT/DELETE endpoints return only `{id}` or `{ok:true}`, not full records. The UI therefore does not manufacture a course, financial balance, settlement or watchlist from incomplete local form values. A successful write invalidates only the affected feature resources; mounted consumers refetch them, and their read fulfilled reducers replace the snapshots. This is the CRUD reconciliation path used in normal UI operation. The standalone synchronous CRUD reducers are also directly regression tested.

Deletes are exposed only where the backend supports them: draft courses (or backend-controlled archive for published courses), watchlists and resource links. There is no delete-user API, delete-payment API, editable completed trade or arbitrary settlement deletion. Tasks, journal, quiz and financial records use only their supported create/update/state-transition workflows.

### authSlice

Purpose: Current session, login, verification, registration, recovery and password changes.

Public synchronous reducers: `setCurrentUser, resetCurrentUser`. Each functional slice also exposes `invalidate`, `clearError` and `clearOperation` through its feature actions object.

Named async thunks: `fetchCurrentUser`, `loginUser`, `registerUser`, `verifyEmail`, `resendVerification`, `requestRecovery`, `resetPassword`, `logoutUser`, `changePassword`, `resubmitApplication`.

### commerceSlice

Purpose: Provider workspace, licensing proposals, decisions, recorded earnings and external settlements.

Public synchronous reducers: `setCommerce, resetCommerce`. Each functional slice also exposes `invalidate`, `clearError` and `clearOperation` through its feature actions object.

Named async thunks: `fetchCommerce`, `submitProposal`, `respondToProposal`, `decideProposal`, `recordProviderEarning`, `recordProviderSettlement`.

### courseSlice

Purpose: Course lists/details, draft CRUD, lessons, enrollment, progress and review queues.

Public synchronous reducers: `setCourses, addCourse, updateCourseRecord, removeCourse, resetCourses`. Each functional slice also exposes `invalidate`, `clearError` and `clearOperation` through its feature actions object.

Named async thunks: `fetchCourses`, `createCourse`, `updateCourse`, `deleteCourse`, `createLesson`, `submitCourse`, `reviewCourse`, `enrollCourse`, `completeLesson`.

### dashboardSlice

Purpose: Public configuration, health/readiness and administrative audit projections.

Public synchronous reducers: `setDashboard, resetDashboard`. Each functional slice also exposes `invalidate`, `clearError` and `clearOperation` through its feature actions object.

Named async thunks: `fetchDashboard`.

### guidanceSlice

Purpose: Specialist directory, requests, active relationships, instructor roster and paper-fund awards.

Public synchronous reducers: `setGuidance, addGuidance, updateGuidanceRecord, resetGuidance`. Each functional slice also exposes `invalidate`, `clearError` and `clearOperation` through its feature actions object.

Named async thunks: `fetchGuidance`, `requestGuidance`, `decideGuidance`, `awardPaperFunds`.

### marketSlice

Purpose: Stock catalogue, parameterized quotes, single instruments and candle histories.

Public synchronous reducers: `setMarketData, resetMarketData`. Each functional slice also exposes `invalidate`, `clearError` and `clearOperation` through its feature actions object.

Named async thunks: `fetchMarketData`.

### notificationSlice

Purpose: Inbox, unread count, read/open actions, broadcast preview and broadcast submission.

Public synchronous reducers: `setNotifications, addNotification, updateNotificationRecord, resetNotifications`. Each functional slice also exposes `invalidate`, `clearError` and `clearOperation` through its feature actions object.

Named async thunks: `fetchNotifications`, `markNotificationRead`, `openNotification`, `markAllNotificationsRead`, `broadcastNotification`.

### paymentSlice

Purpose: Billing overview, demo/live checkout requests, reconciliation, renewal and admin refund records.

Public synchronous reducers: `setPayments, resetPayments`. Each functional slice also exposes `invalidate`, `clearError` and `clearOperation` through its feature actions object.

Named async thunks: `fetchPayments`, `createPayment`, `confirmDemoPayment`, `reconcilePayment`, `discardDemoPayment`, `endRenewal`, `requestRefund`.

### portfolioSlice

Purpose: Backend paper account, positions, ledger and append-only trading journal.

Public synchronous reducers: `setPortfolio, addJournalEntry, resetPortfolio`. Each functional slice also exposes `invalidate`, `clearError` and `clearOperation` through its feature actions object.

Named async thunks: `fetchPortfolio`, `createJournalEntry`.

### quizSlice

Purpose: Quiz lists/details, authoring, drafts, publication, final attempts and written-answer grading.

Public synchronous reducers: `setQuizzes, addQuiz, updateQuizRecord, resetQuizzes`. Each functional slice also exposes `invalidate`, `clearError` and `clearOperation` through its feature actions object.

Named async thunks: `fetchQuizzes`, `createQuiz`, `updateQuiz`, `publishQuiz`, `archiveQuiz`, `saveQuizDraft`, `submitQuiz`, `gradeQuiz`.

### resourceSlice

Purpose: Authorized media metadata, raw upload and resource-link deletion.

Public synchronous reducers: `setResources, addResource, removeResource, resetResources`. Each functional slice also exposes `invalidate`, `clearError` and `clearOperation` through its feature actions object.

Named async thunks: `fetchResources`, `uploadResource`, `deleteResource`.

### supportSlice

Purpose: Tickets, replies, closure and the administrator support queue.

Public synchronous reducers: `setSupportTickets, addTicket, updateTicketRecord, resetSupportTickets`. Each functional slice also exposes `invalidate`, `clearError` and `clearOperation` through its feature actions object.

Named async thunks: `fetchSupportTickets`, `createSupportTicket`, `replyToTicket`, `closeTicket`.

### taskSlice

Purpose: Assignments, submissions, reviews, provider milestones and learning plans.

Public synchronous reducers: `setTasks, addTask, updateTaskRecord, resetTasks`. Each functional slice also exposes `invalidate`, `clearError` and `clearOperation` through its feature actions object.

Named async thunks: `fetchTasks`, `createAssignment`, `createMilestone`, `saveLearningPlan`, `submitAssignment`, `reviewSubmission`, `updateMilestone`.

### themeSlice

Purpose: Shared light/dark preference. Only this preference is stored in localStorage.

Public synchronous reducers: `setTheme, toggleTheme`. Each functional slice also exposes `invalidate`, `clearError` and `clearOperation` through its feature actions object.

Named async thunks: none; this is synchronous UI state.

### tradingSlice

Purpose: Orders, order outcomes, cancellation and paper-account reset. No editable executed trades.

Public synchronous reducers: `setOrders, resetOrders`. Each functional slice also exposes `invalidate`, `clearError` and `clearOperation` through its feature actions object.

Named async thunks: `fetchOrders`, `placeOrder`, `cancelOrder`, `resetPaperAccount`.

### userSlice

Purpose: Member lists/details, account status, staff creation, approvals, permissions and member notes.

Public synchronous reducers: `setUsers, addUser, updateUserRecord, resetUsers`. Each functional slice also exposes `invalidate`, `clearError` and `clearOperation` through its feature actions object.

Named async thunks: `fetchUsers`, `createUser`, `updateUser`, `updateUserStatus`, `updatePermissions`, `revokeSessions`, `startMemberRecovery`, `addMemberNote`, `decideApplication`, `decideStaff`, `suspendUser`.

### watchlistSlice

Purpose: Watchlist lists, CRUD operations and shared active watchlist ID.

Public synchronous reducers: `setWatchlists, addWatchlist, updateWatchlistRecord, removeWatchlist, setActiveWatchlist, resetWatchlists`. Each functional slice also exposes `invalidate`, `clearError` and `clearOperation` through its feature actions object.

Named async thunks: `fetchWatchlists`, `createWatchlist`, `updateWatchlist`, `deleteWatchlist`.


## 6. Request lifecycle, errors and concurrent operations

`readPending` preserves existing displayed data during refresh and records the requestId. `readFulfilled` accepts only the matching request and an unchanged invalidation revision, stores data and its completion timestamp, then clears errors. `readRejected` retains existing data, stores only a serializable error and marks failed market data unsafe. An older request that began before a successful write is ignored after its resource is invalidated.

Write statuses live under per-component operation IDs. Two operations do not share one loading flag. A rejected write leaves existing domain records intact. `rejectWithValue` carries `{message,status,code,fields}`; raw Error objects are not stored. `dispatch(thunk(...)).unwrap()` lets forms display the exact failure for their own submission. Existing Result, ErrorText, loading text and retry buttons remain.

## 7. Selectors, dispatch and components

`Courses.jsx` and `Trading.jsx` explicitly call useSelector with `selectResource`, while `useResourceSubscription` handles only lifecycle subscriptions. `Auth.jsx` explicitly dispatches loginUser/registerUser/verifyEmail and the other named auth thunks. `useWatchlists.js` explicitly selects the shared active list and dispatches setActiveWatchlist. `OrderTicket.jsx` selects the result through the Redux-backed action hook and explicitly names placeOrder.

The retained `useResource` and `useAction` exports in `hooks/api.js` are compatibility names for actual Redux hooks in `redux/hooks.js`. They contain no alternate cache. The read hook subscribes with an effect, selects the resource from its owning feature, and returns the existing loading/error interface. The write hook resolves the supported named thunk, dispatches it and unwraps it. This keeps all existing reusable forms and Action controls while making Redux their only data source.

`selectCurrentUser`, `selectResource`, `selectOperation`, `selectTheme`, `selectWatchlists`, `selectActiveWatchlist` and the quote selector factory are in `redux/selectors/index.js`. createSelector memoizes the shared active-watchlist derivation and stale quote transformation. Components still use props and callbacks for reusable UI communication.

## 8. Store, Provider and transport

`createAppStore` uses configureStore with all feature reducers and Toolkit's default middleware, including Thunk, mutation checks and serializability checks. The runtime is injected using the Thunk extra argument. DevTools is enabled only for Vite development builds. The exported application store is the one primary store; the factory creates independent stores in tests.

`main.jsx` wraps ThemeProvider, BrowserRouter, Suspense and the original route tree in `<ReduxProvider store={store}>`. The alias avoids colliding with the existing Course Provider page component. StrictMode, lazy pages, role gates, nested outlets, paths and redirects are retained.

`hooks/request.js` is the refactored reusable API transport. `hooks/api.js` retains the INR/date formatting utilities. Requests preserve same-origin cookies, JSON serialization, HTTP verbs, first-party security headers, abort composition, timeout handling and backend errors. Raw uploads preserve MIME and encoded filename headers, with a bounded 120-second upload timeout; ordinary requests retain the 12-second timeout. Binary media viewing uses authorized browser links/video streams as before; it is not another JSON-data cache.

## 9. Polling and market correctness

The per-store runtime owns timers and promises outside Redux. Consumers of the same canonical URL share one in-flight request and one timer. It chooses the shortest requested interval. A timer waits for its request to settle before scheduling the next tick; slow responses cannot overlap another request for the same resource. Subscription cleanup clears its timer, and the last subscriber stops polling. An already-started read may finish for StrictMode remount coordination; its timeout bounds it. Logout/session reset aborts tracked reads and invalidates all other old-session completions.

Preserved intervals: quotes 2 seconds, current-day candles 5 seconds, other candles 60 seconds, account 2 or 5 seconds depending on the screen, orders 5 seconds, current user 30 seconds, notifications and unread count 15 seconds. The catalogue is separate, requests no quotes itself and has a one-hour mount freshness window with focus refresh disabled. Hidden explorer watchlists do not create a quote poller.

Quotes are marked stale and non-executable after a feed failure or ten seconds without a fresh successful response. They remain non-executable during a failed feed's retry until success. Selection/range changes select different store keys without retaining another symbol's display data. Chart instances, crosshair selection, full-screen DOM handling and refs remain in the component; all underlying candles and quotes originate in Redux. Existing chart transformations and viewport preservation remain.

OrderTicket retains backend-authoritative pricing, fees, balance reservation, order types, protections and replay scoping. A synchronous ref prevents same-tick duplicate submits; the same clientKey is reused for retrying identical content. The backend remains responsible for quote validity, execution, financial arithmetic and final idempotency.

## 10. Authentication, isolation and private values

Login/verification pending resets account data before new-session work. Their successful thunks retrieve `/me`. Failed authentication remains a rejected operation with backend fields intact. Logout clears account-specific slices only after server logout succeeds. A 401 from a previously authenticated `/me` clears private slices and retains the routing error. A changed ID discovered by `/me` also clears the previous account's state.

Each reset advances a runtime epoch. Read and write workers reject obsolete completions, even if a transport ignores cancellation. RequestId checks prevent old fulfilled/rejected actions from overwriting newer requests. Theme and public `/config` can survive a reset; private resources and operation results cannot. No sensitive application state is persisted to localStorage.

Passwords, staff authenticator secrets, receipt signatures and raw File objects go through a one-use transport mailbox outside Redux. Action metadata contains only an opaque request token, endpoint, method and operation ID. Tokens are consumed before transport and discarded after hook completion. The mailbox is not persistence or authentication state. Session tokens remain in HTTP cookies managed by the existing backend. No raw Error, File, timer, promise, callback, chart or DOM node is stored in Redux.

## 11. React concepts retained

useState still holds controlled search/filter inputs, editable quiz answers/questions, dialog visibility, selected chart mode and form editing state. Editable drafts are intentional form values, not a second live server cache. React Hook Form still manages complex forms. useEffect subscribes and cleans polling, synchronizes theme/DOM and manages dialogs/charts; it does not loop on newly created options objects. useRef retains external chart/DOM handles and duplicate-submit guards. useMemo still handles relevant transforms, while shared derivations use selectors. Parent props, child callbacks, event.preventDefault, validation and route parameters remain visible in the original components.

The illustrative public HomePreview and static labels/plan descriptions remain UI constants; backend-owned application data flows through Redux. Temporary success notices and native checkout/dialog state remain UI state.

## 12. Redux and SQLite

Redux is the current browser session's display/request state. SQLite is the durable, authoritative database. Refreshing the browser creates a fresh store and retrieves the existing cookie session and backend records. Refresh does not reseed or reset an account. No backend route, schema, migration, balance calculation, access hierarchy or provider integration was changed by this migration.

## 13. Five-member preparation and coordination

This is a proposed work/study allocation, not a claim of authorship. See REDUX_VIVA_GUIDE.md for actual files and five live edits per person. Member 1: trading/market/watchlist/portfolio. Member 2: guidance/task/quiz. Member 3: course/resource. Member 4: auth/user/support/notification and store integration. Member 5: payment/commerce. Share dashboard/theme, selectors, hooks, routes and transport changes through review. A feature has one slice even when several actors use it. User Admin and Payment Admin are separate study responsibilities mapped to the backend's existing unified Admin permissions.

## 14. Verification and limitations

On 2026-11-26, the migration passed the 68-test suite (48 existing + 20 new), production build, isolated setup, dev/production smoke checks, catalogue server-rendering check, full existing end-to-end browser suite and targeted trading browser suite. Later release checks are recorded in docs/redux-verification.json and REDUX_MIGRATION_REPORT.md.

All API and browser scenarios use isolated SQLite databases and demo/simulated financial modes. Hosted Razorpay checkout/refunds, live Upstox entitlements/exchange execution, real bank transfer references and SMTP delivery require the operator's own test accounts and environment. They were not exercised with private supplied credentials or real financial transactions. The original private `.env` and database stay on the user's machine and are excluded from the release ZIP. Recreate local demo data with npm run setup. No automated screenshot pixel-diff against a prior build was performed; CSS hashes are unchanged and existing browser layout checks pass.
