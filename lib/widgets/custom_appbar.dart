import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final IconThemeData? iconTheme; // Add this parameter

  const CustomAppBar({Key? key, this.iconTheme}) : super(key: key); // Include in constructor

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 15, 15, 15),
      toolbarHeight: 60.0,
      iconTheme: iconTheme, // Use the parameter
      flexibleSpace: Center(
        child: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: <Color>[
              Colors.yellow,
              Colors.green,
              Colors.blue,
              Colors.purple,
            ],
            tileMode: TileMode.mirror,
          ).createShader(bounds),
          child: const Text(
            'Giphy Search App',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
