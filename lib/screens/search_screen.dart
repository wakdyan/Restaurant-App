import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/restaurant.dart';
import '../widgets/shimmer_tile.dart';
import 'detail_screen.dart';

class SearchScreen extends StatefulWidget {
  static final route = '/search';

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _controller;
  List<Restaurant> _restaurants;
  bool _isLoading = false;

  final _results = <Restaurant>[];

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _restaurants = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          SafeArea(
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.arrow_back),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
                    child: TextField(
                      controller: _controller,
                      onChanged: (value) => _search(value),
                      decoration: InputDecoration(
                        hintText: 'Cari restoran kesukaan kamu',
                        prefixIcon: Icon(
                          Icons.search,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          _isLoading ? ShimmerTile(true) : _buildSearchResults(),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _results?.length,
      itemBuilder: (BuildContext context, int index) {
        final restaurant = _results[index];
        return ListTile(
          onTap: () => _moveToDetailScreen(restaurant),
          leading: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(restaurant.pictureUrl),
          ),
          title: Text(_results[index].name),
          subtitle: Text(_results[index].city),
        );
      },
    );
  }

  void _search(String keyword) {
    setState(() {
      _results.clear();
      _isLoading = true;
    });

    Future.delayed(Duration(milliseconds: 500), () {
      if (keyword.length >= 3) {
        var tempResults = _restaurants.where((element) {
          return element.name.toLowerCase().contains(keyword.toLowerCase());
        });

        setState(() {
          _results.addAll(tempResults.toSet());
          _isLoading = false;
        });
      } else
        setState(() {
          _isLoading = false;
          _results.clear();
        });
    });
  }

  void _moveToDetailScreen(Restaurant restaurant) {
    Navigator.pushNamed(context, DetailScreen.route, arguments: restaurant);
  }
}
