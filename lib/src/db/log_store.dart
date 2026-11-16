/// File based log storage.
///
/// The implementation is selected at compile time: native platforms use
/// `dart:io` based files, while web (JavaScript and WebAssembly) gets a stub
/// that keeps local storage disabled.
library;

export 'log_store_io.dart' if (dart.library.js_interop) 'log_store_web.dart';
