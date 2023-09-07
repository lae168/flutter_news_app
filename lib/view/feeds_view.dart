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

class _FeedScreenState extends State<FeedScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<List<String>> categorizedData = [
    ['View 1-1', 'View 1-2', 'View 1-3', 'View 1-4', 'View 1-5'],
    ['View 2-1', 'View 2-2', 'View 2-3', 'View 2-4', 'View 2-5'],
    ['View 3-1', 'View 3-2', 'View 3-3', 'View 3-4', 'View 3-5'],
    ['View 4-1', 'View 4-2', 'View 4-3', 'View 4-4', 'View 4-5'],
    ['View 5-1', 'View 5-2', 'View 5-3', 'View 5-4', 'View 5-5'],
  ];
  final _pageController = PageController(initialPage: 0);
  List<String> categories = [
    "Japan",
    "World",
    "Business",
    "Technology",
    "Entertainment"
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
    _tabController.addListener(() {
      setState(() {
        selectedIndex = _tabController.index;
      });
    });
  }

  // THIS IS APP BAR
  AppBar _showAppBar() {
    return AppBar(
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
    return GestureDetector(
        onTap: () {
          setState(() {
            selectedIndex = index;
            _pageController.animateToPage(index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.linear);
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            children: [
              Consumer<FontProvider>(builder: (context, fontProvider, child) {
                return TabBar(
                    padding: const EdgeInsets.all(0),
                    indicator: const BoxDecoration(
                      color: Colors.white,
                    ),
                    controller: _tabController,
                    isScrollable: true,
                    tabs: [
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          child:  Column(
                                children: [
                                  Consumer<FontProvider>(
                                      builder: (context, fontProvider, child) {
                                    return Text(
                                      categories[index],
                                      style: TextStyle(
                                          fontSize: fontProvider.fontSize,
                                          fontWeight: FontWeight.normal,
                                          color: selectedIndex == index
                                              ? Colors.blue
                                              : Colors.black),
                                    );
                                  }),
                                ],
                              ))
                    ]);
              }),
            ],
          ),
        ));
  }

//   HORIZONTAL SCROLL CATEGORY LIST
  Widget _categoryList() {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: size.width / 13,
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
    return Scaffold(
        appBar: _showAppBar(), //APPBAR
        body: Column(children: [
          _categoryList(), // CATEGORY SCROLL X-AXIS
          _newsPageViews() // News Page View
        ]));
  }

  Widget _newsPageViews() {
    return Expanded(
      child: PageView.builder(
          controller: _pageController,
          itemCount: _menuOption.length,
          onPageChanged: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          itemBuilder: (context, index) => _menuOption[selectedIndex]),
    );
  }
}
