import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gap/gap.dart';
import 'package:image_stack/image_stack.dart';
import 'package:provider/provider.dart';
import 'package:social_app/colors/app_color.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/pages/edit_user.dart';
import 'package:social_app/provider/user_provider.dart';
import 'package:social_app/services/cloud.dart';
import 'package:social_app/widget/post_card.dart';

class ProfilePage extends StatefulWidget {
  String? uid;
  ProfilePage({super.key, this.uid});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  late TabController _tabController = TabController(length: 2, vsync: this);
  String myId = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    widget.uid = widget.uid ?? FirebaseAuth.instance.currentUser!.uid;
    Provider.of<UserProvider>(context, listen: false).getDetails();
    getUserData();
    super.initState();
  }

  var userInfo = {};
  bool isloading = true;
  bool isFollowing = false;
  int followers = 0;
  int following = 0;

  getUserData() async {
    try {
      var userData =
          await FirebaseFirestore.instance
              .collection("users")
              .doc(widget.uid ?? myId)
              .get();
      userInfo = userData.data()!;
      isFollowing = (userData.data()! as dynamic)["followers"].contains(myId);
      followers = userData.data()!["followers"].length;
      following = userData.data()!["following"].length;
      setState(() {
        isloading = false;
      });
    } on Exception catch (e) {
      // TODO
    }
  }

  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserProvider>(context).userModel!;
    return isloading
        ? Scaffold(
          body: Column(children: [Center(child: CircularProgressIndicator())]),
        )
        : Scaffold(
          appBar:
              userInfo["uid"] == myId
                  ? AppBar(
                    actions: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditUserPage(),
                            ),
                          );
                        },
                        icon: Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                        },
                        icon: Icon(Icons.logout),
                      ),
                    ],
                  )
                  : AppBar(),
          body: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  children: [
                    userModel.profilePic == ""
                        ? CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage("assets/images/man.png"),
                        )
                        : CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(userModel.profilePic),
                        ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: kWhiteColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          ImageStack(
                            imageRadius: 25,
                            imageBorderWidth: 2,
                            imageBorderColor: kWhiteColor,
                            imageSource: ImageSource.Asset,
                            imageList: [
                              "assets/images/man.png",
                              "assets/images/woman.png",
                            ],
                            totalCount: 0,
                          ),
                          Gap(5),
                          Row(
                            children: [
                              Text(following.toString()), 
                              Gap(5), 
                              Text("Following"),
                              ],
                              ),
                        ],
                      ),
                    ),
                    Gap(15),
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: kWhiteColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          ImageStack(
                            imageRadius: 25,
                            imageBorderWidth: 2,
                            imageBorderColor: kWhiteColor,
                            imageSource: ImageSource.Asset,
                            imageList: [
                              "assets/images/man.png",
                              "assets/images/woman.png",
                            ],
                            totalCount: 0,
                          ),
                          Gap(5),
                          Row(
                            children: [
                              Text(followers.toString()), 
                              Gap(5), 
                              Text("Followers"),
                              ],
                              ),
                        ],
                      ),
                    ),
                  ],
                ),
                Gap(15),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        contentPadding: EdgeInsets.all(0),
                        title: Text(
                          userInfo["displayName"],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text("@user"),
                      ),
                    ),
                    userInfo["uid"] == myId
                        ? Container()
                        : Row(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kSeconderyColor,
                                foregroundColor: kWhiteColor,
                              ),
                              onPressed: () {},
                              child: Row(
                                children: [
                                  Text(isFollowing ? 
                                  "UnFollow" : "Follow"),
                                  IconButton(
                                    onPressed: () {
                                      try {
                                        CloudMethiods().followUser(
                                          myId,
                                          userInfo["uid"],
                                        );
                                         setState(() {
                                          isFollowing ? 
                                          followers-- : following++;
                                        isFollowing = !isFollowing;
                                      });
                                      } on Exception catch (e) {
                                        // TODO
                                      }
                                    },
                                    icon: Icon(
                                      isFollowing ? 
                                      Icons.remove : Icons.add, 
                                      color: kWhiteColor,
                                      ),
                                  ),
                                ],
                              ),
                            ),
                            Gap(5),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                backgroundColor: kSeconderyColor,
                              ),
                              onPressed: () {},
                              child: Icon(Icons.message, color: kWhiteColor),
                            ),
                          ],
                        ),
                  ],
                ),
                Gap(5),
                userInfo["bio"] == ""
                    ? Container(decoration: BoxDecoration(color: kWhiteColor))
                    : Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: kSeconderyColor.withOpacity(0.2),
                            ),
                            child: Center(child: Text(userInfo["bio"])),
                          ),
                        ),
                      ],
                    ),
                Gap(10),
                TabBar(
                  controller: _tabController,
                  tabs: [Tab(text: "Photos"), Tab(text: "Posts")],
                ),
                Gap(10),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      FutureBuilder(
                        future:
                            FirebaseFirestore.instance
                                .collection("posts")
                                .where("uid", isEqualTo: userInfo["uid"])
                                .get(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasError) {
                            return Center(child: Text("Error"));
                          } else if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return RefreshIndicator(
                              onRefresh: () async{
                                getUserData();
                              },
                              child: GridView.builder(
                                itemCount: snapshot.data.docs.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisSpacing: 5,
                                      crossAxisSpacing: 5,
                                      crossAxisCount: 3,
                                    ),
                                itemBuilder: (context, index) {
                                  dynamic item = snapshot.data.docs[index];
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: kWhiteColor,
                                      image: DecorationImage(
                                        image: NetworkImage(item["postImage"]),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                      FutureBuilder(
                        future:
                            FirebaseFirestore.instance
                                .collection("posts")
                                .where("uid", isEqualTo: userInfo["uid"])
                                .get(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasError) {
                            return Center(child: Text("Error"));
                          } else if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return ListView.builder(
                              itemCount:
                                  snapshot.data.docs.length == 0
                                      ? 1
                                      : snapshot.data.docs.length,
                              itemBuilder: (context, index) {
                                dynamic item =
                                    snapshot.data.docs.length == 0
                                        ? ""
                                        : snapshot.data.docs[index];
                                return snapshot.data.docs.length == 0
                                    ? Center(child: Text("No post"))
                                    : PostCard(item: item);
                              },
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
  }
}
