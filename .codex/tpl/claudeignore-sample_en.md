# .claudeignore Sample

> By placing this file as `.claudeignore` in the project root,
> you can specify paths that Claude Code will ignore when reading files.
> Use it to reduce token consumption and protect sensitive information.

---

## How to Use

`.claudeignore` uses the same syntax as `.gitignore`.

```
# ← # for comments
*.log          ← ignore all .log files
dist/          ← ignore everything under the dist directory
!src/important.ts  ← ! negates an exclusion rule
```

---

## Sample (copy and save as `.claudeignore`)

```gitignore
# ===========================
# Build artifacts / cache
# ===========================
dist/
build/
.next/
.nuxt/
out/
.cache/
.parcel-cache/
*.min.js
*.min.css

# ===========================
# Dependencies (large / unnecessary)
# ===========================
node_modules/
vendor/
.venv/
__pycache__/
*.pyc

# ===========================
# Test coverage reports
# ===========================
coverage/
.nyc_output/
test-results/
playwright-report/

# ===========================
# Logs / temporary files
# ===========================
*.log
*.tmp
*.bak
*.swp
.DS_Store
Thumbs.db

# ===========================
# Sensitive info / environment variables
# ===========================
.env
.env.local
.env.*.local
*.pem
*.key
*.cert
secrets/

# ===========================
# Data / backups
# ===========================
*.sql
*.dump
*.csv
*.xlsx
*.bak
backups/

# ===========================
# Images / media (large size)
# ===========================
public/images/
assets/videos/
*.mp4
*.mov

# ===========================
# Documents (not needed during AI implementation)
# ===========================
# docs/meetings/     ← meeting minutes are usually not needed during implementation
# docs/contracts/    ← contract documents

# ===========================
# IDE / editor settings
# ===========================
.idea/
.vscode/
*.suo
*.user
```

---

## Estimated Token Savings

| Target | Savings |
|--------|---------|
| Excluding `node_modules/` | Large (hundreds of thousands of tokens) |
| Excluding `dist/` `build/` | Medium (tens of thousands of tokens) |
| Excluding `coverage/` | Small to medium |
| Excluding logs / temp files | Small |

---

## Notes

- Adding entries to `.claudeignore` does NOT affect `.gitignore` (they are separate files)
- Be careful not to accidentally exclude files needed for implementation
- Adding a link to this file in the `.claudeignore reference` section of CLAUDE.md makes it easier to manage
