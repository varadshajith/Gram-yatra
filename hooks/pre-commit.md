# hooks/pre-commit.md — Pre-Commit Hook Setup

## What it does
Runs `flutter analyze` before every commit. Blocks commit if there are errors.

## Setup (each teammate runs this once after cloning)
```bash
# From repo root
cp hooks/pre-commit .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit
```

## The Hook File
Create `hooks/pre-commit` (no extension):
```bash
#!/bin/sh
echo "Running flutter analyze..."
flutter analyze
if [ $? -ne 0 ]; then
  echo "❌ Flutter analyze failed. Fix errors before committing."
  exit 1
fi
echo "✅ All good. Committing..."
```

## Windows Note
Git on Windows runs bash hooks via Git Bash. This will work as long as Flutter is in PATH.
If it doesn't run, just manually run `flutter analyze` before each commit.
