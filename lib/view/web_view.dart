import 'package:fb_ui_prj/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class WebView extends StatefulWidget {
  late String newsUrl;
  WebView({super.key, required this.newsUrl});

  @override
  State<StatefulWidget> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  late final WebViewController controller;
  var loadingPercentage = 0;
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: ((url) {
          setState(() {
            loadingPercentage = 0;
          });
        }),
        onProgress: ((progress) {
          setState(() {
            loadingPercentage = progress;
          });
        }),
        onPageFinished: (url) {
          setState(() {
            loadingPercentage = 100;
          });
        },
      ))
      ..loadRequest(
        Uri.parse(widget.newsUrl),
      );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: false,
      child: Scaffold(
        appBar: _showAppBar(),
        body: Stack(children: [
          WebViewWidget(
            controller: controller,
          ),
          if (loadingPercentage < 100.0)
            LinearProgressIndicator(
              value: loadingPercentage / 100.0,
            )
        ]),
      ),
    );
  }

  bool isFavorite = false;

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  AppBar _showAppBar() {
    
    return AppBar(
     
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return const HomeScreen();
          }));
        },
        iconSize: 30,
      ),
      
      iconTheme: const IconThemeData(color: Colors.blue),
      elevation: 0,
      title: const Text(
        'Detailed Article',
        style: TextStyle(
          color: Colors.blue,
          fontSize: 19,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
