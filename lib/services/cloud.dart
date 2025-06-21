import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/models/poost.dart';
import 'package:social_app/services/storage.dart';
import 'package:uuid/uuid.dart';

class CloudMethiods {
  CollectionReference posts = FirebaseFirestore.instance.collection("posts");
  CollectionReference users = FirebaseFirestore.instance.collection("users");

  uploadPost({
    required String description,
    required String uid,
    required String displayName,
    required Uint8List file,
    String? profilPic,
    required String username,
  }) async {
    String res = "Sme error";
    try {
      String postId = Uuid().v1();
      String postImage = await StorageMethods().uploadImageToStorage(
        file,
        "posts",
        true,
      );
      PostModel postModel = PostModel(
        uid: uid,
        displayName: displayName,
        username: username,
        profilePic: profilPic ?? "",
        description: description,
        postId: postId,
        postImage: "postImage",
        date: DateTime.now(),
        like: [],
      );
      posts.doc(postId).set(postModel.toJson());
      res = "Success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  likePost(String postId, String uid, List like) async {
    String res = "some error";

    try {
      if (like.contains(uid)) {
        posts.doc(postId).update({
          'like': FieldValue.arrayRemove([uid]),
        });
        } else {
          posts.doc(postId).update({
          'like': FieldValue.arrayUnion([uid]),
        });
        res = "success";
      }
    } on Exception catch (e) {
      // TODO
    }
  }

  commentToPost({
    required String postId,
    required String uid,
    required String commentText,
    required String profilePic,
    required String displayName,
    required String username,
  }) {
    String res = "Some errors";
    try {
      if (commentText.isNotEmpty) {
        String commentId = Uuid().v1();
        posts.doc(postId).collection("comments").doc(commentId).set({
          "uid": uid,
          "postId": postId,
          "commentId": commentId,
          "commentText" : commentText,
          "profilePic": profilePic,
          "displayName": displayName,
          "username": username,
          "date": DateTime.now(),
        });
        res = "success";
      }
    } on Exception catch (e) {
      
    }
    return res;
  }

  followUser(String uid, String followUserId) async {
    DocumentSnapshot documentSnapshot = await users.doc(uid).get();
    List following = (documentSnapshot.data()! as dynamic)["following"];
    try {
      if (following.contains(followUserId)) {
        await users.doc(uid).update({
          "following": FieldValue.arrayRemove([followUserId]),
        });

        await users.doc(followUserId).update({
          "followers": FieldValue.arrayRemove([uid]),
        });
      } else {
        await users.doc(uid).update({
          "following": FieldValue.arrayUnion([followUserId]),
        });

        await users.doc(followUserId).update({
          "followers": FieldValue.arrayUnion([uid]),
        });
      }
    } on Exception catch (e) {
      // TODO
    }
  }

  editProfile({
    required String uid,
    required String displayName,
    required String username,
    Uint8List? file,
    String bio = "",
    String profilePic = "",
  }) async {
    String res = "Some error";

    try {
      profilePic =
          file != null
              ? await StorageMethods().uploadImageToStorage(
                file!,
                "users",
                false,
              )
              : "";
      if (displayName != "" && username != "") {
        users.doc(uid).update({
          "displayName": displayName,
          "username": username,
          "bio": bio,
          "profilePic": profilePic,
        });
        res = "success";
      }
      
    } on Exception catch (e) {
    }
    return res;
  }

  deletePost(String postId) async {
    String res = "Error";
    try {
      await posts.doc(postId).delete();
      res = "success";
    } catch (e) {}
    return res;
  }
}
