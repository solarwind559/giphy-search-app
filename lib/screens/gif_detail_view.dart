import 'package:flutter/material.dart';
import 'package:giphy_search/widgets/custom_appbar.dart';

class GifDetailView extends StatelessWidget {
  final String gifUrl;
  final String gifTitle;

  const GifDetailView({required this.gifTitle, required this.gifUrl, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 25, 25, 25),
      appBar: CustomAppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text( 
                gifTitle, 
                style: TextStyle( 
                  color: Colors.white, 
                  fontSize: 20, 
                  fontWeight: FontWeight.bold, 
                  ), 
                ),
            ),
            Image.network(gifUrl),
            Column(
              children: [
                SizedBox(height: 20),
                Text(
                  'Copy URL:',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
