import 'package:flutter/material.dart';
import 'package:giphy_search/screens/gif_detail_view.dart';
class GifGridItem extends StatelessWidget {
  final dynamic gifData;

  const GifGridItem({required this.gifData, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GifDetailView(
              gifUrl: gifData['images']['original']['url'], gifTitle: gifData['title'],
            ),
          ),
        );
      },
      child: Container(
        color: Color.fromARGB(255, 50, 50, 50),
        child: Image.network(
          gifData['images']['original']['url'],
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
