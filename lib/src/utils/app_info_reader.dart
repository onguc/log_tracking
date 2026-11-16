/// Picks the app info reader for the current platform at compile time.
library;

export 'app_info_reader_io.dart'
    if (dart.library.js_interop) 'app_info_reader_web.dart';
