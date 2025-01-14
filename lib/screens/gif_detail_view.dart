import 'package:flutter/material.dart';

class GifDetailView extends StatelessWidget {
  final String gifUrl;

  const GifDetailView({required this.gifUrl, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 25, 25, 25),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          'GIF info',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        backgroundColor: const Color.fromARGB(255, 25, 25, 25),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(gifUrl),
            Column(
              children: [
                SizedBox(height: 8.0),
                Text(
                  'Copy URL:',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Column(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: Colors.white24,
                        )),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SelectableText(
                            gifUrl,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
