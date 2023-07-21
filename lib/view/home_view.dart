import 'package:fb_ui_prj/storage/shared_preference_manager.dart';
import 'package:fb_ui_prj/view/feeds_view.dart';
import 'package:fb_ui_prj/view/fav_article_view.dart';
import 'package:fb_ui_prj/view/login_view.dart';
import 'package:fb_ui_prj/view/profile_view.dart';
import 'package:fb_ui_prj/view/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/font_provider.dart';
import '../services/auth_service.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> signOut() async {
    await AuthService().signOut();
  }

  int _selectedIndex = 0;
  final List<Widget> _menuOption = [
    const FeedScreen(),
    const ProfileScreen(),
    const SettingScreen(),
  ];

  Future<String?> name =
      SharedPreferencesManager().readFirstName(key: 'firstName');
  Future<String?> email =
      SharedPreferencesManager().readEmailOrPhone(key: 'mailOrPhone');

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: _menuOption[_selectedIndex],
        drawer: Drawer(
          // backgroundColor: const Color.fromARGB(223, 38, 63, 67),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                    // color: Color.fromARGB(223, 38, 63, 67),
                    ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                        onTap: (() {}),
                        child: const Icon(
                          Icons.person,
                          size: 30.0,
                          color: Colors.blue,
                        )),
                     SizedBox(height: size.width/10),
                    Text(
                      AuthService().currentUser!.email.toString(),
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 12.0,
                      ),
                    )
                  ],
                ),
              ),
              const Divider(
                color: Colors.white,
              ),
              ListTile(
                leading: const Icon(Icons.book),
                iconColor: Colors.blue,
                title: Consumer<FontProvider>(
                  builder: (context, fontProvider, child) {
                    return Text(
                      'News',
                      style: TextStyle(
                          color: Colors.blue, fontSize: fontProvider.fontSize),
                    );
                  },
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return const HomeScreen();
                  }));
                },
              ),
              ListTile(
                leading: const Icon(Icons.person),
                iconColor: Colors.blue,
                title: Consumer<FontProvider>(
                  builder: (context, fontProvider, child) {
                    return Text(
                      'My Account',
                      style: TextStyle(
                          color: Colors.blue, fontSize: fontProvider.fontSize),
                    );
                  },
                ),
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return const ProfileScreen();
                  }));
                },
              ),
              ListTile(
                leading: const Icon(Icons.star_border),
                iconColor: Colors.blue,
                title: Consumer<FontProvider>(
                  builder: (context, fontProvider, child) {
                    return Text(
                      'Saved',
                      style: TextStyle(
                          color: Colors.blue, fontSize: fontProvider.fontSize),
                    );
                  },
                ),
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return const FavScreen();
                  }));
                },
              ),

              const Divider(
                color: Colors.white,
              ),
              ListTile(
                leading: const Icon(Icons.mail, color: Colors.blue),
                title: Consumer<FontProvider>(
                  builder: (context, fontProvider, child) {
                    return Text(
                      'Contact Us',
                      style: TextStyle(
                          color: Colors.blue, fontSize: fontProvider.fontSize),
                    );
                  },
                ),
                onTap: () async {
                  String? encodeQueryParameters(Map<String, String> params) {
                    return params.entries
                        .map((MapEntry<String, String> e) =>
                            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                        .join('&');
                  }

                  final Uri emailUri = Uri(
                    scheme: "mailto",
                    path: "laenandaraung168@gmail.com",
                    query: encodeQueryParameters(<String, String>{
                      'subject': 'Example Subject & Symbols are allowed!',
                    }),
                  );

                  try {
                    await launchUrl(emailUri);
                  } catch (e) {
                    print(e.toString());
                  }
                },
              ),
              //
              const Divider(
                color: Colors.white,
              ),
              ListTile(
                leading: const Icon(Icons.lock_open, color: Colors.blue),
                title: Consumer<FontProvider>(
                  builder: (context, fontProvider, child) {
                    return Text(
                      'LogOut',
                      style: TextStyle(
                          color: Colors.blue, fontSize: fontProvider.fontSize),
                    );
                  },
                ),
                onTap: () {
                  signOut();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return const LoginScreen();
                  }));
                },
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
            // backgroundColor: const Color.fromARGB(223, 38, 63, 67),
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            iconSize: 30,
            onTap: _onItemTapped,
            elevation: 5,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_max),
                label: 'Feeds',
                backgroundColor: Color.fromARGB(223, 38, 63, 67),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
                backgroundColor: Color.fromARGB(223, 38, 63, 67),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Setting',
                backgroundColor: Color.fromARGB(223, 38, 63, 67),
              ),
            ]));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
