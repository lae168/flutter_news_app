import 'package:fb_ui_prj/view/feeds_view.dart';
import 'package:fb_ui_prj/view/fav_article_view.dart';
import 'package:fb_ui_prj/view/login_view.dart';
import 'package:fb_ui_prj/view/profile_view.dart';
import 'package:fb_ui_prj/view/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/font_provider.dart';
import '../provider/propic_provider.dart';
import '../services/auth_service.dart';
import 'package:url_launcher/url_launcher.dart';

import '../storage/shared_preference_manager.dart';

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

  String imageUrl = "";

  @override
  void initState() {
    super.initState();
    // Retrieve saved profile picture URI when the widget initializes
    SharedPreferencesManager().getProfilePicture().then((uri) {
      setState(() {
        imageUrl = uri!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _menuOption[_selectedIndex],
        drawer: _setSideDrawer(),
        bottomNavigationBar: _setBottomNavBar());
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // THIS IS BOTTOM NAV BAR
  Widget _setBottomNavBar() {
    return BottomNavigationBar(
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
        ]);
  }

  // THIS IS SIDE DRAWER
  Widget _setSideDrawer() {
    Provider.of<ProfilePictureProvider>(context, listen: false)
        .loadProfilePicture();

    String? selectedPictureUri =
        Provider.of<ProfilePictureProvider>(context).selectedPictureUri;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // THIS IS PROFILE PICTURE
                selectedPictureUri != null
                    ? Container(
                        width: 80.0, 
                        height: 80.0, 
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                          width: 2.0, 
                          ),
                        ),

                        child: ClipOval(
                          child: Image.network(
                            selectedPictureUri,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : const Icon(
                        Icons.person,
                        size: 30,
                        color: Colors.blue,
                      ),

                // THIS IS USER'S EMAIL ACCOUNT WHEN USER LOGINS
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

          // TO GO TO NEWS VIEWS
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
            // GO STRAIGHT TO HomeScreen
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return const HomeScreen();
              }));
            },
          ),

          // FOR PROFILE VIEW
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

            // GO STRAIGHT TO ProfileScreen
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return const ProfileScreen();
              }));
            },
          ),

          // FOR FAVOURITE ARTICLE VIEW
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
            // GO STRAIGHT TO FavScreen
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

          // TO CONTACT TO DEVELOPER
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

            // GO STRAIGHT TO MAIL BOX
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

          // TO LOG OUT FROM ACCOUNT
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

              //  Go Straight to LogIn Screen
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return const LoginScreen();
              }));
            },
          )
        ],
      ),
    );
  }
}
