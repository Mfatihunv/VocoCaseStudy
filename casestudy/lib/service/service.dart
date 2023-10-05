import 'dart:developer';
import 'package:casestudy/model/all_user_model.dart';
import 'package:casestudy/model/login_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class AuthService {
  final String baseUrl = "https://reqres.in/api/";
  final dio = Dio();
  Future<LoginModel?> loginCall(
      {required String email, required String password}) async {
    Map<String, dynamic> json = {"email": email, "password": password};
    var response = await dio.post(baseUrl + "login", data: json);
    if (response.statusCode == 200) {
      var result = LoginModel.fromJson(response.data);
      log("Gelen Response => ${response.data}");
      return result;
    } else if (response.statusCode == 400) {
      var result = LoginModel.fromJson(response.data);
      throw ("Bi sorun var knk${result}");
    } else {
      throw ("Bir sorun oluştu ${response.statusCode}");
    }
  }
}

class GetAllUsers {
  final String baseUrl = "https://reqres.in/api/";
  final Dio dio = Dio();
  String token = GetStorage().read("token");

  GetAllUsers() {
    dio.interceptors.add(PrettyDioLogger());
  }

  Future<AllUsers?> getAllUsers() async {
    try {
      var response = await dio.get(
        baseUrl + "users?page=2",
      );
      if (response.statusCode == 200) {
        var result = AllUsers.fromJson(response.data);
        print("Gelen Response => ${response.data}");
        return result;
      } else {
        throw ("Bir sorun oluştu ${response.statusCode}");
      }
    } catch (error) {
      throw ("Bir sorun oluştu: $error");
    }
  }
}
