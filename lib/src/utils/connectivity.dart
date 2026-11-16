import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

/// Subscription to connectivity changes; replaced on every [listenConnectivity] call
StreamSubscription<List<ConnectivityResult>>? _subscription;

/// Last known connection state; null until the first check
bool? _wasOnline;

/// Calls [onOnline] once at startup when a connection exists and again on every
/// transition from offline to online. Errors of the connectivity plugin are ignored.
void listenConnectivity(void Function() onOnline) {
  _subscription?.cancel();
  final connectivity = Connectivity();

  void handle(List<ConnectivityResult> result) {
    final isOnline =
        result.isNotEmpty && !result.contains(ConnectivityResult.none);
    if (isOnline && _wasOnline != true) onOnline();
    _wasOnline = isOnline;
  }

  connectivity.checkConnectivity().then(handle).catchError((_) {});
  _subscription =
      connectivity.onConnectivityChanged.listen(handle, onError: (_) {});
}
