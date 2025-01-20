import 'package:flutter/material.dart';

class NewSearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final Color backgroundColor;

  const NewSearchBar({
    required this.onChanged,
    required this.backgroundColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        onChanged: onChanged,
        decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white24),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple),
          ),
          labelText: "Have a gif in mind?",
          labelStyle: TextStyle(color: Colors.white24),
          suffixIcon: Icon(
            Icons.search,
            color: Colors.white24,
          ),
        ),
      ),
    );
  }
}
