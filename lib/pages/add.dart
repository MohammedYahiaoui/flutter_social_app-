import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:social_app/colors/app_color.dart';
import 'package:social_app/services/cloud.dart';
import 'package:social_app/utils/picker.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  Uint8List? file;
  TextEditingController desCon = TextEditingController();

  uploadPost() async {
    try {
      String res = await CloudMethiods().uploadPost(
        description: desCon.text,
        uid: "2hwuonnKeRUc2pWssk55RjHHhVq2",
        displayName: "Amine",
        file: file!,
        username: "Amine13",
      );
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Post"),
        actions: [
          TextButton(
            onPressed: () {
              uploadPost();
            },
            child: Text("Post"),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage("assets/images/man.png"),
                ),
                Gap(20),
                Expanded(
                  child: TextField(
                    controller: desCon,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: "Type here...",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child:
                  file == null
                      ? Container()
                      : Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          // borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: MemoryImage(file!),
                          ),
                          color: kWhiteColor.withValues(alpha: 0.2),
                        ),
                      ),
            ),
            Gap(20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                iconSize: 25,
                shape: CircleBorder(),
                padding: EdgeInsets.all(20),
                backgroundColor: Colors.black,
              ),
              onPressed: () async {
                Uint8List? filePicker = await pickImage();
                setState(() {
                  file = filePicker;
                });
              },
              child: Icon(Icons.camera, color: kWhiteColor),
            ),
            Gap(80),
          ],
        ),
      ),
    );
  }
}
