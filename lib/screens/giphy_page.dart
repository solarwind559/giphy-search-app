import 'package:flutter/material.dart';
import 'package:giphy_search/widgets/gif_grid.dart';
import 'package:giphy_search/giphy_api/giphy_api.dart';
import 'package:giphy_search/widgets/searchbar.dart';
import 'dart:async';

class GiphyPage extends StatefulWidget {
  const GiphyPage({super.key});

  @override
  State<GiphyPage> createState() => _GiphyPageState();
}

class _GiphyPageState extends State<GiphyPage>
    with SingleTickerProviderStateMixin {
  final GiphyApi _giphyApi = GiphyApi();
  List<dynamic> _trendingResults = [];
  List<dynamic> _searchResults = [];
  bool _isLoading = false;
  Timer? _debounce;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _fetchTrendingGifs();
  }

  void _searchGifs(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      setState(() {
        _isLoading = true;
      });

      final results = await _giphyApi.searchGifs(context, query);
      setState(() {
        _searchResults = results;
        _isLoading = false;
      });
    });
  }

  void _fetchTrendingGifs() async {
    setState(() {
    _isLoading = true; // include loading for the wait while fetching GIFs too...
    });
    final results = await _giphyApi.fetchTrendingGifs(context);
    setState(() {
      _trendingResults = results;
      _isLoading = false; // include loading for the wait while fetching GIFs too...
    });
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _searchGifs(query);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 25, 25, 25),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 15, 15, 15),
        toolbarHeight: 60.0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(64.0),
          child: Column(                
            children: [
              Container(
              color: const Color.fromARGB(255, 25, 25, 25),
                child: TabBar(
                  controller: _tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: [
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
            ],
          ),
        ),
        flexibleSpace: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: <Color>[
                  Colors.yellow,
                  Colors.green,
                  Colors.blue,
                  Colors.purple,
                ],
                tileMode: TileMode.mirror,
              ).createShader(bounds),
              child: Text(
                'Giphy Search App',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Column(
            children: [
              NewSearchBar(
                backgroundColor: const Color.fromARGB(255, 25, 25, 25),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          onChanged: _onSearchChanged,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white24),
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
              Expanded(
                child: _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : GifGrid(searchResults: _searchResults),
              ),
            ],
          ),
          GifGrid(searchResults: _trendingResults),
        ],
      ),
    );
  }
}
