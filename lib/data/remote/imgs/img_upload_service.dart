import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart' as path;

class ImgUploadService {
  final storageRef = FirebaseStorage.instance;

  /// 매개변수 : folderName - 스토리지 폴더 명, images - image picker로 가져온 사진 파일 목록
  Future<List<String>> uploadImgs(String folderName, List<File> images) async {
    // 이미지 업로드
    final List<String> imageUrls = [];

    for (int i = 0; i < images.length; i++) {
      final file = images[i];
      final fileName =
          '${DateTime.now().toIso8601String()}_${i}_${path.basename(file.path)}';
      final ref = storageRef.ref().child('$folderName/$fileName');
      final uploadTask = ref.putFile(file);
      final snapshot = await uploadTask.whenComplete(() {});

      if (snapshot.state == TaskState.success) {
        final url = await ref.getDownloadURL();
        imageUrls.add(url);
      } else {
        throw ('Error uploading image ${i + 1}');
      }
    }

    return imageUrls;
  }
}
