# Handover: Hilltop Guest House Staff Attendance

## Overview
A Flutter app for staff login, daily check-in and a 7-day attendance report.
Data is stored locally with Hive. Live: https://arjumand450.github.io/hilltop-attendance/

## Architecture

```
+---------------------------------------------------+
|                    UI (pages)                     |
|   LoginPage -> HomePage -> CheckInPage            |
|                         -> ReportPage             |
+-----------------------+---------------------------+
                        | context.watch / read
+-----------------------v---------------------------+
|                Provider (state)                   |
|  AuthProvider  AttendanceProvider  ReportProvider |
+-----------------------+---------------------------+
                        |
+-----------------------v---------------------------+
|                Hive (local storage)               |
|        staff box          attendance box          |
+---------------------------------------------------+
  assets/users.json -> AuthProvider (mock login)
  ReportProvider    -> pdf_report.dart (PDF export)
```

## Run locally
1. Install the Flutter SDK
2. `git clone https://github.com/arjumand450/hilltop-attendance`
3. `flutter pub get`
4. `flutter run -t lib/main.dart` (or `flutter run -d chrome` for web)

## Deployment
1. Push to `main`.
2. GitHub Actions (`.github/workflows/flutter_web.yml`) runs `flutter build web --release`
   with base-href `/hilltop-attendance/`.
3. The output is pushed to the `gh-pages` branch.
4. GitHub Pages (Settings > Pages > `gh-pages` / root) serves it.

## Maintenance checklist
- [ ] Check the Actions tab is green after each push
- [ ] Run `flutter pub outdated` monthly and update packages
- [ ] Replace plain-text passwords in `assets/users.json` before real use
- [ ] Use an encrypted Hive box for real data
- [ ] If the repo is renamed, update `--base-href` in the workflow

## Known limitations
- Mock login only; passwords are plain text.
- Data stays in each device's browser or phone. There is no shared server.

## Contact
Name: Arjumand Bano
Email: arjumandofficial@gmail.com