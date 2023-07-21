import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/profile_model.dart';
import '../provider/profile_provider.dart';

class EditProfileView extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  EditProfileView({super.key});

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
                    _labelText("Name"),
                    _nameContainer(),
                    _sizedBox(20),
                    _labelText("Phone"),
                    _phNumberContainer(),
                  ],
                ),
                _sizedBox(20),
                _saveBtn(context),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget _saveBtn(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: const Color.fromARGB(223, 38, 63, 67),
        ),
        onPressed: () {
          ProfileModel newProfile = ProfileModel(
            name: _nameController.text,
            phone: _phoneController.text,
          );

          ProfileProvider profileProvider =
              Provider.of<ProfileProvider>(context, listen: false);
          profileProvider.saveProfileData(newProfile);
          profileProvider.loadProfileData();

          Navigator.pop(context);
        },
        child: const Text(
          "Save",
          style: TextStyle(
              fontSize: 13, letterSpacing: 1.5, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _nameContainer() {
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
      height: 60,
      child: TextField(
        controller: _nameController,
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
          hintText: 'Name',
          hintStyle: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10),
        ),
      ),
    );
  }

  Widget _titleText() {
    return const Text(
      "Edit View",
      style: TextStyle(
        color: Colors.red,
        fontSize: 20,
        fontWeight: FontWeight.w900,
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

  Widget _phNumberContainer() {
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
      height: 60,
      child: TextField(
        controller: _phoneController,
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
          hintText: 'Phone',
          hintStyle: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10),
        ),
      ),
    );
  }

  Widget _sizedBox(double height) {
    return SizedBox(height: height);
  }
}
