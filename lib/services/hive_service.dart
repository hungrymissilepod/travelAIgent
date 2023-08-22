import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' show join;

class HiveKeys {
  static const String onBoardingCarouselSeen = 'onBoardingCarouselSeen';
  static const String cheatsOn = 'cheatsOn';
  static const String destinationValidationDisabled =
      'destinationValidationDisabled';
}

class HiveService {
  late Box _box;
  final String _boxId = 'box';

  Future<void> init() async {
    if (Hive.isBoxOpen(_boxId)) return;
    final Directory docDir = await getApplicationDocumentsDirectory();
    final String path = join(docDir.path, _boxId);
    Hive.init(path);
    _box = await Hive.openBox(_boxId);
  }

  Future<void> write(String key, dynamic value) async {
    await _box.put(key, value);
  }

  Future<dynamic> read(String key) async {
    return await _box.get(key);
  }

  Future<void> clear() async {
    await Hive.deleteFromDisk();
  }
}
