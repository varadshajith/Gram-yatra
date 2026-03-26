# rules/coding-style.md — Flutter/Dart Coding Standards

## Naming
- Files: `snake_case.dart`
- Classes: `PascalCase`
- Variables/functions: `camelCase`
- Constants: `kCamelCase` (e.g. `kPrimaryColor`)

## Structure
- Each screen is a `StatefulWidget` or `ConsumerWidget`
- Business logic goes in `services/` — NOT in screen files
- All colors/fonts defined in `utils/theme.dart` — never hardcode hex values in widgets
- All user-visible strings in `utils/strings.dart`

## DO
```dart
// Good — const where possible
const Text('Gram Yatra', style: AppTheme.headingLarge)

// Good — named parameters
ElevatedButton(
  onPressed: _handleSOS,
  child: const Text('SOS'),
)
```

## DO NOT
```dart
// Bad — hardcoded colors
Container(color: Color(0xFFFF5733))

// Bad — logic in build()
onPressed: () async {
  final ref = FirebaseFirestore.instance.collection('poi');
  // ... 30 lines of logic
}
```

## Error Handling
- Wrap all Firebase/API calls in try/catch
- Show `SnackBar` on error — never let app crash silently
- Log with `debugPrint('ClassName: error message')` 

## Packages — approved list only
```yaml
google_maps_flutter: ^2.5.0
firebase_core: ^2.24.0
cloud_firestore: ^4.14.0
firebase_auth: ^4.17.0
url_launcher: ^6.2.4
sqflite: ^2.3.0
geolocator: ^11.0.0
flutter_dotenv: ^5.1.0
```
Do not add packages without telling Varad first.
