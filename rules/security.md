# rules/security.md — Security Rules

## API Keys
- NEVER commit `google-services.json` or `GoogleService-Info.plist` — already in .gitignore
- NEVER hardcode Gemini API key in Dart or JS files
- Store secrets in `.env` (local only) or Firebase Remote Config

## Firebase Rules (Firestore)
```
// Minimum rules for hackathon — read public, write authenticated
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /poi/{document} {
      allow read: if true;
      allow write: if request.auth != null;
    }
    match /{document=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```

## Location Data
- Ask for location permission before accessing GPS
- Never store raw GPS coordinates in Firestore with user identifiers
- SOS screen: share location via URL only (no server storage)

## .gitignore must include
```
.env
google-services.json
GoogleService-Info.plist
*.keystore
.dart_tool/
build/
```
