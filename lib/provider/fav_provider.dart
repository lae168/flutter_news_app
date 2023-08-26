import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/article.dart';

class FavoriteProvider with ChangeNotifier {
  final String _favoriteKey = "favorite";

  List<Article> _favorites = [];

  List<Article> get favorites => _favorites;

  FavoriteProvider() {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteStrings = prefs.getStringList(_favoriteKey) ?? [];
    _favorites = favoriteStrings.map((favString) {
      final favMap = json.decode(favString);
      return Article(
        author: favMap['author'],
        content: favMap['content'],
        description: favMap['description'],
        title: favMap['title'],
        url: favMap['url'],
        urlToImage: favMap['urlToImage'],
      );
    }).toList();
    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteStrings = _favorites
        .map((article) => json.encode({
              'urlToImage': article.urlToImage,
              'description': article.description
            }))
        .toList();
    await prefs.setStringList(_favoriteKey, favoriteStrings);
  }

  bool isFavorite(Article article) {
    return _favorites.any((fav) =>
        fav.urlToImage == article.urlToImage &&
        fav.description == article.description);
  }

  void toggleFavorite(Article article) {
    if (isFavorite(article)) {
      _favorites.remove(article);
      // _favorites.removeWhere((fav) =>
      //     fav.urlToImage == article.urlToImage && fav.description == article.description);
    } else {
      _favorites.add(article);
    }
    _saveFavorites();
    notifyListeners();
  }
}
