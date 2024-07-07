# log_tracking

A package that stores the logs used in the project

## Getting Started

### 1. Add to pubspec.yaml

```yaml
dependencies:
  log_tracking: 0.3.2
```

### 2. Initialize log_tracking

We initialize our log library as follows. 
If we want to integrate our logs with log structures such as firebase crashlytics, we can use a structure like the following.
```dart
import 'package:log_tracking/log_tracking.dart';
///...
Future<void> initializeLog() {
  return Log.init(
      saveToLocal: true,
      onInfo: (log) {
        /// if you want to integrate with FirebaseCrashlytics you can do like this
        FirebaseCrashlytics.instance.log("INFO:  ${log.text ?? ""}");
      },
      onWarning: (log) {
        /// if you want to integrate with FirebaseCrashlytics you can do like this
        FirebaseCrashlytics.instance.recordFlutterError(
          FlutterErrorDetails(
            exception: "WARNING:  ${log.text}",
            stack: log.stackTrace,
          ),
          fatal: false,
        );
      },
      onError: (log) {
        /// if you want to integrate with FirebaseCrashlytics you can do like this
        FirebaseCrashlytics.instance.recordFlutterError(
          FlutterErrorDetails(exception: log.error, stack: log.stackTrace),
          fatal: true,
        );
      },
      onSendToServer: (LogInfoRequest request) async {
        /// if you want to send logs to your own server, you can use this method.
        /// This method is called when it cathes an error log.
        /// The info and warning logs before the error log also appear as a list.
        bool isSuccess = await postLogs(request);
        return isSuccess;
      });
}

/// When an error accurs, you can send the logs along with the info and warnings before error to your own server in this way.
Future<bool> postLogs(LogInfoRequest request) async {
  var dio = Dio();
  var url = 'https://your.log.url';
  var data = request.toJson();

  try {
    Response response = await dio.post(url, data: data);
    if (response.statusCode == HttpStatus.ok) {
      return true;
    }
  } catch (e) {
    Log.e(e);
  }
  return false;
}
```
Call initializeLog() method in main method.
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  /// if you want to integrate with firebase
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  await initializeLog();

  runApp(const MyApp());
}
```
You can print the logs as follows:
```dart
    try {
      Log.i("test info");
      Log.w("warning info");
      if (1 == 1) {
        throw Exception("Test Error");
      }
    } catch (e) {
      Log.e(e, message: "catch in build method (test)");
    }
```
As a result, the logs look like this:
![`Image not found`](assets/log.png)

Each log consists of Log Type (INFO, WARNING, ERROR), Date, Class Name, Method Name, adn Description respectively.
In the Error log, error details and stackTrace of the error are given in the bottom line.