// part of flutter_package_test;
//
// /// Created by İrfan Öngüç
// /// on 07 May 2021
//
// class DeviceInfo {
//   String deviceId;
//   String deviceType;
//
//   /// The method channel used to interact with the native platform.
//   @visibleForTesting
//   MethodChannel channel = MethodChannel('flutter/platform');
//
//   // MethodChannel channel = MethodChannel('plugins.flutter.io/device_info');
//
//   Future androidInfo() async {
//     var mm = await channel.invokeMapMethod<String, dynamic>('getAndroidDeviceInfo');
//     return mm ?? <String, dynamic>{};
//   }
//
// // Method channel for iOS devices
//   Future iosInfo() async {
//     return (await channel
//             .invokeMapMethod<String, dynamic>('getIosDeviceInfo')) ??
//         <String, dynamic>{};
//   }
//
//   Future getDeviceId() {
//     if (Platform.isAndroid) {
//       return androidInfo();
//     } else if (Platform.isIOS) {
//       return iosInfo();
//     } else if (Platform.isLinux) {
//       return null;
//     } else if (Platform.isMacOS) {
//       return null;
//     } else if (Platform.isWindows) {
//       return null;
//     } else if (Platform.isFuchsia) {
//       return null;
//     }
//   }
// }
