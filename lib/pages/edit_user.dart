import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:social_app/colors/app_color.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/provider/user_provider.dart';
import 'package:social_app/services/cloud.dart';
import 'package:social_app/utils/picker.dart';

class EditUserPage extends StatefulWidget {
  const EditUserPage({super.key});

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  @override
  Widget build(BuildContext context) {
    UserModel userData = Provider.of<UserProvider>(context).userModel!;
    TextEditingController bioCon = TextEditingController();
    TextEditingController displayCon = TextEditingController();
    TextEditingController usernameCon = TextEditingController();
    Uint8List? file;
    displayCon.text = userData.displayName;
    usernameCon.text = userData.username;
    bioCon.text = userData.bio;

    update() async {
      try {
        String res = await CloudMethiods().editProfile(
          uid: userData.uid,
          displayName: displayCon.text,
          username: usernameCon.text,
          bio: bioCon.text,
          file: file,
        );
        if (res == "success") {
          Navigator.pop(context);
        }
      } on Exception catch (e) {}
      Provider.of<UserProvider>(context, listen: false).getDetails();
    }

    return Scaffold(
      appBar: AppBar(title: Text("Profile Details")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    file == null
                        ? CircleAvatar(
                          radius: 60,
                          backgroundImage: AssetImage("assets/images/man.png"),
                        )
                        : CircleAvatar(
                          radius: 60,
                          backgroundImage: MemoryImage(file!),
                        ),
                    Positioned(
                      bottom: -10,
                      right: -10,
                      child: IconButton(
                        onPressed: () async {
                          Uint8List _file = await pickImage();
                          setState(() {
                            file = _file;
                          });
                        },
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: Icon(Icons.edit, color: kWhiteColor),
                      ),
                    ),
                  ],
                ),
              ),
              Gap(20),
              TextField(
                controller: displayCon,
                decoration: InputDecoration(
                  filled: true,
                  label: Text("Display Name"),
                  labelStyle: TextStyle(color: kSeconderyColor),
                  fillColor: kWhiteColor,
                  prefixIcon: Icon(Icons.person),
                  hintStyle: TextStyle(color: kSeconderyColor),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kSeconderyColor),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              Gap(20),
              TextField(
                controller: usernameCon,
                decoration: InputDecoration(
                  filled: true,
                  label: Text("Username"),
                  labelStyle: TextStyle(color: kSeconderyColor),
                  fillColor: kWhiteColor,
                  prefixIcon: Icon(Icons.person),
                  hintStyle: TextStyle(color: kSeconderyColor),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kSeconderyColor),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              Gap(20),
              TextField(
                controller: bioCon,
                decoration: InputDecoration(
                  filled: true,
                  label: Text("Bio"),
                  labelStyle: TextStyle(color: kSeconderyColor),
                  fillColor: kWhiteColor,
                  prefixIcon: Icon(Icons.person),
                  hintStyle: TextStyle(color: kSeconderyColor),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kSeconderyColor),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              Gap(20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        update();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.all(16),
                        backgroundColor: Colors.black,
                      ),
                      child: Text(
                        "Update".toUpperCase(),
                        style: TextStyle(color: kWhiteColor),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
