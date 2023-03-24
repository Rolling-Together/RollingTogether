import 'package:flutter/material.dart';

class UserGradeDto {
  final String userId;
  final int reportCount;
  final Color iconColor;

  UserGradeDto(
      {required this.userId,
      required this.reportCount,
      required this.iconColor});
}
