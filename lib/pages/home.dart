import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:social_app/colors/app_color.dart';
import 'package:social_app/widget/post_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CollectionReference posts = FirebaseFirestore.instance.collection("posts");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          "assets/images/register.png",
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.message))],
      ),
      backgroundColor: kWhiteColor.withOpacity(0.2),
      body: StreamBuilder(
        stream: posts.orderBy('date', descending: true).snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            debugPrint('Firestore stream error: ${snapshot.error}');
            return Center(child: Text('Erreur Firestore : ${snapshot.error}'));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            dynamic data = snapshot.data;
            return ListView.builder(
              itemCount: data.docs.length,
              itemBuilder: (context, index) {
                return PostCard(item: data.docs[index]);
              },
            );
          }
        },
      ),
    );
  }
}
