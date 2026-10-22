import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:log_tracking/src/db/log_store.dart';
import 'package:path/path.dart' as path;

void main() {
  late Directory dir;

  setUp(() async {
    dir = await Directory.systemTemp.createTemp('log_store_test');
  });

  tearDown(() async {
    await dir.delete(recursive: true);
  });

  /// Segment files currently in the store, oldest first
  List<String> segmentNames() {
    final names = dir.listSync().map((e) => path.basename(e.path)).where((n) => n.startsWith('logs_')).toList();
    names.sort();
    return names;
  }

  test('reads unsent logs with non-ASCII text and honours the sent cursor', () async {
    final store = await LogStore.open(dir);
    await store.append({'text': 'Randevu kaydedildi — çğış'});
    await store.append({'text': 'مرحبا'});

    final first = await store.readUnsent();
    expect(first.logs.map((e) => e['text']), ['Randevu kaydedildi — çğış', 'مرحبا']);
    expect(first.hasMore, isFalse);

    await store.markSent(first.end!);
    expect((await store.readUnsent()).logs, isEmpty);

    await store.append({'text': 'Tiếng Việt'});
    expect((await store.readUnsent()).logs.map((e) => e['text']), ['Tiếng Việt']);
  });

  test('keeps counters and cursor across launches', () async {
    var store = await LogStore.open(dir);
    expect(store.launchIndex, 1);
    expect(store.errorIndex, 1);
    await store.append({'text': 'a'});
    await store.markSent((await store.readUnsent()).end!);
    await store.increaseErrorIndex();
    await store.append({'text': 'b'});

    store = await LogStore.open(dir);
    expect(store.launchIndex, 2);
    expect(store.errorIndex, 2);
    expect((await store.readUnsent()).logs.map((e) => e['text']), ['b']);
  });

  test('opens with an empty or damaged state file', () async {
    await File(path.join(dir.path, 'state.json')).writeAsString('');
    var store = await LogStore.open(dir);
    expect(store.launchIndex, 1);

    await File(path.join(dir.path, 'state.json')).writeAsString('{"launchIndex": 4, "errorIn');
    store = await LogStore.open(dir);
    expect(store.launchIndex, 1);
  });

  test('skips a line left unfinished by a crash', () async {
    final store = await LogStore.open(dir, now: () => DateTime(2026, 10, 22));
    await store.append({'text': 'first'});
    await File(path.join(dir.path, segmentNames().single)).writeAsString('{"text": "bro', mode: FileMode.append);

    final reopened = await LogStore.open(dir, now: () => DateTime(2026, 10, 22));
    await reopened.append({'text': 'after crash'});
    expect((await reopened.readUnsent()).logs.map((e) => e['text']), ['first', 'after crash']);
  });

  test('returns batches with hasMore', () async {
    final store = await LogStore.open(dir);
    for (var i = 0; i < 5; i++) {
      await store.append({'i': i});
    }
    final first = await store.readUnsent(maxLogs: 3);
    expect(first.logs.map((e) => e['i']), [0, 1, 2]);
    expect(first.hasMore, isTrue);
    await store.markSent(first.end!);

    final second = await store.readUnsent(maxLogs: 3);
    expect(second.logs.map((e) => e['i']), [3, 4]);
    expect(second.hasMore, isFalse);
  });

  test('rotates segments and keeps the total size under the limit', () async {
    final store = await LogStore.open(dir, maxSegmentBytes: 200, maxTotalBytes: 600, now: () => DateTime(2026, 10, 22));
    for (var i = 0; i < 40; i++) {
      await store.append({'text': 'entry $i'.padRight(40, '.')});
    }
    final names = segmentNames();
    expect(names.length, greaterThan(1));
    final total = names.fold<int>(0, (sum, n) => sum + File(path.join(dir.path, n)).lengthSync());
    expect(total, lessThanOrEqualTo(600 + 200));

    // The newest entry is always readable
    final unsent = await store.readUnsent(maxLogs: 1000);
    expect(unsent.logs.last['text'], startsWith('entry 39'));
  });

  test('deletes segments older than maxAge on open', () async {
    var day = DateTime(2026, 10, 1);
    var store = await LogStore.open(dir, now: () => day);
    await store.append({'text': 'old'});

    day = DateTime(2026, 10, 22);
    store = await LogStore.open(dir, now: () => day);
    await store.append({'text': 'new'});

    expect(segmentNames(), ['logs_20261022_000.jsonl']);
    expect((await store.readUnsent()).logs.map((e) => e['text']), ['new']);
  });
}
