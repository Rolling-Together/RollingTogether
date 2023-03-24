import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

Future<String?> captureImage() async {
  final screenshotController = ScreenshotController();

  try {
    // 현재 화면을 캡쳐하여 바이트 배열로 저장
    final uint8List = await screenshotController.capture();

    // 바이트 배열이 존재하지 않으면 null 반환
    if (uint8List == null) return null;

    // 이미지 파일을 저장할 경로 가져오기
    final directory = await getApplicationDocumentsDirectory();
    final imagePath = '${directory.path}/screenshot.png';

    // 이미지 파일을 저장
    final file = File(imagePath);
    await file.writeAsBytes(uint8List);

    // 이미지 파일의 경로 반환
    return imagePath;
  } catch (e) {
    print('captureImage error: $e');
    return null;
  }
}