// To parse this JSON data, do
//
//     final modelGetPasar = modelGetPasarFromJson(jsonString);

import 'dart:convert';

ModelGetPasar modelGetPasarFromJson(String str) => ModelGetPasar.fromJson(json.decode(str));

String modelGetPasarToJson(ModelGetPasar data) => json.encode(data.toJson());

class ModelGetPasar {
  ModelGetPasar({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory ModelGetPasar.fromJson(Map<String, dynamic> json) => ModelGetPasar(
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
    this.idPasar,
    this.namaPasar,
    this.alamat,
    this.tanggalDaftar,
    this.idKota,
    this.lat,
    this.lng,
    this.picNumber,
    this.picName,
  });

  int idPasar;
  String namaPasar;
  String alamat;
  DateTime tanggalDaftar;
  int idKota;
  double lat;
  double lng;
  String picNumber;
  String picName;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    idPasar: json["id_pasar"] == null ? null : json["id_pasar"],
    namaPasar: json["nama_pasar"] == null ? null : json["nama_pasar"],
    alamat: json["alamat"] == null ? null : json["alamat"],
    tanggalDaftar: json["tanggal_daftar"] == null ? null : DateTime.parse(json["tanggal_daftar"]),
    idKota: json["id_kota"] == null ? null : json["id_kota"],
    lat: json["lat"] == null ? null : json["lat"].toDouble(),
    lng: json["lng"] == null ? null : json["lng"].toDouble(),
    picNumber: json["pic_number"] == null ? null : json["pic_number"],
    picName: json["pic_name"] == null ? null : json["pic_name"],
  );

  Map<String, dynamic> toJson() => {
    "id_pasar": idPasar == null ? null : idPasar,
    "nama_pasar": namaPasar == null ? null : namaPasar,
    "alamat": alamat == null ? null : alamat,
    "tanggal_daftar": tanggalDaftar == null ? null : tanggalDaftar.toIso8601String(),
    "id_kota": idKota == null ? null : idKota,
    "lat": lat == null ? null : lat,
    "lng": lng == null ? null : lng,
    "pic_number": picNumber == null ? null : picNumber,
    "pic_name": picName == null ? null : picName,
  };
}
