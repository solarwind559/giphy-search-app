# giphy_search

### Flutter version 3.27.1

![Search](assets/screenshots/search.png) 
![Trending](assets/screenshots/trending.png)
![Detail](assets/screenshots/detail_view.png) 

## Getting Started

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

#### Get the App on your machine
+ copy this git repository by clicking the "CODE" button and downloading the .zip file. Extract the .zip file.
+ copy the files into the project folder where you flutter is installed
+ flutter run

#### Technical
[x]  Primary platforms - iOS & Android; &nbsp;_(Different api keys for ios and android, as per documentation... implemented CupertinoApp for iOS and MaterialApp widgets for Android but I am not able to test the app on iOS, as I have a Windows computer.)_
[x]  Auto search - requests to retrieve Gif information from the service are made automatically with a small delay after user stops typing; &nbsp;_(Auto-search method, handling changes to a text field. Uses onChanged() callback in TextField widget.)_
[x]  Pagination - loading more results when scrolling; &nbsp;_(https://pub.dev/packages/infinite_scroll_pagination)_
[x]  Vertical & horizontal orientation support; &nbsp;_(OrientationBuilder)_
[x]  Error handling;
[x]  Unit tests - as much as you see fit;

#### UI
[x]  Responsive & matching platform guidelines;
[x]  At least 2 views sourced by data from Giphy; &nbsp;_(TabBar views for "trending" page and "search" page, and separate view for "single gif" view)_
[x]  Results are displayed in a grid; &nbsp;_(PagedGridView widget, by the infinite_scroll_pagination package)_, https://pub.dev/packages/infinite_scroll_pagination
[x]  Clicking on a grid item should navigate to a detailed Gif view. 
(GifDetailView widget)
[x]  Loading indicators; &nbsp;_(CircularProgressIndicator, in the center of app screen, FadeInImage widget... and background color set before gif loads.)_
[x]  Error display; &nbsp;_(SnackBar messages widget)_

#### Bonus points:
[ ]  Using state management approaches or libraries such as BLoC (flutter_bloc), Riverpod or others;
[ ]  Using an understandable architecture pattern;
[ ]  Page navigation is separate from page widget code (a Coordinator pattern or similar);
[ ]  Network availability handling;