import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

/// Created by İrfan Öngüç
/// on 26.05.2022

var connectivity = Connectivity();
ValueNotifier<bool> isOnlineNotifier = ValueNotifier(true);

check() {
  connectivity.checkConnectivity().then((value) {
    _setHasActiveDataConnection(value);
  });
  connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
    _setHasActiveDataConnection(result);
  });
}

void _setHasActiveDataConnection(ConnectivityResult result) {
  final bool isOnline = result != ConnectivityResult.none;
  hasActiveDataConnectionJob(isOnline);
}

hasActiveDataConnectionJob(isOnline) {
  if (isOnline == false) {
    isOnlineNotifier.value = false;
    return isOnline;
  }
  return hasActiveDataConnection();
}

Future<bool> hasActiveDataConnection() async {
  bool previousConnection = true;

  try {
    final result = await InternetAddress.lookup('google.com');
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
