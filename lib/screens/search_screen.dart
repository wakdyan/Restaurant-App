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
  final _controller = TextEditingController();
  final _results = <Restaurant>[];

  List<Restaurant> _restaurants;
  bool _isLoading = false;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _restaurants = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            Row(
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
            Divider(),
            _isLoading ? ShimmerTile(true) : _buildSearchResults(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_controller.text.isEmpty) {
      return SizedBox();
    } else {
      if (_controller.text.length > 0 && _controller.text.length < 3) {
        return Center(child: Text('Masukkan minimal 3 karakter'));
      } else {
        if (_results.isEmpty) {
          return Center(child: Text('Restoran tidak ditemukan'));
        } else {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: _results.length,
            itemBuilder: (_, index) {
              final restaurant = _results[index];
              return ListTile(
                onTap: () => _moveToDetailScreen(restaurant),
                leading: CircleAvatar(
                  backgroundImage:
                      CachedNetworkImageProvider(restaurant.pictureUrl),
                ),
                title: Text(restaurant.name),
                subtitle: Text(restaurant.city),
              );
            },
          );
        }
      }
    }
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
