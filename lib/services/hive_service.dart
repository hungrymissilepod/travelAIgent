import 'dart:io';

import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' show join;
import 'package:travel_aigent/app/app.logger.dart';

class HiveKeys {
  static const String cheatsOn = 'cheatsOn';
  static const String destinationValidationDisabled =
      'destinationValidationDisabled';
  static const String numTimesAppColdStarted = 'numTimesAppColdStarted';
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
    await _incremenetColdStarts();
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

  /// We keep track of the number of times the user has cold started the app
  /// We use this info for things like showing ads to the user
  Future<void> _incremenetColdStarts() async {
    final int? num = await read(HiveKeys.numTimesAppColdStarted);
    if (num == null) {
      await write(HiveKeys.numTimesAppColdStarted, 1);
    } else {
      await write(HiveKeys.numTimesAppColdStarted, num + 1);
    }
  }

  Future<void> clear() async {
    await Hive.close();
    await Hive.deleteFromDisk();
  }
}
