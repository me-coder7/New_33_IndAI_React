# IndAI GitHub migration report

Date: 2026-11-26 (Asia/Calcutta). Repository: https://github.com/me-coder7/New_33_IndAI_React.

## Current result and merge boundary

Status: **Not yet pushed**. The current implementation is on `redux-migration`. The original default branch remains `main` at `82fbbea349aab6014f152d15742d531060f52626`; it has not been merged or force-pushed. A default-branch merge and final release tag require the user's explicit approval after reviewing this report.

Import commit: `pending honest import commit`. Documentation follow-up: `pending final report commit, if needed`. All new recorded integration work uses **Praneeth <174439533+me-coder7@users.noreply.github.com>**, as explicitly selected by the user. No import commits were invented under the other four names.

## Initial inspected state

- Clone root: `C:\Users\mohan sai praneeth\Music\IndAI_Redux\IndAI\New_33_IndAI_React`.
- Updated local source: `C:\Users\mohan sai praneeth\Music\IndAI_Redux\IndAI`; the clone was nested inside it, not already updated.
- The task's original workspace was `C:\Users\mohan sai praneeth\Music\react (1)` and was not a Git repository.
- Initial current branch: `version-2`; clean worktree and no ignored/untracked user work in the clone.
- `main`, `version-2`, `redux-migration` and `origin/main` all pointed at `82fbbea` before integration. Remote had only `main`; there were no tags.
- Remote: `https://github.com/me-coder7/New_33_IndAI_React`. Default branch verified locally/remotely as main. Fresh fetch completed.
- Repo-local identity was Purvaj/pentapurvaj07@gmail.com; global identity was Praneeth's GitHub noreply. Only repository-local settings were changed after the user chose the integrator. No global settings/history were rewritten.
- GitHub CLI was not logged in, but Git Credential Manager listed the team's accounts. Push uses the existing GCM workflow, scoped to me-coder7; no password/token was requested, stored or printed.

## What actually changed

| Area | Existing default branch | Supplied/imported version |
| --- | --- | --- |
| Frontend | React/Vite, dashboard/layout pathname selection and custom useResource; no Redux/Router | React/Vite/React Router, Redux Toolkit slices/selectors/Thunk, original supplied redesigned UI |
| Backend | NestJS/TypeScript and algo MJS services | Express/ES modules |
| Authentication | JWT access/refresh token workflow and admin divisions | Opaque cookie sessions; backend role/subscription authorization |
| Durable state | JSON platform/account stores and uploaded files | SQLite, eight migrations, transactional services and resource blobs |
| Market | 61 bundled CSV stock datasets and original engine | Bundled 2,779-instrument catalogue, selected quotes/candles, demo or Upstox/replay service |
| Charts | Inline SVG | Lightweight Charts with retained current terminal/explorer controls |
| Packages | Root, frontend and backend manifests/locks | One root manifest/lock for the whole app |
| Verification | Node built-in tests and old browser scripts | Vitest API/domain/Redux/full-stack tests and supplied browser suites |

The new local source is the **actual Redux Toolkit/Thunk implementation**, not just a redesigned React demo: configureStore, Provider, 17 slices, named createAsyncThunk operations, CRUD reducers, selectors and dispatch are present. Application reads/mutations use Redux, and TanStack Query is absent from application dependencies/imports.

The adjacent source had 69 pre-existing formatted JS/JSX differences versus the delivered ZIP. Compilation normalization matched 59 exactly; inspected differences in the remaining ten were adjacent JSX text/space-node splits. The user's current adjacent source was preserved and tested; it was not reformatted to generate work. The archive-specific release-manifest.json was not imported into Git because those source formatting changes made its release-only hashes obsolete.

**Compatibility/feature review required before merge:** this is not a drop-in migration of the old NestJS database or API. Existing JSON users/data/auth sessions are not automatically converted into SQLite. The old institution/CSV-intake and scheduled-session/algo/institute workflows are not present as equivalent routes in the supplied new version. The new API unifies User Admin and Payment Admin permissions as admin, rather than preserving the old admin divisions. Old learner/superuser role names become student/superadmin in the new implementation. These are properties of the supplied version, not hidden compatibility guarantees. The default branch stays on the working old version until the user accepts the replacement scope.

Obsolete Nest modules, algo/CSV runtime, nested manifests, old layouts/services/styles, Docker/start wrappers, JSON-store code, schema-reference/ER files and old tests/docs were removed from the migration tree because their consumers were replaced. Old legitimate CSV/media resources remain accessible in preserved Git history/tag; they were not removed to manipulate statistics. New catalogue/reference media remain in the updated project. Common attribution notices and Node-version markers are retained/updated; archive-only checksums are omitted.

## Version preservation

