# rules/git-workflow.md — Git Rules for Gram Yatra

## Branch Structure
```
main        ← demo-ready only. Varad merges here.
dev         ← integration branch. Varad merges here from feature branches.
varad       ← Varad's work
tanvi       ← Tanvi's UI work
yug         ← Yug's maps work
yashodhan   ← Yash's Gemini/AI work
sahil       ← Sahil's Kumbh/SOS work
```

## Daily Workflow (every person, every day)
```bash
# Start of day — get latest from dev
git fetch origin
git merge origin/dev

# Work on your stuff, then:
git add .
git commit -m "type: short description"
git push
```

## Commit Message Format
```
feat: add map pin tap bottom sheet
fix: gemini response null crash
ui: welcome screen hero animation
chore: add google maps dependency
```

## End of Day
Push everything. Even broken code. Leave a comment `// WIP` if incomplete.
Message Varad on WhatsApp: what's done, what's blocked.

## Varad's Merge Flow
```bash
git checkout dev
git merge yashodhan   # or whoever
git push origin dev
# once all merged and tested:
git checkout main
git merge dev
git push origin main
```

## Conflict Rules
- If conflict in `pubspec.yaml` → Varad resolves only
- If conflict in your own screen file → you resolve
- NEVER force push to dev or main
