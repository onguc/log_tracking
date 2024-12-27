import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as path;

/// Created by onguc
/// on 26.12.2024

class DateIndex {
  final String field;
  final Map<String, int> dateIndex = {};
  final Map<int, String> positionIndex = {};

  final String indexPath;

  DateIndex(this.field, String baseDir) : indexPath = path.join(baseDir, '${field}_index.json');

  Future<void> load() async {
    final file = File(indexPath);
    if (await file.exists()) {
      final content = await file.readAsString();
      Map<String, dynamic> data = json.decode(content);

      try {
        data.forEach((key, value) {
          dateIndex[key] = value;
          positionIndex[value] = key;
        });
      } catch (e) {
        int x = 0;
      }
    } else {
      await file.create();
    }
  }

  Future<void> save() async {
    final file = File(indexPath);
    try {
      await file.writeAsString(json.encode(dateIndex));
    } catch (e) {
      int x = 0;
    }
  }

  void addEntry(String key, int position) {
    dateIndex[key] = position;
    positionIndex[position] = key;
  }

  int getPosition(String key) {
    return dateIndex[key] ?? 0;
  }

  DateTime? getDateTimeByPosition(int key) {
    var stringVal = positionIndex[key];
    if (stringVal != null && stringVal.isNotEmpty) {
      return DateTime.parse(stringVal);
    }
  }
}
