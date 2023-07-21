import 'package:fb_ui_prj/view/home_view.dart';
import 'package:fb_ui_prj/view/login_view.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});
  
  @override
  State<StatefulWidget> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: AuthService().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomeScreen();
          } else {
            return const LoginScreen();
          }        
        });
  }
}
