import 'dart:async';

import 'package:flutter/foundation.dart';

import '../db/log_store.dart';
import '../model/log_info.dart';

/// Unsent logs prepared for the server, with the store position they reach
class UnsentLogs {
  /// Logs, oldest first
  final List<LogInfo> logs;

  /// Store position right after these logs
  final LogCursor? end;

  /// Whether more unsent logs are waiting after this batch
  final bool hasMore;

  /// Creates a batch
  const UnsentLogs(this.logs, this.end, this.hasMore);
}

/// Asıl logların kaydedilip yönetildiği yerdir
class LogInfoRepo {
  static LogInfoRepo? _instance;

  /// Shared repo instance
  static LogInfoRepo get instance {
    _instance ??= LogInfoRepo._();
    return _instance!;
  }

  LogInfoRepo._();

  /// Maximum number of logs sent in one request
  static const int batchSize = 500;

  /// Completes with the opened store, or with null when local storage is unavailable.
  /// Logs written before [init] finishes wait for it instead of failing.
  final Completer<LogStore?> _store = Completer();

  /// Opens the store under the application support directory; never throws
  Future<void> init() async {
    if (_store.isCompleted) return;
    LogStore? store;
    try {
      store = await openDefaultStore();
    } catch (e) {
      _debugPrint(e);
    }
    if (!_store.isCompleted) _store.complete(store);
    unawaited(deleteLegacyLogFiles());
  }

  /// Turns local storage off; pending and later saves become no-ops
  void disable() {
    if (!_store.isCompleted) _store.complete(null);
  }

  /// Saves [log] with the current launch and error indexes
  Future<void> save(LogInfo log) async {
    final store = await _store.future;
    if (store == null) return;
    log.launchIndex = store.launchIndex;
    log.errorIndex = store.errorIndex;
    await store.append(log.toJson());
  }

  /// Starts a new error group
  Future<void> increaseErrorIndex() async {
    final store = await _store.future;
    await store?.increaseErrorIndex();
  }

  /// Reads the next batch of logs that have not been sent yet
  Future<UnsentLogs> getUnsentLogs() async {
    final store = await _store.future;
    if (store == null) return const UnsentLogs([], null, false);
    final batch = await store.readUnsent(maxLogs: batchSize);
    final logs = <LogInfo>[];
    for (final entry in batch.logs) {
      try {
        logs.add(LogInfo.fromJson(entry));
      } catch (_) {
        // An entry that no longer matches the model is skipped
      }
    }
    return UnsentLogs(logs, batch.end, batch.hasMore);
  }

  /// Marks the logs of [batch] (and everything before them) as sent
  Future<void> markSent(UnsentLogs batch) async {
    final end = batch.end;
    if (end == null) return;
    final store = await _store.future;
    await store?.markSent(end);
  }

  /// Kept for API compatibility; the store holds no open handles
  Future<void> close() {
    return Future.value(null);
  }

  static void _debugPrint(Object e) {
    if (kDebugMode) debugPrint('log_tracking: $e');
  }
}
