import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rolling_together/commons/enum/facility_types.dart';

class ImageAssetLoader {
  final RxMap<SharedDataCategory, Uint8List> markerIconsMap =
      <SharedDataCategory, Uint8List>{}.obs;

  final Map<SharedDataCategory, IconData> iconsMap =
      <SharedDataCategory, IconData>{};

  static final ImageAssetLoader instance = ImageAssetLoader.internal();

  factory ImageAssetLoader() {
    return instance;
  }

  static ImageAssetLoader getInstance() {
    return instance;
  }

  ImageAssetLoader.internal();

  /// 모든 아이콘 및 마커 로드
  Future<bool> loadImages() async {
    for (final element in SharedDataCategory.values) {
      if (element.iconPath.isNotEmpty) {
        iconsMap[element] = element.iconData;
        markerIconsMap[element] = await getBytesFromAsset(element.iconPath);
      }
    }
    return true;
  }

  Future<Uint8List> getBytesFromAsset(String path,
      {int width = 115, int height = 140}) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width, targetHeight: height);
    ui.FrameInfo fi = await codec.getNextFrame();
    return Uint8List.fromList(
      (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
          .buffer
          .asUint8List(),
    );
  }
}
