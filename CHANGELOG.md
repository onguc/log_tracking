## 0.5.2
* The package is fully WebAssembly (WASM) compatible: device and app info come from platform specific readers, so `dart:io` is never reached from the public library on web
* Web builds no longer depend on `device_info_plus`, `flutter_udid` or `package_info_plus`; app version is read from `version.json`
* Linux and Windows device info are now reported instead of the placeholder values
* Removed the unused `Util` helper
## 0.5.1
* WebAssembly (WASM) support: `dart:io` is now used only on native platforms, so the package is fully wasm-compatible
* Static analysis is clean: fixed lints and added dartdoc comments to the public API
* Example app builds for web and wasm
## 0.5.0
* Local storage rewritten as append-only daily segments with a sent cursor; the JSON index files are gone
* Fixed: index files grew on every launch, byte offsets broke on non-ASCII text, empty index files crashed startup
* Logs are kept at most 7 days and 5 MB, and are stored under the application support directory instead of documents
* Files of the old storage are deleted on first launch
* Log.i/w/e/d never throw; storage errors no longer reach the app
* Unsent logs are sent in batches of 500, one send at a time, and only marked sent after success
* Launch and error indexes are persisted
* Connectivity check no longer makes a DNS lookup to a fixed host
* iPad is reported as brand "ipad"
## 0.4.0
* Isar Db removed
* Compatibility with Dart 3.9.0
## 0.3.13
* Date corrections have been made
* Design improvements have been made
## 0.3.12
* debug listening added
## 0.3.11
* minor change
## 0.3.10
* status null problem fixed
## 0.3.9

* A db problem solved
## 0.3.8

* Improvements have been made to db
## 0.3.7

* A problem solved
## 0.3.6

* Initial version, created by ngcyaz
