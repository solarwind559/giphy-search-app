import 'package:flutter/material.dart';
import 'package:giphy_search/screens/gif_detail_view.dart';

class GifGrid extends StatelessWidget {
  final List<dynamic> searchResults;

  const GifGrid({required this.searchResults, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return GridView.builder(
      itemCount: searchResults.length,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GifDetailView(
                  gifUrl: searchResults[index]['images']['original']['url'],
                ),
              ),
            );
          },
          child: Container(
            color: Color.fromARGB(255, 50, 50, 50),
            child: Image.network(
              searchResults[index]['images']['original']['url'],
              fit: BoxFit.cover,
            ),
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