# IndAI Redux viva guide

This guide explains the actual version 3.0.0 source. The five-member allocation is preparation guidance, not a fabricated contribution record.

## Core definitions with source examples

| Concept | Simple explanation | Actual example |
| --- | --- | --- |
| Component | A reusable function that renders part of the screen. | OrderTicket, Form, WatchlistRow, QuizAttempt. |
| Props | Values and callbacks a parent gives a child. | Trading gives instrument/account to OrderTicket; Watchlists passes onSelect/onMove/onRemove. |
| Child-to-parent communication | A child calls the callback supplied by its parent. | InstrumentPicker invokes onSelect; the parent changes the route symbol. |
| State | Data that determines what React renders. | Redux account records and local controlled quantity fields. |
| Event | An interaction handled by a function. | OrderTicket submit, watchlist remove, theme toggle. |
| Controlled form | Inputs whose values are driven by React state. | OrderTicket qty/side/type and QuizBuilderForm question editing. |
| React Hook Form | The existing form library for registration, validation and submissions. | Common.jsx Form calls useForm, register and handleSubmit. |
| useState | Local component state for interaction or editable input. | Chart range, dialog visibility, search fields and quiz answers. |
| useEffect | Work synchronized with mounting/dependencies, with cleanup. | useResourceSubscription installs a polling subscription and returns its unsubscribe function. |
| useRef | A mutable reference that does not itself cause a render. | CandleChart chart/DOM handles and OrderTicket synchronous submit guard. |
| useMemo | A retained calculation or object for stable dependencies. | useMarket creates one memoized quote selector per consumer. |
| Context | A value made available to descendants without passing every prop. | React Redux's Provider supplies its store through context; router outlets still supply the current user. |
| Redux store | Centralized application state with controlled updates. | redux/store.js registers 17 feature reducers and a session marker. |
| configureStore | Toolkit's store creation helper. | createAppStore installs reducers and default middleware with the runtime extra argument. |
| Slice | One feature's state, reducers, action creators and lifecycle handling. | watchlistSlice owns resource snapshots, operations and activeWatchlist. |
| createSlice | Defines a slice and generates its synchronous action creators. | setActiveWatchlist is generated from the watchlist reducer. |
| Action | A plain description of a state change, identified by type. | watchlist/setActiveWatchlist. |
| Payload | The useful data carried by an action. | The selected watchlist ID; a server response; a serializable error. |
| Reducer | A synchronous pure calculation of the next state. | setActiveWatchlist changes only state; it does not fetch or start timers. |
| Immer | Toolkit's mechanism for safely expressing immutable changes. | A reducer can assign state.activeWatchlist without mutating prior state. |
| CRUD | Create, Read, Update and Delete where the API allows them. | Course/watchlist/resource workflows; no arbitrary deletion of payments. |
| Thunk | An asynchronous workflow dispatched through middleware. | placeOrder talks to the server then emits its lifecycle action. |
| createAsyncThunk | Creates pending/fulfilled/rejected action types around an async function. | createCourse, loginUser, fetchCourses and recordProviderSettlement. |
| Middleware | Logic between dispatch and reducer handling. | Default Thunk executes functions; coordination middleware triggers targeted refresh after a successful write. |
| extraReducers | Reducer handling for actions defined outside the slice's synchronous reducer map. | builder.addCase(fetchCourses.fulfilled, readFulfilled). |
| useDispatch | Gives a React component the store dispatch function. | Auth.jsx dispatches the named auth thunk. |
| useSelector | Reads a selected value and subscribes React to changes. | Courses.jsx selects its parameterized course resource. |
| Selector | A function that reads or derives a value from state. | selectCurrentUser, selectResource and selectActiveWatchlist. |
| createSelector | Memoizes a derived selector based on its inputs. | Active watchlist selection and stale quote transformation. |
| Promise | A value representing future success or failure. | dispatch(thunk()) returns a promise-like result with unwrap/abort. |
| async / await | A readable way to wait for promises. | Auth waits for its thunk before navigating to overview. |
| try / catch / finally | Handle success, failure and always-needed cleanup. | useReduxAction discards its transport token in finally; OrderTicket releases its submit guard. |
| throw / rejectWithValue | Report a failure to the caller or Redux lifecycle. | Transport throws backend errors; workers return rejectWithValue with serializable fields. |
| unwrap | Converts a dispatched async result into useful success data or a thrown rejection payload. | Auth's form mutation uses dispatch(...).unwrap(). |
| Request ID | Identifies one async request and excludes obsolete responses. | readFulfilled checks entry.requestId before storing data. |
| Cancellation | Stops obsolete work when possible. | Runtime reset aborts tracked reads; the transport composes signals and timeouts. |
| Session epoch | A generation number that invalidates old-session completions. | readRequest/writeRequest reject a response after logout/account switch. |
| Effect cleanup | Undo a subscription/listener/timer when no longer needed. | Polling unsubscribe, chart removal and fullscreen listener cleanup. |
| Router | URL-based navigation, params, nesting and access gates. | main.jsx retains BrowserRouter, Gate, Suspense and all original paths. |
| SQLite | The durable database behind Express. | Backend transactions own balances, fills, payments, courses and sessions. |

