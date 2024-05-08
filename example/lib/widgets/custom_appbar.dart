import 'package:flutter/material.dart';

// class CustomAppBar extends StatelessWidget {
//   final String title;
//   const CustomAppBar({super.key, required this.title});

//   @override
//   PreferredSizeWidget? build(BuildContext context) {
//     return AppBar(
//       centerTitle: true,
//       title: Text(title,style: TextStyle(),),
//     );
//   }
// }
class CustomAppBar {
  static PreferredSizeWidget? appbar(String title) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }
}
