import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/services.dart' show rootBundle;

class Setup {
  static Future<List<(String, String)>> loadAssetsToDirectory() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    Directory directory = Directory(path.join(dbFolder.path, "shit", "sounds"));
    if(!directory.existsSync()){
      directory.createSync(recursive: true);
    }
    var soundAssets = List<String>.of(["ding.mp3", "ding2.mp3", "end.mp3", "water_drop.mp3"]);
    var files = List<(String, String)>.empty(growable: true);
    for (String asset in soundAssets) {
      files.add((asset, await _writeAssetToDirectory(asset, directory.path)));
    }
    return files;
  }

  static Future<String> _writeAssetToDirectory(
      String assetName, String destination) async {
    var bytes = await rootBundle.load("assets/$assetName");
    var filepath = path.join(destination,assetName);
    await _writeToFile(bytes, filepath);
    return filepath;
  }

  static Future<void> _writeToFile(ByteData data, String path) async {
    final buffer = data.buffer;
    File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }
}
