import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io' show Platform;

class GiphyApi {
  final String apiKey = getGiphyApiKey();
  final http.Client apiClient;
  GiphyApi({required this.apiClient});

  // Search
  Future<List<dynamic>> searchGifs(BuildContext context, String query) async {
    if (query.isEmpty) return [];

    final url = 'https://api.giphy.com/v1/gifs/search?api_key=$apiKey&q=$query&limit=20&offset=0';
    print('Fetching GIFs URL: $url');

    try {
      final response = await apiClient.get(Uri.parse(url));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['data'];
      } else {
        print('Failed to fetch GIFs: ${response.statusCode}'); // Add detailed error information
        _showSnackBar(context, 'Failed to fetch GIFs: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Exception: $e'); // Add detailed exception information
      _showSnackBar(context, 'Failed to fetch GIFs: $e');
      return [];
    }
  }

  // Trending
  Future<List<dynamic>> fetchTrendingGifs(BuildContext context) async {
    final url = 'https://api.giphy.com/v1/gifs/trending?api_key=$apiKey&limit=20&offset=0';
    print('Fetching Trending GIFs URL: $url');

    try {
      final response = await apiClient.get(Uri.parse(url));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['data'];
      } else {
        print('Failed to fetch trending GIFs: ${response.statusCode}');
        _showSnackBar(context, 'Failed to fetch trending GIFs: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Exception: $e');
      _showSnackBar(context, 'Failed to fetch trending GIFs: $e');
      return [];
    }
  }
}

void _showSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

String getGiphyApiKey() {
  if (Platform.isIOS) {
    return 'hLxfYj0tslzlDjIUNmJqSLggjra8nigd';
  } else if (Platform.isAndroid) {
    return 'tWsBlPrUPH5JUBpPh3vgdwA7JRZ0zMZr';
  } else {
    return 'tWsBlPrUPH5JUBpPh3vgdwA7JRZ0zMZr';
  }
}
