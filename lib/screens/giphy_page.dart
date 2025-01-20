import 'package:flutter/material.dart';
import 'package:giphy_search/widgets/custom_appbar.dart';
import 'package:giphy_search/widgets/gif_grid_item.dart';
import 'package:giphy_search/giphy_api/giphy_api.dart';
import 'package:giphy_search/widgets/searchbar.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'dart:async';

class GiphyPage extends StatefulWidget {
  const GiphyPage({super.key});

  @override
  State<GiphyPage> createState() => _GiphyPageState();
}

class _GiphyPageState extends State<GiphyPage>
  with SingleTickerProviderStateMixin {
  final GiphyApi _giphyApi = GiphyApi(apiClient: http.Client());
  static const _pageSize = 20;
  final PagingController<int, dynamic> _pagingControllerTrending = PagingController(firstPageKey: 0);
  final PagingController<int, dynamic> _pagingControllerSearch = PagingController(firstPageKey: 0);
  late TabController _tabController;
  String _currentSearchQuery = "";
  // Add delay on auto-search
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _pagingControllerTrending.addPageRequestListener((pageKey) {
      _fetchTrendingGifs(pageKey);
    });
    _pagingControllerSearch.addPageRequestListener((pageKey) {
      _fetchSearchGifs(_currentSearchQuery, pageKey);
    });
  }

  Future<void> _fetchSearchGifs(String query, int pageKey) async {
    try {
      final newItems = await _giphyApi.fetchSearchGifs(context, query,
          offset: pageKey, limit: _pageSize);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingControllerSearch.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingControllerSearch.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingControllerSearch.error = error;
    }
  }

  Future<void> _fetchTrendingGifs(int pageKey) async {
    try {
      final newItems = await _giphyApi.fetchTrendingGifs(context,
          offset: pageKey, limit: _pageSize);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingControllerTrending.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingControllerTrending.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingControllerTrending.error = error;
    }
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(seconds: 1), () {
    _currentSearchQuery = query;
    _pagingControllerSearch.refresh();
    });
  }

  @override
  void dispose() {
    _pagingControllerTrending.dispose();
    _pagingControllerSearch.dispose();
    _tabController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 25, 25, 25),
      appBar: CustomAppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Column(
            children: [
              Container(
                color: const Color.fromARGB(255, 25, 25, 25),
                child: TabBar(
                  controller: _tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: const [
                    Tab(
                      child: Text(
                        'Search GIFs',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Trending GIFs',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Column(
                      children: [
                        NewSearchBar(
                          onChanged: (text) {
                            _onSearchChanged(text);
                          },
                          backgroundColor:
                            const Color.fromARGB(255, 25, 25, 25),
                          ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: PagedGridView<int, dynamic>(
                              pagingController: _pagingControllerSearch,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                    orientation == Orientation.portrait ? 2 : 4,
                                childAspectRatio: 1,
                              ),
                              builderDelegate:
                                  PagedChildBuilderDelegate<dynamic>(
                                itemBuilder: (context, item, index) => Padding(
                                  padding: const EdgeInsets.only(
                                      right: 5, left: 5, bottom: 10),
                                  child: GifGridItem(gifData: item),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(right: 5, left: 5, top: 10),
                        child: PagedGridView<int, dynamic>(
                          pagingController: _pagingControllerTrending,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                orientation == Orientation.portrait ? 2 : 4,
                            childAspectRatio: 1,
                          ),
                          builderDelegate: PagedChildBuilderDelegate<dynamic>(
                            itemBuilder: (context, item, index) => Padding(
                              padding: const EdgeInsets.all(5),
                              child: GifGridItem(gifData: item),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}