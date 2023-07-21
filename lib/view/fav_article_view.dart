import 'package:fb_ui_prj/provider/fav_provider.dart';
import 'package:fb_ui_prj/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'web_view.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: const Color.fromARGB(223, 38, 63, 67),
        appBar: AppBar(
            // backgroundColor: const Color.fromARGB(223, 38, 63, 67),
            title: const Text(
              'Saved Articles',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 19,
                fontWeight: FontWeight.w900,
              ),
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.blue,
              ),
              onPressed: () {
                // Navigator.of(context).pop();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return const HomeScreen();
                }));
              },
            )),
        body: _showListView(context));
  }

  ListView _showListView(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final provider = Provider.of<FavoriteProvider>(context);
    final articles = provider.favorites;
    return ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          final image = article.urlToImage;

          final newsUrl = article.url;
          final description = article.description;

          return GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return WebView(newsUrl: newsUrl.toString());
                }));
              },
              child: Card(
                  // color: const Color.fromARGB(223, 38, 63, 67),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    SizedBox(
                      height: size.height / 7, // COPY HERE
                      width: size.height / 9, // COPY HERE
                      child: Image.network(image.toString()),
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              width: 1.9 * size.width / 3, // COPY HERE
                              height: size.height / 9, // COPY HERE
                              padding: const EdgeInsets.only(
                                  left: 16.0, right: 16.0, top: 20.0),
                              child: (Text(description.toString(),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                  )))),
                        ]),
                    IconButton(
                      icon: const Icon(Icons.remove_circle),
                      onPressed: () {
                        provider.toggleFavorite(article);
                      },
                    ),
                  ])));
        });
  }
}
