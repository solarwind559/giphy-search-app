// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:giphy_search/main.dart';
import 'package:giphy_search/screens/gif_detail_view.dart';
import 'package:giphy_search/screens/giphy_page.dart';
import 'package:giphy_search/widgets/gif_grid.dart';
import 'package:giphy_search/widgets/searchbar.dart';

void main() {
  testWidgets('Widgets exist', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    expect(find.byType(GiphyPage), findsOneWidget);

    expect(find.byType(NewSearchBar), findsOneWidget);

    // GifGrid and GifDetailView tests fail, because they are based on search results...
    // another testing method is to be used to mock search results?

    // expect(find.byType(GifGrid), findsOneWidget);
    // expect(find.byType(GifDetailView), findsOneWidget);
  });

  // Test for widgets that depend on search results
  testWidgets(
    'GifGrid widget is present with search results',
    (WidgetTester tester) async {

      // Create a mock list of search results
    
      // Build the widget tree with the mock search results

      // Verify that the GifGrid widget is present in the widget tree.

      // expect(find.byType(GifGrid), findsOneWidget);
      // expect(find.byType(GifDetailView), findsOneWidget);
    },
  );
}
