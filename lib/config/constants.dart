const String dummyProblems = """
[Warning] Unused import: 'dart:async'.
[Error] Undefined name 'buildContext'.
[Info] Consider changing the return type to 'void'.
""";

const String dummyOutput = """
Launching lib/main.dart on Chrome in debug mode...
Syncing files to device Chrome...
Debug service listening on ws://127.0.0.1:43987/ws
Debug service listening on ws://127.0.0.1:43987/ws
🔥  To hot restart changes while running, press "R". To hot restart (and reload changes from disk), press "Shift+R".
🔥  To detach, press "d"; to quit, press "q".

Application running at: http://localhost:53338

Performing hot restart...
Syncing files to device Chrome...
Restarted application in 1,234ms.

Reloaded 1 of 543 libraries in 1,256ms.

Performing full restart...
Syncing files to device Chrome...
Restarted application in 2,345ms.

[LOG] 2023-07-14 10:00:00.123: MainApp: Initialization complete.
[LOG] 2023-07-14 10:00:02.456: AuthService: User authenticated successfully.
[DEBUG] 2023-07-14 10:00:05.789: NetworkService: Fetching user data from API.
[ERROR] 2023-07-14 10:00:10.012: ApiService: Failed to fetch user data. Status code: 500.
[LOG] 2023-07-14 10:00:15.345: RetryService: Retrying fetch user data...
[DEBUG] 2023-07-14 10:00:18.678: NetworkService: Fetching user data from API.
[LOG] 2023-07-14 10:00:22.901: MainApp: User data successfully fetched and loaded.
[WARNING] 2023-07-14 10:00:25.234: CacheService: Low disk space, unable to cache user data.
[LOG] 2023-07-14 10:00:28.567: MainApp: Cache service warning displayed to user.

Performing hot reload...
Syncing files to device Chrome...
Reloaded 5 of 543 libraries in 678ms.

Application running at: http://localhost:53338

[LOG] 2023-07-14 10:00:35.890: MainApp: User navigated to the settings page.
[DEBUG] 2023-07-14 10:00:40.123: SettingsService: Loading settings from local storage.
[LOG] 2023-07-14 10:00:45.456: MainApp: Settings page loaded successfully.
[INFO] 2023-07-14 10:00:50.789: UpdateService: Checking for app updates.
[LOG] 2023-07-14 10:00:55.012: UpdateService: No updates available.

Performing hot reload...
Syncing files to device Chrome...
Reloaded 2 of 543 libraries in 567ms.

[LOG] 2023-07-14 10:01:00.345: MainApp: User navigated to the profile page.
[DEBUG] 2023-07-14 10:01:05.678: ProfileService: Fetching profile data from API.
[LOG] 2023-07-14 10:01:10.901: MainApp: Profile data loaded successfully.
""";

const String dummyDebugConsole = """
Debugging session started.
main.dart:5: Warning: Unused import: 'dart:async'.
main.dart:18: Error: Undefined name 'buildContext'.
debugging.dart:3: Info: Consider changing the return type to 'void'.
""";

const String dummyPorts = """
Port 3000: Listening
Port 4000: Closed
Port 5000: Listening
Port 6000: Closed
""";

const String dummyTerminal = """
PS C:\\Projects\\MyApp> flutter run
Launching lib/main.dart on Chrome in debug mode...
Syncing files to device Chrome...
Debug service listening on ws://127.0.0.1:43987/ws
🔥  To hot reload changes, press "r". To hot restart (and reload changes from disk), press "R".
🔥  To detach, press "d"; to quit, press "q".
""";

const String dummyComments = """
[User1] This is a comment on the recent changes made in main.dart.
[User2] I think we need to refactor the code in utils.dart for better performance.
[User3] Great job on the new feature implementation!
[User4] Could someone review the pull request for the bug fix?
""";
