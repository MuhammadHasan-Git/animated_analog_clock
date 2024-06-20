import 'package:flutter/material.dart';

class CustomAppBar {
  static PreferredSizeWidget? appBar(String title) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }
}
