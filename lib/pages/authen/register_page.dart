import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:social_app/colors/app_color.dart';
import 'package:social_app/pages/authen/login_page.dart';
import 'package:social_app/services/auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailCon = TextEditingController();
  TextEditingController passwordCon = TextEditingController();
  TextEditingController displaylCon = TextEditingController();
  TextEditingController usernameCon = TextEditingController();

  register() async {
    try {
      String res = await AuthMethods().singUp(
        email: emailCon.text,
        password: passwordCon.text,
        username: usernameCon.text,
        display: displaylCon.text,
      );
      if (res == "Success") {
      } else {
        print(res);
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 340,
                  width: 450,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Image.asset(
                            "assets/images/register.png",
                            // height: 220,
                            // width: 260,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Gap(20),
                TextField(
                  controller: displaylCon,
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
                    hintText: "Display Name",
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.black,
                      ),
                  ),
                ),
                Gap(20),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: usernameCon,
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
                    hintText: "Username",
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.black,
                      ),
                  ),
                ),
                Gap(20),
                TextField(
                  controller: emailCon,
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
                    hintText: "Email",
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.black,
                      ),
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
                    prefixIcon: Icon(
                      Icons.password,
                      color: Colors.black,
                      ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(12),
                            ),
                          ),
                          onPressed: () {
                            register();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Text(
                              "Register".toUpperCase(),
                              style: TextStyle(color: kWhiteColor),
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
                    Text("Already have an acount"),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                          (route) => false,
                        );
                      },
                      child: Text(
                        " login now",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                          ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
