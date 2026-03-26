# CLAUDE.md — Gram Yatra Master Config
> Read this file FIRST before doing anything. Then read AGENTS.md, then the relevant skill file for your feature.

---

## Project
**Gram Yatra** — Offline-first AI tourism app for Nashik, Maharashtra.
Built at GEN AI Hackathon 2026 by Team ALCHEMY · GGSCER Nashik.

---

## Stack (DO NOT deviate from this)
| Layer | Tech |
|-------|------|
| Frontend | Flutter (Dart) |
| Database | Firebase Firestore |
| Auth | Firebase Auth (anonymous login) |
| Functions | Firebase Functions (Node.js) |
| AI | Gemini API (via Firebase Functions) |
| Maps | Google Maps Flutter plugin |
| Local storage | SQLite (drift package) |
| SMS (pitch only) | Twilio — do NOT implement |

---

## Folder Structure
```
gram_yatra/
├── lib/
│   ├── main.dart
│   ├── screens/
│   │   ├── welcome_screen.dart
│   │   ├── home_screen.dart
│   │   ├── map_screen.dart
│   │   ├── plan_builder_screen.dart
│   │   ├── kumbh_screen.dart
│   │   └── sos_screen.dart
│   ├── widgets/          ← reusable UI components
│   ├── models/           ← data models
│   ├── services/         ← Firebase, Gemini, Maps logic
│   └── utils/            ← constants, helpers
├── functions/            ← Firebase Functions (Gemini endpoint)
├── assets/
│   ├── images/
│   └── fonts/
├── CLAUDE.md
├── AGENTS.md
├── rules/
├── skills/
└── hooks/
```

---

## Absolute Rules (never break these)
- NEVER hardcode API keys in Dart files. Use `.env` or Firebase Remote Config.
- NEVER push to `main` directly. Always PR into `dev` first.
- NEVER use `print()` for debugging — use `debugPrint()`.
- NEVER import packages not in `pubspec.yaml`.
- ALL screens must work on both Android and iOS.
- ALL text visible to users must be in a `strings.dart` constants file (for future Marathi support).
- Offline-first: if Firebase fails, app must not crash — use local SQLite fallback.

---

## Key Features (priority order)
1. **AI Plan Builder** — Gemini API, takes vibe + budget + time → returns 3 named plans
2. **Map with POI pins** — color coded by category, tap for details
3. **SOS button** — dial 100 + share GPS via WhatsApp
4. **Kumbh Survival screen** — fully static, offline, hardcoded data
5. **Women Safety Suite** — safe route filter, safe spots

## Features to FAKE (UI only, no backend)
- Lost & Found form
- Road disruption overlay (hardcode 3 polylines)
- AI Cultural Stories (hardcode 3 strings)
- Feedback / photo upload

---

## Gemini API Rules
- Model: `gemini-1.5-flash` (free tier, fast)
- Call ONLY via Firebase Functions — never call Gemini directly from Flutter
- Always handle API errors gracefully — show fallback hardcoded plan if call fails
- Max tokens: 1024 per call

---

## Git Rules
See `rules/git-workflow.md` for full details.
Short version: branch → commit → PR to dev → Varad merges.
