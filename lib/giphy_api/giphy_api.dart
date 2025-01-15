import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io' show Platform;

class GiphyApi {
  final String apiKey = getGiphyApiKey();
  // Search
  Future<List<dynamic>> searchGifs(BuildContext context, String query) async {
    if (query.isEmpty) return [];

    final url = 'https://api.giphy.com/v1/gifs/search?api_key=$apiKey&q=$query&limit=20&offset=0';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['data'];
      } else {
        _showSnackBar(context, 'Failed to fetch GIFs: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      _showSnackBar(context, 'Failed to fetch GIFs: $e');
      return [];
    }
  }

  // Trending
  Future<List<dynamic>> fetchTrendingGifs(BuildContext context) async {
    final url = 'https://api.giphy.com/v1/gifs/trending?api_key=$apiKey&limit=20&offset=0';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['data'];
      } else {
        _showSnackBar(context, 'Failed to fetch trending GIFs: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      _showSnackBar(context, 'Failed to fetch trending GIFs: $e');
      return [];
    }
  }
}

// Snackbar is a widget provided by flutter to display a dismissible pop-up message on your application.
void _showSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

// Handle... different API keys for .... ios and Android, as per documentation.
String getGiphyApiKey() {
  if (Platform.isIOS) {
    return 'hLxfYj0tslzlDjIUNmJqSLggjra8nigd';
  } else if (Platform.isAndroid) {
    return 'pYstvToklKSFJk862BESFwzoMwXzcDND';
  } else {
    return 'pYstvToklKSFJk862BESFwzoMwXzcDND';
  }
}