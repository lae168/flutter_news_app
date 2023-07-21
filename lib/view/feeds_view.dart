import 'package:fb_ui_prj/view/business_article_view.dart';
import 'package:fb_ui_prj/view/ent_article_view.dart';
import 'package:fb_ui_prj/view/tech_article_view.dart';
import 'package:fb_ui_prj/view/world_article_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/font_provider.dart';
import 'japan_article_view.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<StatefulWidget> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  List<String> categories = [
    "Japan",
    "World",
    "Business",
    "Technology",
    "Entertainment"
  ];
  AppBar _showAppBar() {
    return AppBar(
      // backgroundColor: const Color.fromARGB(223, 38, 63, 67),
      leading: IconButton(
        icon: const Icon(
          Icons.menu,
        ),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        iconSize: 30,
      ),
      iconTheme: const IconThemeData(color: Colors.blue),
      elevation: 0,
      title: const Text(
        'Feeds',
        style: TextStyle(
          color: Colors.blue,
          fontSize: 19,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  int selectedIndex = 0;
  final List<Widget> _menuOption = [
    const JapanArticleView(),
    const WorldArticleView(),
    const BusinessArticleView(),
    const TechArticleView(),
    const EntArticleView()
  ];
  Widget _buildCategory(int index) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Consumer<FontProvider>(builder: (context, fontProvider, child) {
                return Text(
                  categories[index],
                  style: TextStyle(
                      fontSize: fontProvider.fontSize,
                      fontWeight: FontWeight.normal,
                      color:
                          selectedIndex == index ? Colors.blue : Colors.white),
                );
              }),
              Container(
                margin: const EdgeInsets.only(top: 20.0 / 4), //top padding 5
                height: size.height / 200,
                width: size.height / 5000,
                color:
                    selectedIndex == index ? Colors.blue : Colors.transparent,
              )
            ],
          ),
        ));
  }

  Widget _categoryList() {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: size.width / 11,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) => _buildCategory(index)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: _showAppBar(),
        // backgroundColor: const Color.fromARGB(223, 38, 63, 67),
        body: Column(children: [
          _categoryList(),
          SizedBox(
            height: size.height / 1.28,
            child: _menuOption[selectedIndex],
          )
        ]));
  }
}
