import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:rolling_together/data/remote/imgs/models/img.dart';

class ImgDownloadService {
  final storage = FirebaseStorage.instance;

  Future<DownloadedImgDto> downloadImage(
      String folderName, String fileName) async {
    try {
      final ref = storage.ref('$folderName/$fileName');
      final metaData = await ref.getMetadata();
      final data = await ref.getData();

      return Future.value(DownloadedImgDto(img: data, metaData: metaData));
    } catch (e) {
      return Future.error('failed');
    }
  }
}
