import 'package:fb_ui_prj/view/login_view.dart';

import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<StatefulWidget> createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  String? errMsg = '';
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  Future<void> registerWithEmailAndPassword() async {
    try {
      await AuthService().createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
        displayName: _nameController.text,
      );
    } catch (e) {
      setState(() {
        errMsg = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // thw whole background screen as stack
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
                    
                   
                    _errMsg()
                  ],
                ),
                _sizedBox(20),
                _signUpBtn(),
                _loginBtn(),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget _signUpBtn() {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.width/4,
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: const Color.fromARGB(223, 38, 63, 67),
        ),
        onPressed: () {
          // loginToHomeScreen();
          registerWithEmailAndPassword();
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return const LoginScreen();
          }));
        },
        child: const Text(
          "Sign up",
          style: TextStyle(
              fontSize: 13, letterSpacing: 1.5, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _errMsg() {
    return Text(errMsg == '' ? '' : "$errMsg",style: const TextStyle(color: Colors.red),);
  }

  Widget _titleText() {
    return const Text(
      "Sign Up",
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w900,
      ),
    );
  }

  Widget _loginBtn() {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text(
          "Already have an account?",
          style: TextStyle(fontSize: 12, color: Colors.white),
        ),
        SizedBox(
            width: size.width/5,
            height: size.width/12,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(223, 38, 63, 67),
              ),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return const LoginScreen();
                }));
              },
              child: const Text(
                'Login',
                style: TextStyle(fontSize: 10, color: Colors.white),
              ),
            )),
      ],
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
      height: size.width/6.5,
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
      height: size.width/6.5,
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
}
