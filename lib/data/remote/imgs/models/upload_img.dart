import 'dart:io';

class UploadImgDto {
  final File file;
  final String fileName;

  UploadImgDto({required this.file, required this.fileName});
}