The original commit is preserved by annotated tag **pre-redux-82fbbea**. Its five ancestor commits and original author metadata remain unchanged. `main` remains a second reference to the original state. The existing `version-2` branch is still merely a local pointer to that original commit, not proof of a separate redesigned version.

No v1.0/v2.0 tag was manufactured: the old manifest already calls itself 3.2.0, while the supplied Redux manifest calls itself 3.0.0. Those labels do not establish separate historical v1/v2 source milestones. The descriptive pre-Redux tag avoids falsely identifying an unverified release. Create v3.0 only after the reviewed Redux branch is approved and integrated, using the commands below. Do not silently retag existing names.

## Actual measured difference and full file classification

406 changed paths; 22,519 added / 165,860 deleted Git text lines, plus 6 binary entries. Meaningful source: 15,767 added / 22,808 deleted. This snapshot measures the application import plus the prepared reporting tools/docs; final documentation-only updates can change overall documentation counts.

`docs/github-file-comparison.csv` records actual Git status, old/new paths, primary coordination owner, source/data/lock/asset/document/config category and additions/deletions. Git's rename detection is reported as such; semantic old/new module replacements are not called renames merely to imply continuity. `docs/github-migration-statistics.json` contains the measured category totals and per-owner review footprint. Shared infrastructure is flagged in the ownership JSON and TEAM_CONTRIBUTIONS.md.

Counts are read from `git diff --cached --numstat --no-renames` and `git diff --cached --name-status -M`, not estimates. Different rename modes can express the same change as a pair of deletes/adds; the report states which one is used. Dataset, lockfile and binary counts are kept separate from meaningful source. File assignment totals are review scope, not author credit.

## Historical contributor imbalance

| Username | Commit | Source added | Dataset added | Lockfile added | Docs added | Asset text | Config added |
| --- | --- | ---: | ---: | ---: | ---: | --- | ---: |
| Jeswanth09052007 | `82fbbea` | 9,801 | 136,718 | 3,166 | 1,585 | 74 + binary assets | 141 |
| me-coder7 | `15962aa` | 2,794 | 0 | 0 | 78 | 0 + binary assets | 0 |
| Purvaj-P22 | `fdfd040` | 2,962 | 0 | 1,170 | 77 | 0 + binary assets | 19 |
| BharanRajP | `5cd2768` | 4,869 | 0 | 0 | 78 | 0 + binary assets | 0 |
| gurwinder-s24 | `0aaf233` | 2,412 | 0 | 0 | 80 | 0 + binary assets | 0 |

Jeswanth's CSV data adds **136,718 lines**, with **3,166 lockfile lines**; these explain most of the 151,411-line screenshot. Git also treats one PDF as 74 text lines, giving 151,485 raw numstat lines if that asset is included. The PDF remains an asset in workload reports. No tracked node_modules, generated dist or vendor folder was found. All five baseline commits contain zero deletions. No code was deleted/restored or re-authored to manufacture balances.

## Five-member allocation and genuine credit

| Member | Actor | Assigned files | Added source review footprint | Deleted source review footprint | Estimated workload |
| --- | --- | --- | ---: | ---: | --- |
| Jeswanth09052007 | Learner | 32 primary current files; see lists/JSON | 3,185 | 2,393 | 22% planning estimate |
| me-coder7 | Instructor | 15 primary current files; see lists/JSON | 2,280 | 2,317 | 20% planning estimate |
| Purvaj-P22 | Course Provider | 14 primary current files; see lists/JSON | 1,941 | 4,871 | 18% planning estimate |
| BharanRajP | User Admin and Super Admin | 57 primary current files; see lists/JSON | 4,945 | 10,035 | 21% planning estimate |
| gurwinder-s24 | Payment Admin and shared integration | 39 primary current files; see lists/JSON | 3,416 | 3,192 | 19% planning estimate |

See TEAM_CONTRIBUTIONS.md for every current assigned file, exact safe per-member PowerShell commands, specific shared function boundaries, APIs, rubric concepts and five live modifications each. Complexity/coordination estimates span 18–22%; they are not measured contribution percentages. Each member owns substantial React frontend behavior. Shared files are reviewed by function/hunk, not overwritten independently. The initial import is honestly attributed once to its authorized integrator, with AI assistance disclosed; future authored feature commits must represent real work.

GitHub public commit metadata confirms the five historical username/email associations. The institutional email provided for Praneeth is not verified; the user selected his historically linked noreply address. No private account settings were inspected. Author means actual originator; committer means the person recording the commit; push identity is the account authenticating the transport. None proves that every imported line was manually written by the integrator. No co-authors were invented.

## Security review

