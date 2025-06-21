import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:social_app/colors/app_color.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/provider/user_provider.dart';
import 'package:social_app/services/cloud.dart';

class CommentScreen extends StatefulWidget {
  final postId;
  const CommentScreen({super.key, required this.postId});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  TextEditingController commentCon = TextEditingController();

  postComment({
    required String uid,
    required String profilePic,
    required String displayName,
    required String username,
  }) {
    String res = CloudMethiods()
    .commentToPost(
      postId: widget.postId, 
      uid: uid, 
      commentText: commentCon.text, 
      profilePic: profilePic, 
      displayName: displayName, 
      username: username);
      if (res == "success") {
        setState(() {
          commentCon.text = "";
        });
      } 
  }  
  @override
  Widget build(BuildContext context) {
    UserModel userData = Provider.of<UserProvider>(context).userModel!;
    return Scaffold(
      appBar: AppBar(title: Text("Comments")),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
              .collection("posts")
              .doc(widget.postId)
              .collection("comments")
              .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    dynamic data = snapshot.data.docs[index];
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: kWhiteColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundImage: AssetImage(
                                      "assets/images/man.png",
                                    ),
                                  ),
                                  Gap(10),
                                  Text(data["displayName"]),
                                ],
                              ),
                              Gap(10),
                              Row(
                                children: [
                                  Text(
                                    data["commentText"],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: kWhiteColor,
                      borderRadius: BorderRadius.circular(99),
                      border: Border.all(color: kSeconderyColor),
                    ),
                    child: TextField(
                      controller: commentCon,
                      cursorColor: kSeconderyColor,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(12),
                        hintText: "Type here ...",
                        filled: true,
                        fillColor: kWhiteColor,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Gap(
                  6
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(25),
                    shape: CircleBorder(),
                    backgroundColor: Colors.black,
                    foregroundColor: kWhiteColor,
                  ),
                  onPressed: () {
                    print(userData.displayName);
                    postComment(
                      uid: userData.uid, 
                      profilePic: userData.profilePic, 
                      displayName: userData.displayName, 
                      username: userData.username,
                      );
                      
                  },
                  child: Icon(
                    Icons.arrow_circle_right_outlined,
                    size: 25,
                    ),
                ),
              ],
            ),
          ),
          Gap(10),
        ],
      ),
    );
  }
}
