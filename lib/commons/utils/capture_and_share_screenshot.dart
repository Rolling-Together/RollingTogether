import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:share_plus/share_plus.dart';

Future<void> takeScreenshotAndShare(
    ScreenshotController screenshotController) async {
  try {
    Uint8List? screenshotImgFile = await screenshotController.capture();
    final dir = await getTemporaryDirectory();
    File saveFile = await File(
            '${dir.path}/rt_screenshots_${DateTime.now().toIso8601String()}'
            '.png')
        .create();
    await saveFile.writeAsBytes(screenshotImgFile!);
    await ImageGallerySaver.saveImage(screenshotImgFile);

    // await Share.shareFiles([saveFile.path]);
    await Share.shareXFiles([XFile(saveFile.path)]);
  } catch (e) {
    log(e.toString());
  }
}
