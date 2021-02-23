// To parse this JSON data, do
//
//     final modelRegister = modelRegisterFromJson(jsonString);

import 'dart:convert';

ModelRegister modelRegisterFromJson(String str) => ModelRegister.fromJson(json.decode(str));

String modelRegisterToJson(ModelRegister data) => json.encode(data.toJson());

class ModelRegister {
  ModelRegister({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  Data data;

  factory ModelRegister.fromJson(Map<String, dynamic> json) => ModelRegister(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : data.toJson(),
  };
}

class Data {
  Data({
    this.username,
    this.password,
    this.email,
    this.noTelp,
  });

  String username;
  String password;
  String email;
  String noTelp;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    username: json["username"] == null ? null : json["username"],
    password: json["password"] == null ? null : json["password"],
    email: json["email"] == null ? null : json["email"],
    noTelp: json["no_telp"] == null ? null : json["no_telp"],
  );

  Map<String, dynamic> toJson() => {
    "username": username == null ? null : username,
    "password": password == null ? null : password,
    "email": email == null ? null : email,
    "no_telp": noTelp == null ? null : noTelp,
  };
}
