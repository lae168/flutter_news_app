import 'package:fb_ui_prj/storage/shared_preference_manager.dart';
import 'package:fb_ui_prj/view/home_view.dart';

import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'signup_view.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? errMsg = '';
  // bool _rememberMe = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await AuthService().signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return const HomeScreen();
      }));
    } catch (e) {
      setState(() {
        errMsg = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // the whole background screen as stack
      body: Stack(children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              // Color.fromARGB(255, 55, 159, 244)
              // Color.fromARGB(223, 38, 63, 67),
            ],
            stops: [0.1], // setting color points
          )),
        ),
        SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 60,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _sizedBox(20),
                _titleText(),
                _sizedBox(20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _labelText("Email"),
                    _emailContainer(),
                    _sizedBox(20),
                    _labelText("Password"),
                    _passwordContainer(),
                    _sizedBox(20),
                    _errMsg()
                  ],
                ),

                // _forgetPasswordBtn(),

                _loginBtn(),
                _plainText(),
                _rowOfSocialBtns(),
                _signUpBtn(),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget _errMsg() {
    return Text(
      errMsg == '' ? '' : "$errMsg",
      style: const TextStyle(color: Colors.red),
    );
  }

  Widget _titleText() {
    return const Text(
      "Log In",
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w900,
      ),
    );
  }

  Widget _signUpBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text(
          "Don't have an account?",
          style: TextStyle(fontSize: 12, color: Colors.white),
        ),
        SizedBox(
            width: 90,
            height: 40,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(223, 38, 63, 67),
              ),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return const SignUpScreen();
                }));
              },
              child: const Text(
                'Sign Up',
                style: TextStyle(fontSize: 10, color: Colors.white),
              ),
            )),
      ],
    );
  }

  Widget _rowOfSocialBtns() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildSocialFunctionBtn(
            () => print("Login with facebook"),
            const AssetImage("assets/fb_img.png"),
          ),
          _buildSocialFunctionBtn(
            () => print("Login with facebook"),
            const AssetImage("assets/google_img.png"),
          ),
        ],
      ),
    );
  }

  Widget _plainText() {
    return Column(
      children: [
        const Text("-OR-",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        _sizedBox(20),
        const Text(
          "Sign in with",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }

  Widget _loginBtn() {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: const Color.fromARGB(223, 38, 63, 67),
        ),
        onPressed: () {
          signInWithEmailAndPassword();
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (BuildContext context) {
          //   return const HomeScreen();
          // }
          // ));
        },
        child: const Text(
          "LOGIN",
          style: TextStyle(
              fontSize: 13, letterSpacing: 1.5, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _forgetPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        child: const Text(
          "Forgot Password?",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _passwordContainer() {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          // color: Colors.blue,
          color: const Color.fromARGB(223, 38, 63, 67),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6.0,
              offset: Offset(0, 2),
            ),
          ]),
      height: size.width / 6.5,
      child: TextField(
        controller: _passwordController,
        obscureText: true,
        style: const TextStyle(
          color: Colors.white,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(top: 14, bottom: 14),
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.white,
          ),
          hintText: 'Enter your password',
          hintStyle: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10),
        ),
      ),
    );
  }

  Widget _emailContainer() {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          // color: Colors.blue,
          color: const Color.fromARGB(223, 38, 63, 67),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6.0,
              offset: Offset(0, 2),
            ),
          ]),
      height: size.width / 6.5,
      child: TextField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(
          color: Colors.white,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(top: 14, bottom: 14),
          prefixIcon: Icon(
            Icons.email,
            color: Colors.white,
          ),
          hintText: 'Enter your email',
          hintStyle: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10),
        ),
      ),
    );
  }

  Widget _labelText(String str) {
    return Text(
      str,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  Widget _sizedBox(double height) {
    return SizedBox(height: height);
  }

  void loginToHomeScreen() async {
    String? email =
        await SharedPreferencesManager().readEmailOrPhone(key: 'mailOrPhone');
    String? pwd =
        await SharedPreferencesManager().readPassword(key: 'password');

    if (email == _emailController.text && pwd == _passwordController.text) {
      // ignore: use_build_context_synchronously
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return HomeScreen();
      }));
    } else {
      _showSimpleDialog();
    }
  }

  Widget _buildSocialFunctionBtn(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(
                  8,
                  8,
                ),
                blurRadius: 16,
              )
            ],
            image: DecorationImage(image: logo)),
      ),
    );
  }

  Future<void> _showSimpleDialog() async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text(
            "Please check your email or password",
            style: TextStyle(fontSize: 15),
          ),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pop(); // exit
              },
              child: const Padding(
                padding: EdgeInsets.only(left: 240),
                child: Text("OK"),
              ),
            ),
          ],
        );
      },
    );
  }
}
