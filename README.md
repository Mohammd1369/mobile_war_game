# LIFE OS — Starter 0.1

A bilingual (Persian/English) Flutter starter for the LIFE OS concept.

## Included in this first slice
- Dark, modern home screen
- Persian/English language toggle
- Six life-area cards
- Daily mission checkbox and basic completion state
- Bottom navigation placeholders for Home, My Path, Mission, and Progress

## Run locally
1. Install Flutter SDK and Android Studio.
2. Extract this folder.
3. In this folder, run:
   ```bash
   flutter pub get
   flutter run
   ```
4. To build an Android APK:
   ```bash
   flutter build apk --release
   ```

## Current limitations
This is an early UI prototype, not a finished product. The mission state is in-memory and resets when the app restarts. There is no login, cloud sync, AI, analytics, or production privacy/security implementation yet. Those should be designed and tested before public release.
