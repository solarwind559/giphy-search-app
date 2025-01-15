#### Technical
+ Primary platforms - iOS & Android; 
###### Different api keys for ios and android, as per documentation... implemented CupertinoApp for ios and MaterialApp widgets for android.
+ Auto search - requests to retrieve Gif information from the service are made automatically with a small delay after user stops typing;
+ Pagination - loading more results when scrolling;
+ Vertical & horizontal orientation support; 
###### OrientationBuilder
+ Error handling;
- Unit tests - as much as you see fit;

#### UI
+ Responsive & matching platform guidelines;
+ At least 2 views sourced by data from Giphy; 
###### "trending" view and the "search" TabBar view, and "single gif info" view
+ Results are displayed in a grid;
+ Clicking on a grid item should navigate to a detailed Gif view. 
###### GifDetailView widget
+ Loading indicators; 
###### CircularProgressIndicator, in the center of app screen, FadeInImage widget... and background color set before gif loads.
+ Error display; 
###### SnackBar messages widget

#### Bonus points:
- Using state management approaches or libraries such as BLoC (flutter_bloc), Riverpod or others;
? Using an understandable architecture pattern;
? Page navigation is separate from page widget code (a Coordinator pattern or similar);
? Network availability handling;


