import 'dart:developer';

import 'package:casestudy/service/service.dart';
import 'package:casestudy/view/homepage.dart';
import 'package:casestudy/view/signup.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grock/grock.dart';

class LoginRiverpod extends ChangeNotifier {
  final service = AuthService();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final box = GetStorage();
  void sigin(BuildContext context) {
    Center(child: CircularProgressIndicator());
    service.loginCall(email: email.text, password: password.text).then((value) {
      if (value != null) {
        box.write("token", value.token);
        log("Kaydedilen Token => ${box.read("token")}");
        Navigator.pop(context);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ));
      }
    }).catchError((error) {
      Grock.snackBar(
          title: "Hata",
          description: "Mail veya Şifreniz HatalI, Lütfen kontrol ediniz");
    });
  }
}
