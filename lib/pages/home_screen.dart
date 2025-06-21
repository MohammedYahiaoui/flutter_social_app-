import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:social_app/colors/app_color.dart';
import 'package:social_app/pages/authen/login_page.dart';
import 'package:social_app/pages/authen/register_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(0.5),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: kWhiteColor.withOpacity(0.8),
            ),
            child: Expanded(
              child: Column(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      "assets/images/home_page.png",
                    ),
                  ),
                  Gap(
                    30
                  ),
                  Text(
                    "Where Sharing Meets Connection",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  Gap(
                    12
                  ),
                  Center(
                    child: Text(
                      "Easily chat, share and stay in touch with \n your community—no hassle, just vibes.",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Gap(
                    22
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));                      
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
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage(),));
                          }, 
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kWhiteColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}
