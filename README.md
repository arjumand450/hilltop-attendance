# Hilltop Guest House Staff Attendance

A Flutter app for tracking staff attendance at Hilltop Guest House.
This first milestone sets up the project and a welcome screen with a
Login button that routes to a placeholder login screen.

Client: Hilltop Guest House · Built by Arjumand Bano

## Tech
- Flutter (Dart)
- Provider for state management

## Setup
1. Install the Flutter SDK and Android Studio (with an emulator).
2. Clone the repo:
   `git clone https://github.com/arjumand450/hilltop-attendance.git`
3. `cd hilltop-attendance`
4. `flutter pub get`
5. Start an emulator (or use Chrome), then `flutter run`
6. Optional: `flutter test`

## Structure
- `lib/main.dart` - app entry and routes
- `lib/pages/home_page.dart` - welcome screen
- `lib/pages/login_page.dart` - placeholder login screen
- `assets/logo.png` - placeholder logo

## Roadmap
1. Project setup and welcome screen (this milestone)
2. Data model and Hive local storage
3. Mock login with Provider
4. Check-in screen with offline support
5. Daily report with chart and PDF export
6. CI/CD and GitHub Pages deployment