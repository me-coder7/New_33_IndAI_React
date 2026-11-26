# Historical verification notes from the supplied React version

These inherited notes describe the original version and are not new Redux test claims. Current execution results are in [../REDUX_MIGRATION_REPORT.md](../REDUX_MIGRATION_REPORT.md) and [redux-verification.json](redux-verification.json). Live-provider claims below have not been re-verified during this migration.

# Verification report

| Check | Result |
| --- | --- |
| API integration and domain tests | 36 tests passed across the original workflows and the new member, funding, media, quiz, and provider workflows. |
| Initial data | Verified 200 Free, 60 Pro, and 40 Plus learners, 32 instructors with zero-to-five active learners, 18 providers, one Admin, and one Super Admin. |
| Funding and awards | Verified role-specific funding, instructor trading access, award evidence, duplicate prevention, the rolling weekly cap, reset behavior, and renewal of the seven-day window. |
| Member administration | Verified directory filters, full learner records, secret exclusion, unauthorized-access rejection, capacity checks, notes, profile edits, and Super Admin permission changes. |
| Resources | Verified seeded PDF/video resources, upload ownership, invalid file rejection, authorized delivery, cross-learner isolation, video byte ranges, and invalid ranges. |
| Quizzes | Verified draft privacy, publication, hidden answer keys, draft saving, invalid choices, single submission, auto-scoring, written-answer grading, score limits, and final feedback. |
| Course provider | Verified proposal, counteroffer, acceptance, content review, publication, one-time earning creation, and external settlement records. |
| UI reference | Editable Figma portfolio reference uses source fonts, semantic tokens and component instances. This is a design reference, not evidence of browser validation. |
| Vite build | Passed with separate bundles for trading, members, quizzes, and provider screens. |
| HTTP serving | Development proxy and built-server route refresh checks passed. |
| Browser interaction and visual layout | The Playwright suite passed homepage/navigation, quick logins, signup/verification, admin approval, courses/progress, tickets, trading fills/cancellations, plans, guidance, themes, portfolio order dialogs and catalogue search. A headless-shell browser passed the trading explorer workflow at 1440px, 390px and 320px, including dark mode, text visibility, persisted watchlists, create/switch/rename/reorder/remove/delete, and no JavaScript errors. |
| External providers | Upstox exchange status and separate RELIANCE/INFY historical sessions were fetched successfully; replay advanced with distinct prices and matched chart closes. Open-session quote entitlements, Razorpay hosted checkout/refund and SMTP delivery remain externally unverified. |

The demo data uses its existing seed guard. Run setup in a fresh extraction to load the revised initial distribution. Existing databases receive schema migrations while retaining their records.


Catalogue update verification: full metadata inventory, authorized access, existing anchor preservation, numeric/ampersand/hyphen symbols, quote request bounds, watchlists, charts, buy/sell fills and portfolio positions passed. Mocked live-provider tests checked selected-key batching, deduplication, concurrency bounds and partial-failure isolation. The stock picker passed server-rendering checks for 40 results per page, pagination and an empty state. Trading explorer interactions are now verified using headless shell. Live quote entitlements are not verified by downloading the public instrument master.


Closed-market replay checks passed for the latest valid session, today/previous-day fallback, per-stock data isolation, loop rollover, chart/frame alignment, live/replay order isolation, recorded-day isolation, inherited stop-loss/take-profit scope, and cancellation of replay exits when live trading resumes. The API/worker startup smoke checks and production Vite build passed. Browser checks also caught and resolved a development-JSX/production-runtime mismatch and the chart's default-locale rendering error.

To run browser checks locally, run `npx playwright install chromium --only-shell`, build the frontend, then `npm run test:trading-ui`. Restricted Linux hosts may need PLAYWRIGHT_SINGLE_PROCESS=true. `TEST_MARKET_SOURCE=upstox` runs the trading browser workflow against the configured closed-market replay service; it requires current credentials and a closed exchange session.

The complete redesigned watchlist browser workflow also passed against the real configured Upstox closed-market replay feed, with separate stock histories and visible replay labels. Desktop, 390px and 320px screenshots were inspected internally.


Trading-view refinement: restored the chart-first terminal with a large chart, adjacent order ticket on desktop, an instrument/account strip and a same-page explorer drawer. Browser checks cover opening and closing the drawer, retaining list state, line/candlestick switching, resetting the viewport, entering/exiting full screen and layouts at 1440/390/320 pixels. Hidden watchlist quote polling pauses. Dark-mode button-hover contrast was corrected.
