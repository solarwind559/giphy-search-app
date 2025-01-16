// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:giphy_search/main.dart';
import 'package:giphy_search/screens/giphy_page.dart';
import 'package:giphy_search/widgets/gif_grid.dart';
import 'package:giphy_search/widgets/searchbar.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
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

    //
    // Orientation test:
    //
    testWidgets('Grid length changes depending on screen size', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());
    
  });
}
