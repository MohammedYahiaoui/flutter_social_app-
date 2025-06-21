import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:social_app/colors/app_color.dart';
import 'package:social_app/layout.dart';
import 'package:social_app/pages/authen/register_page.dart';
import 'package:social_app/pages/authen/singout.dart';
import 'package:social_app/services/auth.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailCon = TextEditingController();
  TextEditingController passwordCon = TextEditingController();

  singIn() async {
    try {
      String res = await AuthMethods().signIn(
        email: emailCon.text,
        password: passwordCon.text,
      );
      if (res == "Success") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LayoutPage()),
        );
      } else {
        print("Some errors");
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 390,
                  width: 420,
                  child: Image.asset(
                    "assets/images/login.png"
                  ),
                ),
              ),
              Text(
                "Post. Like. Connect!",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              Gap(6),
              Text(
                "Access your feed and start liking!",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              Gap(30),
              TextField(
                keyboardType: TextInputType.emailAddress,
                controller: emailCon,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  fillColor: kWhiteColor,
                  filled: true,
                  hintText: "Email",
                  prefixIcon: Icon(Icons.email, color: Colors.black),
                ),
              ),
              Gap(20),
              TextField(
                obscureText: true,
                controller: passwordCon,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kPrimaryColor),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  fillColor: kWhiteColor,
                  filled: true,
                  hintText: "Password",
                  prefixIcon: Icon(Icons.password),
                ),
              ),
              Gap(22),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          singIn();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(12),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: kWhiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("dont' have an account ?"),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                        (route) => false,
                      );
                    },
                    child: Text(
                      " register now",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
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
