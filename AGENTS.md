# AGENTS.md — Gram Yatra Team Agents
> Read CLAUDE.md first, then this file.

---

## Agent Roles

### 🧑‍💼 Varad — Lead / Architect
**Branch:** `varad`
**Owns:** Flutter scaffold, Firebase project setup, main.dart, routing, merging PRs
**Skills to read:** `skills/firebase.md`
**DO:** Set up `pubspec.yaml`, `main.dart`, navigation routes, Firebase init
**DO NOT:** Touch any feature screen — scaffold only

---

### 🎨 Tanvi — Frontend / UI
**Branch:** `tanvi`
**Owns:** All screens UI, widgets, theme, colors, fonts
**Skills to read:** `skills/flutter-ui.md`
**DO:** Convert Stitch mockups to Flutter screens. Build reusable widgets. Define `AppTheme` in `utils/theme.dart`
**DO NOT:** Write any Firebase or API logic — just UI and mock data
**Screens:** welcome_screen, home_screen, plan_builder_screen (UI only)

---

### 🗺️ Yug — Maps
**Branch:** `yug`
**Owns:** map_screen.dart, POI data, Google Maps integration
**Skills to read:** `skills/maps.md`
**DO:** Google Maps Flutter plugin, color-coded pins, tap-for-details bottom sheet, load POI from Firestore
**DO NOT:** Touch any other screen

---

### 🤖 Yash — AI / Gemini
**Branch:** `yashodhan`
**Owns:** Plan Builder API integration, Firebase Function for Gemini, plan result cards
**Skills to read:** `skills/gemini-api.md`
**DO:** Wire plan_builder_screen form → Firebase Function → Gemini → display 3 plan cards
**DO NOT:** Build the form UI (Tanvi does that) — just wire the API and display results

---

### 🛕 Sahil — Kumbh + SOS
**Branch:** `sahil`
**Owns:** kumbh_screen.dart, sos_screen.dart, Firebase Functions setup
**Skills to read:** `skills/firebase.md`
**DO:** Kumbh screen (fully static/hardcoded), SOS button (url_launcher → dial 100 + WhatsApp GPS share), Firebase anonymous auth
**DO NOT:** Touch map or plan builder

---

## Coordination Rules
- Each person ONLY edits files in their own screen + service file
- Shared files (`main.dart`, `pubspec.yaml`, `utils/`) → ask Varad before editing
- If you need data from another person's module → use a mock/stub and leave a `// TODO: wire to real data` comment
- End of day: push your branch, tell Varad on WhatsApp what's done and what's broken
