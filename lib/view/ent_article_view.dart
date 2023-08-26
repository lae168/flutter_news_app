import 'dart:developer';

import 'package:fb_ui_prj/model/article.dart';
import 'package:fb_ui_prj/services/ent_article_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../provider/fav_provider.dart';

import 'web_view.dart';

List<Article>? articles = [];


class RefreshProviderForEntArticles extends ChangeNotifier {
  late BuildContext context;
  List<Article> articleList = [];
  int max_count = 3;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  AticleViewModel() {
    _initArticleViewModel();
  }

  void _initArticleViewModel() {
    for (int i = 0; i < max_count; i++) {
      articleList.add(articles![i]);
    }
  }

  Future<void> onRefreshEvent(BuildContext context) async {
    _onRefreshList();
    refreshController.refreshCompleted();
  }

  Future<void> onLoadMoreEvent() async {
    if (max_count == articles!.length) {
      refreshController.loadNoData();
    } else {
      Future.delayed(const Duration(milliseconds: 1000), () {
        _getMoreList(max_count + 5);
      });
      refreshController.loadComplete();
    }
  }

  void _onRefreshList() {
    articleList.clear();
    _initArticleViewModel();
    notifyListeners(); // to notify UI widgets
  }

  void _getMoreList(int nextCount) {
    for (int i = max_count; i < nextCount; i++) {
      articleList.add(articles![i]);
    }
    max_count = nextCount;
    notifyListeners(); // to notify articleList
  }
}

class EntArticleView extends StatefulWidget {
  const EntArticleView({super.key});

  @override
  State<EntArticleView> createState() => _EntArticleViewState();
}

class _EntArticleViewState extends State<EntArticleView> {
  @override
  void initState() {
    super.initState();
    fetchArticle();
  }

    Future<void> fetchArticle() async {
    final response = await EntArticleApi.fetchArticle();
    setState(() {
      articles = response;
    });
  }
  

  @override
  Widget build(BuildContext context) {
    RefreshProviderForEntArticles refreshProvider = 
    context.watch<RefreshProviderForEntArticles>();

    // >>>>
   final RefreshController _refreshController = RefreshController(initialRefresh: false);
    return Expanded(
       
        child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            physics: const AlwaysScrollableScrollPhysics(),
            header: const WaterDropMaterialHeader(),
            controller: _refreshController,
            footer:
                CustomFooter(builder: (BuildContext context, LoadStatus? mode) {
              Widget body = Container();

              if (mode == LoadStatus.loading) {
                body = const CupertinoActivityIndicator();
              } else if (mode == LoadStatus.noMore) {
                body = const Text(
                  "No More Data",
                  style: TextStyle(color: Colors.white),
                );
              }

              return SizedBox(
                height: 100,
                child: Center(
                  child: body,
                ),
              );
            }),
            onLoading: () {
              refreshProvider.onLoadMoreEvent();
            },
            onRefresh: (() {
              refreshProvider.onRefreshEvent(context);
            }),
            child:_showListView(context, refreshProvider.articleList, refreshProvider)));
  }

    Widget _showListView(
      BuildContext context,
    List<Article>? articleList, 
    RefreshProviderForEntArticles refreshProvider) {
    Size size = MediaQuery.of(context).size;
    print(refreshProvider.articleList.length);
    final provider = Provider.of<FavoriteProvider>(context);
    return refreshProvider.articleList.isEmpty ? Container() : 
    ListView.builder(
      
        itemCount: refreshProvider.articleList.length,
        itemBuilder: (context, index) {
          final article = refreshProvider.articleList[index];
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





