import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

class DownloadedImgDto {
  final Uint8List? img;
  final FullMetadata metaData;

  DownloadedImgDto({required this.img, required this.metaData});
}
