# SETUP.md — Run Gram Yatra Locally

## Prerequisites
- Flutter SDK installed (`flutter doctor` should show ✅)
- Android device/emulator OR iOS simulator
- VS Code or Android Studio
- Git

## First Time Setup
```bash
# 1. Clone and switch to your branch
git clone https://github.com/varadshajith/Gram-yatra.git
cd Gram-yatra
git checkout yourname   # varad / tanvi / yug / yashodhan / sahil

# 2. Install dependencies
flutter pub get

# 3. Set up pre-commit hook
cp hooks/pre-commit .git/hooks/pre-commit

# 4. Run the app
flutter run
```

## Environment Setup
Create `.env` in root (DO NOT commit):
```
GEMINI_API_KEY=your_key_here
MAPS_API_KEY=your_key_here
```
Ask Varad for the actual keys on WhatsApp.

## Useful Commands
```bash
flutter analyze          # check for errors
flutter pub get          # after pulling new pubspec.yaml changes
flutter clean            # if something is weird, run this then pub get
flutter run --release    # faster performance for demo
```

## If flutter is not recognized
Add Flutter to PATH:
- Windows: Add `C:\flutter\bin` to System Environment Variables → Path
- Then restart terminal

## Branch Reminder
You ONLY push to YOUR branch. Never push to dev or main directly.
```bash
git push origin yourname
```