Initial tracked and reachable historical paths contained no private .env file, node_modules, build output or SQLite runtime database. High-confidence scans of tracked/historical text found no private-key, GitHub-token, AWS-key or literal JWT pattern. These checks cannot prove every possible secret is absent. Safe .env.example credential values are blank. Local runtime .env/data are generated only for demo tests and remain ignored. The current parent folder's private .env/data/node_modules were never copied into the clone.

`scripts/Test-StagedSecrets.ps1` checks the actual Git index without printing private values. It rejects private environment variants, databases/sidecars, dependencies/build/test artifacts, known credential patterns and matching values from a local .env. Human review remains necessary. Any previously committed real credential discovered later must be revoked/rotated by its owner; history was not rewritten here.

The dependency audit/installation reports **5 retained dependency-tree advisories** (Nodemailer/Zod/Vitest tree: 1 moderate, 2 high, 2 critical). This migration does not claim production security clearance. Major-version remediation and compatibility testing remain separate work. The imported docs/npm-audit.json records the prior verified audit; current npm install again reported the same advisory count.

## Actual branch verification

```json
{
  "date": "2026-11-26",
  "timezone": "Asia/Calcutta",
  "repository": "me-coder7/New_33_IndAI_React",
  "branch": "redux-migration",
  "commands": [
    {
      "command": "npm install --registry=https://registry.npmjs.org",
      "status": "passed",
      "exitCode": 0,
      "note": "214 packages installed; 5 inherited dependency-tree advisories."
    },
    {
      "command": "npm run setup",
      "status": "passed",
      "exitCode": 0,
      "note": "Created fresh ignored demo SQLite data in clone; parent data untouched."
    },
    {
      "command": "npm test",
      "status": "passed",
      "exitCode": 0,
      "testsPassed": 68,
      "testsFailed": 0,
      "testsSkipped": 0
    },
    {
      "command": "npm run build",
      "status": "passed",
      "exitCode": 0
    },
    {
      "command": "npm run test:e2e",
      "status": "passed",
      "exitCode": 0,
      "note": "All 7 demo logins and supplied actor workflows; final running cell completed successfully."
    },
    {
      "command": "npm run test:trading-ui",
      "status": "passed",
      "exitCode": 0,
      "note": "Watchlist CRUD/reordering/persistence, charts/fullscreen, 1440/390/320px, dark mode; zero browser page errors."
    },
    {
      "command": "npm run test:smoke; npm run test:catalog-ui",
      "status": "passed",
      "exitCode": 0,
      "note": "Smoke starts scripts/dev.js, validates Vite/API proxy and built server; transient ready-probe connection refusal recovered."
    },
    {
      "command": "scripts/Summarize-Contributions.ps1 -AllHistory -AsJson",
      "status": "passed",
      "exitCode": 0,
      "note": "Independent PowerShell totals match 22,838 historical source additions."
    },
    {
      "command": "scripts/Test-StagedSecrets.ps1 -PrivateEnvPath ..\\.env",
      "status": "passed",
      "exitCode": 0,
      "note": "Scanned actual index; checked local credential patterns and private parent env values without printing them."
    },
    {
      "command": "git diff --cached --check; git check-ignore ...",
      "status": "passed",
      "exitCode": 0,
      "note": "One inherited SQL-line trailing space removed; private env, data, dist and node_modules are ignored."
    }
  ],
  "notExecuted": [
    "Normal merge into main and final release tag: explicit approval required",
    "Hosted Razorpay checkout/refunds",
    "Live Upstox entitlements/open-market execution",
    "SMTP delivery",
    "Real financial transfers",
    "Legacy JSON-to-SQLite account/data migration",
    "Original NestJS branch runtime suite",
    "Original-versus-new visual pixel comparison"
  ],
  "source": "Tests rerun in the actual imported clone; earlier release-only claims were not substituted for this verification."
}
```

The actual clone, not only the original workspace, ran npm install, npm run setup, all 68 tests, production build, full end-to-end browser checks, trading UI checks and dev/built-server/catalogue checks. Both user-admin/payment-admin responsibilities exercise the supplied unified admin role; the frontend/backend authorization remains authoritative. Browser tests use isolated demo data/funds; the clone setup creates a fresh ignored demo database. The parent application's existing database is untouched. No real financial transaction was performed.

Hosted Razorpay/refunds, live Upstox entitlements/open-market execution, SMTP and real external transfers were not verified. No old JSON-data conversion was implemented. No pixel-diff against the old completely different UI was claimed. Original-branch tests were inspected but not rerun under the replaced architecture; the preserved old branch can be checked separately.

## Exact executed/manual PowerShell workflow

The application import and baseline preservation were executed using the inspected clean clone; no existing uncommitted work was discarded. Scripts Stage-Migration.ps1, Test-StagedSecrets.ps1 and Summarize-Contributions.ps1 are included so the exact index and recorded authors can be reviewed. Do not replay the initial import after it has already been committed.

