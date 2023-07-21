import 'dart:math';
import 'package:fb_ui_prj/model/article.dart';
import 'package:fb_ui_prj/services/japan_article_api.dart';
import 'package:fb_ui_prj/view/fav_article_view.dart';
import 'package:fb_ui_prj/view/web_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/fav_provider.dart';

List<Article>? articles = [];

class JapanArticleView extends StatefulWidget {
  const JapanArticleView({super.key});

  @override
  State<JapanArticleView> createState() => _JapanArticleViewState();
}

class _JapanArticleViewState extends State<JapanArticleView> {
  @override
  void initState() {
    super.initState();
    fetchArticle();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: _showListView() // datas will be shown in list if datas axist

        );
  }

  Future<void> fetchArticle() async {
    final response = await JapanArticleApi.fetchArticle();
    setState(() {
      articles = response;
    });
  }

  ListView _showListView() {
    Size size = MediaQuery.of(context).size;
    final provider = Provider.of<FavoriteProvider>(context);
    return ListView.builder(
        itemCount: articles?.length,
        itemBuilder: (context, index) {
          final article = articles![index];
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
                          height: size.height/7, // COPY HERE
                          width: size.height/9, // COPY HERE
                          child: Image.network(image.toString()),
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(

                               
                                  width: 1.9*size.width/3, // COPY HERE
                                  height: size.height/9, // COPY HERE
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
                          icon: provider.isFavorite(article)
                              ? const Icon(
                                  Icons.favorite,
                                  color: Colors.redAccent,
                                )
                              : const Icon(Icons.favorite_border,
                                  color: Colors.blue),
                          onPressed: () {
                            provider.toggleFavorite(article);
                          },
                        ),
                      ])));
        });
  }
}
