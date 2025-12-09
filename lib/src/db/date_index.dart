import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as path;

/// Created by onguc
/// on 26.12.2024

/// Date index for logs
class DateIndex {
  /// Field name
  final String field;

  /// Index map
  final Map<String, int> dateIndex = {};

  /// Position map
  final Map<int, String> positionIndex = {};

  /// Path to index file
  final String indexPath;

  DateIndex(this.field, String baseDir) : indexPath = path.join(baseDir, '${field}_index.json');

  /// Loads the index from disk
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
        // ignore
      }
    } else {
      await file.create();
    }
  }

  /// Saves the index to disk
  Future<void> save() async {
    final file = File(indexPath);
    try {
      await file.writeAsString(json.encode(dateIndex));
    } catch (e) {
      // ignore
    }
  }

  /// Adds an entry to the index
  void addEntry(String key, int position) {
    dateIndex[key] = position;
    positionIndex[position] = key;
  }

  /// Gets position for a key
  int getPosition(String key) {
    return dateIndex[key] ?? 0;
  }

  /// Gets DateTime by position
  DateTime? getDateTimeByPosition(int key) {
    var stringVal = positionIndex[key];
    if (stringVal != null && stringVal.isNotEmpty) {
      return DateTime.parse(stringVal);
    }
    return null;
  }
}
