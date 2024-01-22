import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

/// Created by İrfan Öngüç
/// on 26.05.2022

var _connectivity = Connectivity();
ValueNotifier<bool> isOnlineNotifier = ValueNotifier(true);

checkConnectivity() {
  _connectivity.checkConnectivity().then((value) {
    _setHasActiveDataConnection(value);
  });
  _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
    _setHasActiveDataConnection(result);
  });
}

void _setHasActiveDataConnection(ConnectivityResult result) {
  final bool isOnline = result != ConnectivityResult.none;
  _hasActiveDataConnectionJob(isOnline);
}

_hasActiveDataConnectionJob(isOnline) {
  if (!isOnline) {
    isOnlineNotifier.value = false;
    return isOnline;
  }
  return _hasActiveDataConnection();
}

Future<bool> _hasActiveDataConnection() async {
  bool previousConnection = true;

  try {
    final result = await InternetAddress.lookup('https://vuhuv.com/');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      previousConnection = true;
    } else {
      previousConnection = false;
    }
  } on SocketException catch (_) {
    previousConnection = false;
  }
  isOnlineNotifier.value = previousConnection;
  return previousConnection;
}