## Read a real request from end to end

Open `Auth.jsx`: `mutation` chooses loginUser (or another named auth thunk), creates an opaque transport token, dispatches and unwraps it. Open authSlice: loginUser calls the shared write worker and then fetchCurrentUser. Open request.js: the cookie-authenticated JSON request goes to Express. Open back-end/routes/auth.js: login verifies the password and creates the session; /me returns authorized user data. Open authSlice's builder: lifecycle handlers put status and data into Redux. Workspace reads the resulting session through the Redux-backed resource hook and gives Shell the selected user as a prop.

For a course, open Courses.jsx -> redux/hooks.js -> routes.js -> courseSlice -> requests.js -> request.js -> back-end/routes/learning.js. Successful writes with `{id}` or `{ok}` refetch affected mounted course resources; they do not guess the backend's final row from the form.

## Sample source fragments to explain

```js
// authSlice.js
export const fetchCurrentUser = createAsyncThunk(
  'auth/fetchCurrentUser', readRequest,
  { condition: readCondition('auth') }
);

// A slice's lifecycle registrations
builder.addCase(fetchCourses.pending, readPending)
  .addCase(fetchCourses.fulfilled, readFulfilled)
  .addCase(fetchCourses.rejected, readRejected);

// Courses.jsx
const refresh = useResourceSubscription(path);
const entry = useSelector(state => selectResource(state, path));
const query = resourceResult(entry, refresh);

// useWatchlists.js
const list = useSelector(selectActiveWatchlist);
const setActive = id => dispatch(setActiveWatchlist(id));
```

Explain that the source uses compact formatting in some existing components. The named imports and call paths are the same. Supporting lifecycle helpers are in resourceState.js, not hidden in an external library.

## Expected viva questions and answers

1. **Why Redux rather than only Context?** Several actors and screens share fetched records, independent request statuses, refetch rules, session resets and market polling. Redux supplies explicit actions, reducers, selectors and inspectable state. Context remains useful for simple dependency access; React Redux itself uses it.
2. **Why Toolkit?** It configures standard middleware, generates actions and safely supports immutable reducer updates with less boilerplate.
3. **Why Thunk?** API calls are asynchronous and need access to dispatch, getState, cancellation and rejectWithValue. Reducers must stay synchronous.
4. **Why not RTK Query?** The professor requires explicit Thunk design and lifecycle reducers. The code uses createAsyncThunk.
5. **Did you merely wrap React Query?** No. The dependency/provider/imports are removed. The compatibility hooks select Redux and dispatch named thunks.
6. **Why keep useState?** Form editing, chart mode, dialog visibility and temporary UI messages belong near the component. The final server-owned records belong in Redux.
7. **Why keep useEffect?** Effects still subscribe to data/polling, synchronize the DOM and manage external chart/dialog lifecycles. They return cleanup functions.
8. **What happens on a failed write?** A rejected operation stores a serializable backend error. Existing domain data is retained and no success refresh is triggered.
9. **Why use .unwrap()?** Dispatch normally resolves to a fulfilled/rejected action. unwrap gives form code the result or throws the useful rejection payload.
10. **Where is READ in CRUD?** A fetch thunk reads the backend; its fulfilled reducer writes the snapshot, and selectors read it for React.
11. **Why refetch after create/update/delete?** Many backend writes return only id/ok. The complete server view, authorization fields, progress and computed totals must come from a verified read.
12. **Are transactions editable/deletable?** Only API-supported operations exist. Refund/settlement/cancellation are state transitions, not arbitrary ledger edits.
13. **How are different pages isolated?** Canonical endpoint/query keys include filters, page, ID, symbols and range. A requestId guards each key.
14. **How do you prevent two quote timers?** The per-store runtime groups subscriptions by key and schedules one timer with the shortest requested interval. It deduplicates in-flight requests.
15. **Can old quotes become executable while retrying?** No. The failure marker remains until a successful response. The selector also checks the ten-second freshness limit.
16. **What prevents an old user's response leaking after logout?** Reset clears private feature state, aborts tracked reads and advances an epoch. Obsolete worker results and unmatched requestIds are ignored.
17. **Where are passwords stored?** In temporary form values and a one-use transport mailbox outside Redux. Redux action metadata contains an opaque token; the server owns hashes and sessions.
18. **Why not localStorage for login?** Existing cookie sessions remain authoritative. Only the non-sensitive theme preference is remembered locally.
19. **Is Redux the security boundary?** No. Every endpoint still validates the session, role, ownership, subscription and operation state in Express.
20. **Does refreshing lose trades?** Browser store state is recreated, then the existing session and SQLite records are fetched. The backend retains them.
21. **Did you change actor permissions?** No. The supplied backend had already unified User Admin and Payment Admin as admin. Super Admin retains privileged access.
22. **How do charts work?** Redux supplies quotes/candles; component refs own Lightweight Charts objects and DOM cleanup. Display transforms preserve the existing replay/current candle rules.
23. **What is a pure reducer?** For the same state and action it computes the same next state without I/O, timers, random IDs or external mutation.
24. **What is serializable state?** Plain values, arrays and objects that can be inspected/replayed. Error objects, Files, DOM nodes, timers, functions and promises stay outside it.
25. **How was this verified?** Existing backend tests, new Redux unit and full-stack integration tests, production build, smoke and existing browser suites. See the actual verification record; real provider transactions were not claimed.

