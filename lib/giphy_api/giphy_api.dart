import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io' show Platform;

class GiphyApi {
  final String apiKey = getGiphyApiKey();
  final http.Client apiClient;
  GiphyApi({required this.apiClient});

  // Search GIFs with Pagination
  Future<List<dynamic>> fetchSearchGifs(BuildContext context, String query,
      {int offset = 0, int limit = 20}) async {
    if (query.isEmpty) return [];

    final url =
        'https://api.giphy.com/v1/gifs/search?api_key=$apiKey&q=$query&limit=$limit&offset=$offset';
    return await _fetchGifs(context, url);
  }

  // Fetch Trending GIFs with Pagination
  Future<List<dynamic>> fetchTrendingGifs(BuildContext context,
      {int offset = 0, int limit = 20}) async {
    final url =
        'https://api.giphy.com/v1/gifs/trending?api_key=$apiKey&limit=$limit&offset=$offset';
    return await _fetchGifs(context, url);
  }

  // Handle HTTP requests and errors
  Future<List<dynamic>> _fetchGifs(BuildContext context, String url) async {
    try {
      final response = await apiClient.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // If successful
        final data = json.decode(response.body);
        if (data['data'] != null) {
          if (data['data'].isEmpty) {
            _showSnackBar(context, 'No GIFs found');
            return [];
          }
          return data['data'];
        } else {
          _showSnackBar(context, 'Problem showing GIFs');
          return [];
        }
      // Exceptions
      } else {
        _showSnackBar(context, 'Failed to fetch GIFs: ${response.statusCode}');
        return [];
      }
    // If no internet connection, or timeout error
    } catch (e) {
      _showSnackBar(context, 'Failed to connect: $e');
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
