import 'package:flutter/material.dart';

class NewSearchBar extends StatelessWidget {
  final Widget child;

  const NewSearchBar({Key? key, required this.child, required Color backgroundColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: child,
    );
  }
}