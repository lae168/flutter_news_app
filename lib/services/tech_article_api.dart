import 'dart:convert';
import 'package:fb_ui_prj/const/article_const.dart';
import 'package:fb_ui_prj/model/article.dart';
import 'package:http/http.dart' as http;

class TechArticleApi{
    static Future<List<Article>> fetchArticle() async {
    String url = ArticleApiConstants.baseUrl+ArticleApiConstants.techEndPoint+ArticleApiConstants.apiKey;
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final results = json["articles"] as List<dynamic>;
    final articles = results.map((json) {
      return Article.fromMap(json);
    }).toList();
    return articles;
  }
  
}