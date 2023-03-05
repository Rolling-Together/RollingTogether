import 'package:flutter/material.dart';

Widget CostomChip(String label,Icon icon ,Color color) {
  return Chip(
    labelPadding: EdgeInsets.all(2.0),
    avatar: CircleAvatar(
      backgroundColor: Colors.white70,
      //child: Text(label[0].toUpperCase()),
      child: icon,
    ),
    label: Text(
      label,
      style: TextStyle(
        color: Colors.white,
      ),
    ),
    backgroundColor: color,
    elevation: 6.0,
    shadowColor: Colors.grey[60],
    padding: EdgeInsets.all(8.0),
  );
}