# Security Review: Data Injection Risks

## Scope
Local-only Flutter app. Data is stored in Hive boxes on the device. No server or network calls.

## Checks performed

1. **Input validation on login.** The login form rejects empty email and password
   (`validator` in `login_page.dart`). The email is trimmed and compared in lower case
   in `AuthProvider.login`, so extra spaces or letter case cannot change the match.
2. **No free-text input reaches storage.** Check-in saves only a staff ID taken from
   the Hive staff box, plus DateTime values created by the app itself. The user types
   nothing that is written to the attendance box, so there is nothing to inject.
3. **Safe file names and bounded data in the report.** The PDF name is built only from
   `DateFormat('yyyyMMdd')` of the current date (`pdf_report.dart`), never from user
   input, so path tricks like `../` are not possible. The report also groups records
   by date and ignores any record outside the 7-day window.

## Storage safety
- Hive boxes are typed (`Box<Staff>`, `Box<AttendanceRecord>`), so wrong data types are rejected.
- Duplicate check-ins for the same person on the same day are blocked in `AttendanceProvider.checkIn`.

## Known limitations
- Passwords in `assets/users.json` are plain text. This is acceptable for a mock login only.
- Hive data is not encrypted. A real deployment should use an encrypted box.