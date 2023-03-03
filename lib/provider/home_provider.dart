import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_project/models/usermodel.dart';
import 'package:new_project/service/get_user.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider() {
    getData();
  }
  GetUserService getUserService = GetUserService();
  List<UserModel>? data;
  bool isLoading = false;
  String? error = "";
  void getData() async {
    isLoading = true;
    notifyListeners();
    dynamic response = await getUserService.getUserService();
    if (response is List<UserModel>) {
      data = response;
      isLoading = false;
      notifyListeners();
    } else {
      error = response;
      isLoading = false;
      notifyListeners();
    }
  }
}
