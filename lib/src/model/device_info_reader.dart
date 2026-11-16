/// Picks the device info reader for the current platform at compile time.
library;

export 'device_info_reader_io.dart'
    if (dart.library.js_interop) 'device_info_reader_web.dart';