```powershell
Set-Location -LiteralPath 'C:\Users\mohan sai praneeth\Music\IndAI_Redux\IndAI\New_33_IndAI_React'
git status --short --branch
git remote -v
git branch -a
git tag -n
git log --all --format="%h | %an <%ae> | %cn <%ce> | %s"
git diff main...redux-migration --stat
powershell -NoProfile -File 'scripts/Summarize-Contributions.ps1' -Range 'main..redux-migration'
powershell -NoProfile -File 'scripts/Summarize-Contributions.ps1' -AllHistory
```

Before a future honest commit, stage exact reviewed files/hunks, then inspect them:

```powershell
# Initial import only; default mode lists exact candidate paths without staging.
powershell -NoProfile -File 'scripts/Stage-Migration.ps1'
# Run -Stage only while preparing a reviewed import, not after it is committed.
powershell -NoProfile -File 'scripts/Stage-Migration.ps1' -Stage
powershell -NoProfile -File 'scripts/Test-StagedSecrets.ps1'
git diff --cached --check
git diff --cached --stat
git diff --cached
git config --local user.name 'Praneeth'
git config --local user.email '174439533+me-coder7@users.noreply.github.com'
# The actual import message discloses AI assistance; this is not five authorship claims.
git commit -m 'chore(migration): import AI-assisted Redux application'
git -c credential.https://github.com.username=me-coder7 push -u origin redux-migration
git -c credential.https://github.com.username=me-coder7 push origin pre-redux-82fbbea
```

If normal GCM authentication expires, complete its normal GitHub browser flow. Do not paste tokens into this report or commands. gh auth login is an alternative normal interactive workflow for the CLI, not required merely because git/GCM already works.

## Approval-required final merge and release tag — not executed

Only run after the user approves this concrete branch, its compatibility changes, measured scope and test results. This merge preserves individual historical and genuine future commits. Do not squash, rebase, amend original history or force-push.

```powershell
Set-Location -LiteralPath 'C:\Users\mohan sai praneeth\Music\IndAI_Redux\IndAI\New_33_IndAI_React'
git status --short
git fetch origin --tags
git switch main
git pull --ff-only origin main
git merge --no-ff redux-migration -m 'Merge reviewed Redux migration'
npm test
npm run build
npm run test:smoke
npm run test:catalog-ui
npm run test:e2e
npm run test:trading-ui
# Stop on any failure. Do not move an existing release tag.
if (git tag --list 'v3.0') { throw 'v3.0 already exists; inspect it before proceeding.' }
git tag -a v3.0 -m 'Verified IndAI Redux Toolkit and Thunk implementation'
git -c credential.https://github.com.username=me-coder7 push origin main
git -c credential.https://github.com.username=me-coder7 push origin v3.0
```

If branch protection prevents direct merging, create a pull request using the comparison link and choose a normal merge commit after approval. A PR was not fabricated or reported as created without confirmation from GitHub.

## GitHub links and statistics caveat

- [Repository](https://github.com/me-coder7/New_33_IndAI_React)
- [Original main history](https://github.com/me-coder7/New_33_IndAI_React/commits/main/)
- [Redux branch](https://github.com/me-coder7/New_33_IndAI_React/tree/redux-migration)
- [Redux history](https://github.com/me-coder7/New_33_IndAI_React/commits/redux-migration/)
- [Contributors](https://github.com/me-coder7/New_33_IndAI_React/graphs/contributors)
- [Branches](https://github.com/me-coder7/New_33_IndAI_React/branches)
- [Tags](https://github.com/me-coder7/New_33_IndAI_React/tags)
- [Preserved original](https://github.com/me-coder7/New_33_IndAI_React/tree/pre-redux-82fbbea)
- [Old-to-new comparison](https://github.com/me-coder7/New_33_IndAI_React/compare/pre-redux-82fbbea...redux-migration)
- [Create/review pull request](https://github.com/me-coder7/New_33_IndAI_React/compare/main...redux-migration?expand=1)

These branch/tag links are usable only once the recorded push succeeds; the status at the top and final verification record distinguish prepared links from verified remote objects. Default main still intentionally contains the original implementation pending approval, so the acceptance item 'default branch contains the new version' is not yet fulfilled.

Contributor/email displays and statistics can lag; contributor graphs generally require merged default-branch commits associated with account emails. See [GitHub's contributor graph rules](https://docs.github.com/en/enterprise-cloud%40latest/repositories/viewing-activity-and-data-for-your-repository/viewing-a-projects-contributors), [contribution email/branch requirements](https://docs.github.com/en/account-and-profile/how-tos/contribution-settings/troubleshooting-missing-contributions), and [statistics caching](https://docs.github.com/en/rest/metrics/statistics). Do not use graph delays or generated-line totals to manufacture activity.
