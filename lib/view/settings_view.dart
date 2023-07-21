import 'package:fb_ui_prj/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/font_provider.dart';
import '../services/auth_service.dart';
import 'home_view.dart';
import 'login_view.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final TextEditingController _date = TextEditingController();
  Color textColor = Colors.white;

  @override
  void dispose() {
    _date
        .dispose(); // Dispose of the TextEditingController when the widget is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Future<void> signOut() async {
      await AuthService().signOut();
    }

    final provider = Provider.of<ThemeProvider>(context);
    return Scaffold(
        // backgroundColor: const Color.fromARGB(223, 38, 63, 67),
        appBar: AppBar(
          toolbarHeight: 60,
          // backgroundColor: const Color.fromARGB(223, 38, 63, 67),
          // backgroundColor:  Colors.white,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.blue,
            ),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return const HomeScreen();
              }));
            },
            iconSize: 30,
          ),
          iconTheme: const IconThemeData(color: Colors.blue),
          elevation: 10,
          title: const Text(
            'Setting',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 19,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        body: Stack(children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                // Color.fromARGB(223, 38, 63, 67),
                // Colors.white
              ],
              stops: [0.4], // setting color points
            )),
          ),
          SizedBox(
              height: double.infinity,
              child: ListView(
                  // physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 20,
                  ),
                  children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SwitchListTile(
                                title: Consumer<FontProvider>(
                                  builder: (context, fontProvider, child) {
                                    return Text(
                                      'Theme',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: fontProvider.fontSize),
                                    );
                                  },
                                ),
                                secondary: Icon(
                                  provider.getDarkTheme
                                      ? Icons.dark_mode_outlined
                                      : Icons.light_mode_outlined,
                                  color: Colors.blue,
                                ),
                                onChanged: (bool value) {
                                  setState(() {
                                    provider.setDarkTheme = value;
                                  });
                                },
                                value: provider.getDarkTheme,
                              ),
                               SizedBox(
                                height: size.width/22,
                              ),
                              const Divider(
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: size.width/22,
                              ),
                              Consumer<FontProvider>(
                                builder: (context, fontProvider, child) {
                                  return Container(
                                      padding:
                                          const EdgeInsets.only(right: 180),
                                      child: Text(
                                        'Font Size',
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: fontProvider.fontSize),
                                      ));
                                },
                              ),
                              Consumer<FontProvider>(
                                builder: (context, fontProvider, child) {
                                  return Slider(
                                    value: fontProvider.fontSize,
                                    min: 2.0,
                                    max: 14.0,
                                    divisions: 3,
                                    label: fontProvider.fontSize.toString(),
                                    onChanged: (newValue) {
                                      final fontProvider =
                                          Provider.of<FontProvider>(context,
                                              listen: false);
                                      fontProvider.setFontSize(newValue);
                                    },
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              const Divider(
                                color: Colors.white,
                              ),
                              ListTile(
                                leading: const Icon(Icons.logout,
                                    color: Colors.blue),
                                title: Consumer<FontProvider>(
                                  builder: (context, fontProvider, child) {
                                    return Text(
                                      'LogOut',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: fontProvider.fontSize),
                                    );
                                  },
                                ),
                                onTap: () {
                                  signOut();
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) {
                                    return const LoginScreen();
                                  }));
                                },
                              )
                            ],
                          ),
                        ])
                  ]))
        ]));
  }
}
