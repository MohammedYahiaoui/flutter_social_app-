import 'package:flutter/material.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/services/auth.dart';

class UserProvider with ChangeNotifier{
  UserModel? userModel;
  bool isLoad = true;

  getDetails() async{
    userModel = await AuthMethods().getUserDetails();
    isLoad = false;
    notifyListeners();
  }
}