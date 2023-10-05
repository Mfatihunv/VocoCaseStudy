import 'package:casestudy/model/all_user_model.dart';
import 'package:casestudy/service/service.dart';
import 'package:flutter/material.dart';

class HomeRiverpod extends ChangeNotifier {
  List<User?> myAllUsers = [];
  final service = GetAllUsers();
  bool isLoading = false;
  void getAllUsers() {
    isLoading = true;
    service.getAllUsers().then((value) {
      if (value != null) {
        myAllUsers = value.data ?? [];
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }
}
