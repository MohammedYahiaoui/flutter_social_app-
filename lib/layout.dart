import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/colors/app_color.dart';
import 'package:social_app/pages/add.dart';
import 'package:social_app/pages/home.dart';
import 'package:social_app/pages/profile.dart';
import 'package:social_app/pages/search.dart';
import 'package:social_app/provider/user_provider.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key});

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  int currentIndex = 0;
  PageController pageCon = PageController();

  @override
  void initState() {
    Provider.of<UserProvider>(context, listen: false).getDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider.of<UserProvider>(context).isLoad
        ? Scaffold(body: Center(child: CircularProgressIndicator()))
        : Scaffold(
          body: PageView(
            controller: pageCon,
            children: [HomePage(), AddPage(), SearchPage(), ProfilePage()],
            onPageChanged:
                (value) => setState(() {
                  currentIndex = value;
                }),
          ),
          extendBody: true,
          bottomNavigationBar: NavigationBar(
            onDestinationSelected:
                (value) => setState(() {
                  currentIndex = value;
                  pageCon.jumpToPage(value);
                }),
            selectedIndex: currentIndex,
            backgroundColor: kWhiteColor.withOpacity(0.8),
            elevation: 0,
            indicatorColor: Colors.black,
            destinations: [
              NavigationDestination(
                icon: Icon(Icons.home),
                label: "Home",
                selectedIcon: Icon(Icons.home, color: kWhiteColor),
              ),
              NavigationDestination(
                icon: Icon(Icons.add),
                label: "Add",
                selectedIcon: Icon(Icons.add, color: kWhiteColor),
              ),
              NavigationDestination(
                icon: Icon(Icons.search),
                label: "Search",
                selectedIcon: Icon(Icons.search, color: kWhiteColor),
              ),
              NavigationDestination(
                icon: Icon(Icons.person),
                label: "Person",
                selectedIcon: Icon(Icons.person, color: kWhiteColor),
              ),
            ],
          ),
        );
  }
}
