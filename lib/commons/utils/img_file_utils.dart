import 'dart:io';
import 'package:path/path.dart' as path;

class ImgFileUtils {
  static String convertFileName(File file) =>
      '${DateTime.now().toIso8601String()}_${path.basename(file.path)}';
}
