import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:rolling_together/data/remote/imgs/models/upload_img.dart';

class ImgUploadService {
  final storageRef = FirebaseStorage.instance;

  /// 매개변수 : folderName - 스토리지 폴더 명, images - 사진 파일 목록
  Future<bool> uploadImgs(String folderName, List<UploadImgDto> images) async {
    // 이미지 업로드
    for (int i = 0; i < images.length; i++) {
      final file = images[i].file;
      final fileName = images[i].fileName;
      final ref = storageRef.ref().child('$folderName/$fileName');
      final uploadTask = ref.putFile(file);
      final snapshot = await uploadTask.whenComplete(() {});
    }

    return Future.value(true);
  }
}
