import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_app/colors/app_color.dart';
import 'package:social_app/pages/profile.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Find Users"
        ),
      ),
      body: 
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SearchBar(
              onChanged: (value) {
                setState(() {
                  // searchCon.text = value;
                });
              },
              controller: searchCon,
              hintText: "Seach by username",
              trailing: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Icon(
                    Icons.search,
                    color: kPrimaryColor,
                  ),
                ),
              ],
              backgroundColor: WidgetStateColor.resolveWith((states) => Colors.white,),
              elevation: WidgetStateProperty.resolveWith((states) => 0,),
              shape: WidgetStateOutlinedBorder.resolveWith((states) => RoundedRectangleBorder(
                side: BorderSide(
                  color: kPrimaryColor,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: FirebaseFirestore.instance.collection("users").where(
                  "username", isEqualTo: searchCon.text).get(),
                builder: (context, AsyncSnapshot snapshot) {
                  return ListView.builder(
                  itemCount: searchCon.text == "" ? 0 : snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    dynamic item = snapshot.data.docs[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(uid: item["uid"],),));
                      },
                      child: ListTile(
                        leading: item["profilePic"] == "" ? CircleAvatar(
                          backgroundImage: AssetImage(
                            "assets/images/man.png"
                          )
                        ) : CircleAvatar(
                          backgroundImage: NetworkImage(
                            item["profilePic"]
                          ),
                        ),
                        title: Text(
                          item["displayName"]
                        ),
                        subtitle: Text(
                         item["username"]
                        ),
                      ),
                    );
                  },);
                }
              ))
          ],
        ),
      )
    );
  }
}