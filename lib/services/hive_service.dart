import 'dart:io';

import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' show join;
import 'package:travel_aigent/app/app.logger.dart';

class HiveKeys {
  static const String cheatsOn = 'cheatsOn';
  static const String destinationValidationDisabled = 'destinationValidationDisabled';
}

class HiveService {
  late Box _box;
  final String _boxId = 'box';
  final Logger _logger = getLogger('HiveService');

  Future<void> init() async {
    if (Hive.isBoxOpen(_boxId)) return;
    _logger.i('init hive');
    final Directory docDir = await getApplicationDocumentsDirectory();
    final String path = join(docDir.path, _boxId);
    Hive.init(path);
    _box = await Hive.openBox(_boxId);
  }

  Future<void> write(String key, dynamic value) async {
    if (!_box.isOpen) {
      await init();
    }
    await _box.put(key, value);
  }

  Future<dynamic> read(String key) async {
    if (!_box.isOpen) {
      await init();
    }
    return await _box.get(key);
  }

  Future<void> clear() async {
    await Hive.close();
    await Hive.deleteFromDisk();
  }
}
