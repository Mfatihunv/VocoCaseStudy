class LoginModel {
  String? token;
  LoginModel({
    this.token,
  });
  LoginModel.fromJson(Map<String, dynamic> json) {
    token = json['token']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['token'] = token;
    return data;
  }
}
