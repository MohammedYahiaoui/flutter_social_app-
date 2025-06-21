import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:social_app/colors/app_color.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/pages/comment_screen.dart';
import 'package:social_app/provider/user_provider.dart';
import 'package:social_app/services/cloud.dart';

class PostCard extends StatefulWidget {
  final item;
  const PostCard({super.key, required this.item});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  int commentCount = 0;

  getCommentCount() async {
    try {
      QuerySnapshot comment =
          await FirebaseFirestore.instance
              .collection("posts")
              .doc(widget.item["postId"])
              .collection("comments")
              .get();
      if (this.mounted) {
        setState(() {
          commentCount = comment.docs.length;
        });
      }
    } on Exception catch (e) {
      // TODO
    }
  }

  @override
  void initState() {
    getCommentCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserModel userData = Provider.of<UserProvider>(context).userModel!;
    return Padding(
      padding: EdgeInsets.all(12),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: kWhiteColor,
        ),
        child: Column(
          children: [
            Row(
              children: [
                widget.item["profilePic"] == ""
                    ? CircleAvatar(
                      backgroundImage: AssetImage("assets/images/man.png"),
                    )
                    : CircleAvatar(
                      backgroundImage: NetworkImage(widget.item["profilePic"]),
                    ),
                Gap(12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.item["displayName"]),
                    Text(widget.item["username"]),
                  ],
                ),
                Spacer(),
                Text(widget.item["date"].toDate().toString()),
              ],
            ),
            Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child:
                      widget.item["postImage"] == ""
                          ? Container()
                          : Container(
                            height: 300,
                            width: 300,
                            decoration: BoxDecoration(
                              color: kWhiteColor,
                              image: DecorationImage(
                                // image: AssetImage(
                                // "assets/images/woman.png"
                                image: NetworkImage(widget.item["postImage"]),
                              ),
                            ),
                          ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(child: Text(widget.item['description'], maxLines: 5)),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    CloudMethiods().likePost(
                      widget.item['postId'],
                      userData.uid,
                      widget.item['like'],
                    );
                  },
                  icon:
                      widget.item['like'].contains(userData.uid)
                          ? Icon(Icons.favorite, color: kPrimaryColor)
                          : Icon(Icons.favorite_border_outlined),
                ),
                Text(widget.item['like'].length.toString()),
                Gap(12),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                CommentScreen(postId: widget.item["postId"]),
                      ),
                    );
                  },
                  icon: Icon(Icons.comment),
                ),
                Text(commentCount.toString()),
                Spacer(),
                IconButton(onPressed: () {
                  CloudMethiods().deletePost(widget.item["postId"]);
                }, 
                icon: Icon(
                  Icons.delete,
                  ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
