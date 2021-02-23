// To parse this JSON data, do
//
//     final modelLogin = modelLoginFromJson(jsonString);

import 'dart:convert';

ModelLogin modelLoginFromJson(String str) => ModelLogin.fromJson(json.decode(str));

String modelLoginToJson(ModelLogin data) => json.encode(data.toJson());

class ModelLogin {
  ModelLogin({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory ModelLogin.fromJson(Map<String, dynamic> json) => ModelLogin(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.idUser,
    this.username,
    this.password,
    this.namaLengkap,
    this.email,
    this.noTelp,
    this.foto,
    this.level,
    this.blokir,
    this.idSession,
  });

  int idUser;
  String username;
  String password;
  String namaLengkap;
  String email;
  String noTelp;
  String foto;
  String level;
  String blokir;
  String idSession;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    idUser: json["id_user"] == null ? null : json["id_user"],
    username: json["username"] == null ? null : json["username"],
    password: json["password"] == null ? null : json["password"],
    namaLengkap: json["nama_lengkap"] == null ? null : json["nama_lengkap"],
    email: json["email"] == null ? null : json["email"],
    noTelp: json["no_telp"] == null ? null : json["no_telp"],
    foto: json["foto"] == null ? null : json["foto"],
    level: json["level"] == null ? null : json["level"],
    blokir: json["blokir"] == null ? null : json["blokir"],
    idSession: json["id_session"] == null ? null : json["id_session"],
  );

  Map<String, dynamic> toJson() => {
    "id_user": idUser == null ? null : idUser,
    "username": username == null ? null : username,
    "password": password == null ? null : password,
    "nama_lengkap": namaLengkap == null ? null : namaLengkap,
    "email": email == null ? null : email,
    "no_telp": noTelp == null ? null : noTelp,
    "foto": foto == null ? null : foto,
    "level": level == null ? null : level,
    "blokir": blokir == null ? null : blokir,
    "id_session": idSession == null ? null : idSession,
  };
}
