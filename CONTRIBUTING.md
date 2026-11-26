# Contributing to IndAI

Read TEAM_CONTRIBUTIONS.md for current file/function boundaries and GITHUB_MIGRATION_REPORT.md for the actual migration. The initial Redux import is attributed honestly to the authorized integrator; actor allocation is future work/study responsibility, not invented authorship.

Create a focused feature branch from redux-migration while the update awaits approval. Make a real change, coordinate shared files at function/hunk level, and run the appropriate checks. Do not create empty commits or reformat code to inflate statistics. Preserve backend-owned pricing, balances, authorization and supported workflow transitions.

Use `powershell -NoProfile -File scripts/Summarize-Contributions.ps1 -Range 'main..HEAD'` to report recorded source, dataset, asset, documentation and lockfile changes separately. Before committing, run `powershell -NoProfile -File scripts/Test-StagedSecrets.ps1` and `git diff --cached --check`.

The author is the person who did the actual work; the committer records who created the commit; push authentication identifies the account sending commits to GitHub. Use a teammate author or Co-authored-by trailer only for genuine, authorized work. Do not change global identities, rewrite history or force-push.

Use `npm install`, `npm run setup`, `npm test`, `npm run build`, `npm run test:smoke`, `npm run test:catalog-ui`, `npm run test:e2e` and `npm run test:trading-ui`. Browser tests need `npx playwright install chromium`. Use demo data/funds. Keep private .env files, runtime databases, dependencies and build output out of Git. Merge into main only after the user approves the reviewed update.
