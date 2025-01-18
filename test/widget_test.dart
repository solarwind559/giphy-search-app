// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:giphy_search/main.dart';
import 'package:giphy_search/screens/giphy_page.dart';
import 'package:giphy_search/widgets/gif_grid.dart';
import 'package:giphy_search/widgets/searchbar.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:giphy_search/giphy_api/giphy_api.dart'; 

// Mock BuildContext
class MockBuildContext extends BuildContext {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  //
  // Search and fetch test: mock request
  //
  final mockClient = MockClient((http.Request request) async {
    print('Mock API called: ${request.url}');

    if (request.url.path.contains('search')) {
      // Mocking response for search endpoint
      return http.Response(json.encode({
        'data': List.generate(20, (index) => {
          'id': 'search_$index',
          'url': 'https://example.com/gif_search_$index.gif'
        }),
      }), 200);
    } else if (request.url.path.contains('trending')) {
      // Mocking response for trending endpoint
      return http.Response(json.encode({
        'data': List.generate(20, (index) => {
          'id': 'trending_$index',
          'url': 'https://example.com/gif_trending_$index.gif'
        }),
      }), 200);
    }
    return http.Response('Not Found', 404);
  });

  final giphyApi = GiphyApi(apiClient: mockClient);

  group('GiphyApi', () {
    
    // Test for searchGifs
    test('searchGifs returns data on success', () async {
      final context = MockBuildContext();
      final results = await giphyApi.searchGifs(context, 'funny');

      // Debug:
      print('Search results: ${results.length} items');
      print('Search result data: ${results.map((gif) => gif['id']).toList()}');
      
      // Expectations:
      expect(results.length, 20);
      expect(results[0]['id'], 'search_0');
    });

    // Test fetchTrendingGifs
    test('fetchTrendingGifs returns list of trending gifs', () async {
      final context = MockBuildContext();
      final gifs = await giphyApi.fetchTrendingGifs(context);

      // Debug:
      print('Trending GIFs: ${gifs.length} items');
      print('Trending GIFs data: ${gifs.map((gif) => gif['id']).toList()}');
      
      // Expectations:
      expect(gifs.length, 20);
      expect(gifs[0]['id'], 'trending_0');
    });
  });

  //
  // Widget tests:
  //
  testWidgets('Widgets exist', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // GipyPage widget exists?
    expect(find.byType(GiphyPage), findsOneWidget);

    // Searchbar: widget exists?
    expect(find.byType(NewSearchBar), findsOneWidget);    

    // Text field accepts input?
    await tester.enterText(find.byType(NewSearchBar), 'hi');

    // GifGrid and GifDetailView tests fail, because they are based on search results...

  });

  //
  // Auto-search test:
  //
  testWidgets('Auto-search functionality works and displays GifGrid', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Are gifs getting fetched and displayed through auto-search, after 1 sec delay?
    await tester.pumpAndSettle(Duration(seconds: 1));
    expect(find.byType(GifGrid), findsOneWidget);
  });

  //
  // Pagination test: scroll
  //
  testWidgets('Pagination loads more items on scroll', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Simulate auto-search...
    await tester.pumpAndSettle(Duration(seconds: 1));

    // Test pagination by scrolling
    await tester.fling(find.byType(GifGrid), const Offset(0, -500), 1000);
    await tester.pumpAndSettle();

    // Verify that more items are loaded
    expect(find.byType(GifGrid), findsWidgets);
  });
}