## Five-member source preparation and live modifications

Make changes on an exercise branch or throwaway working copy. Return behavior to the tested version before submitting. These are suggested exercises, not additional production changes or authored contribution claims.

### Member 1 — Student trading

Prepare tradingSlice.js, marketSlice.js, watchlistSlice.js, portfolioSlice.js; Trading.jsx, Portfolio.jsx, OrderTicket.jsx, CandleChart.jsx, Orders.jsx, useMarket.js, useWatchlists.js, chartData.js; the quote/watchlist selectors and runtime polling.

Five live edits:

1. Add a selector for the count of stored working orders and show it beside the existing heading.
2. Change quote polling from 2000 to 3000 ms in useMarket; explain cleanup and stale safeguards without changing backend prices.
3. Add a controlled strategy-tag preset to Journal's form; submit through createJournalEntry.
4. Add an explicit error-clear button that calls the existing action reset without clearing account balances.
5. Add a memoized selector for active-watchlist symbol count and pass the count to its reusable heading.

### Member 2 — Instructor

Prepare guidanceSlice.js, taskSlice.js, quizSlice.js; Learners.jsx, Guidance.jsx, Tasks.jsx, Quizzes.jsx, QuizBuilderForm.jsx, QuizResponse.jsx, QuizAttempt.jsx, QuizAttempts.jsx. Trace assignment -> submission -> review and quiz -> draft -> submit -> grade.

Five live edits:

1. Add a local controlled filter for active/pending guidance requests using existing Redux rows.
2. Show a derived count of overdue assignments from tasks data; keep deadline authority on the backend.
3. Change the local initial quiz point value from 1 to 2 and explain controlled numeric conversion.
4. Add a Reset answers button for the unsaved local answer draft, without editing a submitted attempt.
5. Add a retry button using the existing fetchTasks refetch path and explain pending/rejected rendering.

### Member 3 — Course Provider content

Prepare courseSlice.js and resourceSlice.js; Courses.jsx and Resources.jsx; the content portions of Provider.jsx and course-linked quiz integration. Coordinate commercial fields with Member 5 rather than duplicating commerce data.

Five live edits:

1. Add a local controlled difficulty filter over selected course rows.
2. Show a selector-derived count of currently loaded draft courses; explain that paginated counts are page-scoped.
3. Add a description character count to the course form without changing backend limits.
4. Add a file-size label using existing Redux resource metadata.
5. Dispatch updateCourse explicitly for a draft title change and demonstrate failed validation preserving prior data.

### Member 4 — User Admin, Super Admin and integration

Prepare authSlice.js, userSlice.js, supportSlice.js, notificationSlice.js, dashboardSlice.js, themeSlice.js; store.js, routes.js, hooks.js, selectors, resourceState.js, requests.js; Auth.jsx, Members.jsx, Shell.jsx, main.jsx and Operations.jsx.

Five live edits:

1. Add a selector for a selected member's display name and use it in a reusable child prop.
2. Add an explicit Clear search control to Members, resetting its local page to zero.
3. Add a support ticket open/closed UI filter over Redux rows without introducing deletion.
4. Add a theme label using selectTheme and explain why only theme is persisted.
5. Demonstrate sessionReset in a test store, showing private slices cleared and theme retained; add a regression assertion.

### Member 5 — Payment Admin

Prepare paymentSlice.js, commerceSlice.js; Plans.jsx, commercial sections in Provider.jsx and payment queue/actions in Operations.jsx; routes.js affectedDomains payment dependencies. Explain demo checkout versus hosted checkout and recorded settlement versus external transfer.

Five live edits:

1. Add a selector for the number of pending payments in the loaded billing snapshot.
2. Add a local controlled status filter to settlement rows without changing stored amounts.
3. Add a read-only formatted agreed-fee label from an existing proposal response.
4. Show a separate pending indicator for proposal decisions using the existing operation status.
5. Add an error-path test for requestRefund receiving a backend rejection; confirm the payment records remain unchanged.

## Shared-file coordination and genuine Git procedure

Start from the team's real original commit: `git switch -c redux-migration`. Commit only reviewed, actually performed changes under the person's own identity. Use one integration owner for store, shared hooks, routes and selectors; feature owners coordinate their routing changes through that owner. Do not amend or fabricate historical author identities or backdate work. See REDUX_MIGRATION_REPORT.md for suggested genuine feature commits and the exact file inventory.

Run `npm test`, `npm run build`, `npm run test:smoke`, `npm run test:catalog-ui`, `npm run test:e2e` and `npm run test:trading-ui` after integration. Install the browser first using `npx playwright install chromium`. Real provider checks are separately configured test-account exercises; never demonstrate by triggering a real financial transaction.
