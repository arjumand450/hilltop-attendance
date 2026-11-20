# Hilltop Guest House Staff Attendance

A Flutter app for tracking staff attendance at Hilltop Guest House.
It has a welcome screen with a Login button, and local storage built with Hive.

## Setup
1. Install the Flutter SDK
2. Clone this repo: `git clone <your-repo-url>`
3. Run `flutter pub get`
4. Generate Hive adapters: `dart run build_runner build --delete-conflicting-outputs`
5. Run the app: `flutter run`

## Hive storage
- Models: `Staff` (id, name, role) and `AttendanceRecord` (staffId, date, checkInTime)
- Hive is initialized in `main()` in `lib/main.dart`: init, register adapters, open boxes, then `runApp`.
- On launch, the app adds 5 sample staff if the staff box is empty, so data persists across restarts without duplicates.

## Populate script
Run `dart run bin/populate.dart` to add the 5 sample staff from the command line.
The script writes to a local `hive_data/` folder (ignored by git), while the app stores its data separately on the device.

## Dependencies
- provider
- hive, hive_flutter, hive_generator, build_runner

## Mock login
Test users are in `assets/users.json`. Example: `ayesha@hilltop.com` / `ayesha123`.
Authentication state is managed with Provider (`lib/providers/auth_provider.dart`).
See `decision_log.md` for why Provider was chosen over Riverpod.

## Check-in screen
The check-in screen lists all staff from the Hive `staff` box. Pressing "Check-in" saves an
AttendanceRecord (staffId, date, checkInTime) in the Hive `attendance` box and updates the
"Present today" counter through Provider (`lib/providers/attendance_provider.dart`).
It works fully offline, and records stay after the app is closed and reopened.