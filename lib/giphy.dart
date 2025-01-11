import 'package:flutter/material.dart';
import 'package:giphy_search/widgets/searchbar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';


class GiphyPage extends StatefulWidget {
  const GiphyPage({super.key});

  @override
  State<GiphyPage> createState() => _GiphyPageState();
}

class _GiphyPageState extends State<GiphyPage> {
  List<dynamic> _searchResults = [];
  String _searchQuery = '';

  // Auto search
  Timer? _debounce;


  void _searchGifs(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults.clear();
      });
      return;
    }

    final apiKey = 'pYstvToklKSFJk862BESFwzoMwXzcDND';
    final url =
        'https://api.giphy.com/v1/gifs/search?api_key=$apiKey&q=$query&limit=20&offset=0';

    // final trendy = 'https://api.giphy.com/v1/gifs/trending?api_key=$apiKey&q=$query&limit=20&offset=0';
    
// Error Handling:

  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['data'].isEmpty) {
        // Empty search results?
        _showSnackBar('No such GIFs found.');
      } else {
        setState(() {
          _searchResults = data['data'];
        });
      }
    } else {
      _showSnackBar('Failed to fetch GIFs: ${response.statusCode}');
    }
  } catch (e) {
    _showSnackBar('Failed to fetch GIFs: $e');
  }
}

// Snackbar is a widget provided by flutter to display a dismissible pop-up message on your application.
void _showSnackBar(String message) {
  final snackBar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

// Auto Search
  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(
      const Duration(milliseconds: 500), () {
      _searchGifs(query);
    }
    );
  }

   @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
// Ends autosearch

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 25, 25, 25),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 25, 25, 25),
        toolbarHeight: 40.0, // Adjust the height as needed
        flexibleSpace: Center(
          child: Padding(
            padding: const EdgeInsets.only(
                top: 10), // Adjust padding
            child: Text(
              'Giphy Search App',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          NewSearchBar(
            backgroundColor: const Color.fromARGB(255, 25, 25, 25),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.all(10),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      
                      // onChanged: (value) {
                      //   _searchQuery = value;
                      //   _searchGifs(_searchQuery);
                      // },
                      onChanged: _onSearchChanged,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 72, 72, 72)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurple),
                        ),
                        labelText: "Have a gif in mind?",
                        suffixIcon: Icon(
                          Icons.search,
                          color: Colors.white24,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Grid view
          Expanded(
            child: GridView.builder(
              itemCount: _searchResults.length,
              padding: const EdgeInsets.all(10),
              itemBuilder: (context, index) {
                return Image.network(
                  _searchResults[index]['images']['original']['url'],
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                crossAxisCount: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
