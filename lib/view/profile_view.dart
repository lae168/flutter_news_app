import 'package:fb_ui_prj/services/auth_service.dart';
import 'package:fb_ui_prj/storage/shared_preference_manager.dart';
import 'package:fb_ui_prj/view/signup_view.dart';
import 'package:fb_ui_prj/view/user_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/profile_model.dart';
import '../provider/profile_provider.dart';

import 'edit_profile_view.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String imageUrl = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
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
            'Profile',
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
                //  Color.fromARGB(223, 38, 63, 67),
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
// ADDD CODE HERE  =>>>>
                              // UserImage(
                              //   onFileChanged: (imageUrl) {
                              //     setState(() {
                              //       this.imageUrl = imageUrl;
                              //     });
                              //   },
                              // ),

                              // NAME
                              Container(
                                height: size.width / 5,
                                decoration: const BoxDecoration(
                                    border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey,
                                  ),
                                )),
                                child: ListTile(
                                  contentPadding:
                                      const EdgeInsets.only(left: 40, top: 10),
                                  leading: const Icon(Icons.person),
                                  iconColor: Colors.blue,
                                  title: Consumer<ProfileProvider>(builder:
                                      (context, profileProvider, child) {
                                    ProfileModel profile =
                                        profileProvider.profile;

                                    return Text(profile.name,
                                        style: const TextStyle(
                                            color: Colors.blue));
                                  }),
                                  onTap: () {
                                    // Navigator.of(context).pop();
                                  },
                                ),
                              ),
                              // PHONE
                              Container(
                                height: size.width / 5,
                                decoration: const BoxDecoration(
                                    border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey,
                                    // width: 2,
                                  ),
                                )
                                    // borderRadius: BorderRadius.circular(10),
                                    ),
                                child: ListTile(
                                  contentPadding:
                                      const EdgeInsets.only(left: 40, top: 10),
                                  leading: const Icon(Icons.phone),
                                  iconColor: Colors.blue,
                                  title: Consumer<ProfileProvider>(builder:
                                      (context, profileProvider, child) {
                                    ProfileModel profile =
                                        profileProvider.profile;

                                    return Text(profile.phone,
                                        style: const TextStyle(
                                            color: Colors.blue));
                                  }),
                                  onTap: () {
                                    // Navigator.of(context).pop();
                                  },
                                ),
                              ),
                              // EMAIL
                              Container(
                                height: size.width / 5,
                                decoration: const BoxDecoration(
                                    border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey,
                                    // width: 2,
                                  ),
                                )
                                    // borderRadius: BorderRadius.circular(10),
                                    ),
                                child: ListTile(
                                  contentPadding:
                                      const EdgeInsets.only(left: 40, top: 10),
                                  leading: const Icon(Icons.mail),
                                  iconColor: Colors.blue,
                                  title: Text(
                                      AuthService()
                                          .currentUser!
                                          .email
                                          .toString(),
                                      style:
                                          const TextStyle(color: Colors.blue)),
                                  onTap: () {
                                    // Navigator.of(context).pop();
                                  },
                                ),
                              ),
                              SizedBox(
                                height: size.width / 8,
                              ),
                              //EDIT
                              Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30)),
                                  width: 300,
                                  height: 60,
                                  child: TextButton(
                                      onPressed: (() {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                EditProfileView(),
                                          ),
                                        );
                                      }),
                                      child: const Text(
                                        "Edit Profile",
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(223, 38, 63, 67),
                                        ),
                                      ))),
                            ],
                          ),
                        ])
                  ]))
        ]));
  }
}
