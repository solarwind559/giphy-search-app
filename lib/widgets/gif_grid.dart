import 'package:flutter/material.dart';

class GifGrid extends StatelessWidget {
  final List<dynamic> searchResults;

  const GifGrid({required this.searchResults, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return GridView.builder(
      itemCount: searchResults.length,
      padding: const EdgeInsets.all(10),
      itemBuilder: (context, index) {
        return Container(
          color: Color.fromARGB(255, 50, 50, 50),
          child: Image.network(
            searchResults[index]['images']['original']['url'],
            fit: BoxFit.cover,
          ),
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
      ),
    );
  }
}