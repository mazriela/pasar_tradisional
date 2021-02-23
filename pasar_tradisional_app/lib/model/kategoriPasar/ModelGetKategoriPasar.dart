// To parse this JSON data, do
//
//     final modelGetKategoriPasar = modelGetKategoriPasarFromJson(jsonString);

import 'dart:convert';

ModelGetKategoriPasar modelGetKategoriPasarFromJson(String str) => ModelGetKategoriPasar.fromJson(json.decode(str));

String modelGetKategoriPasarToJson(ModelGetKategoriPasar data) => json.encode(data.toJson());

class ModelGetKategoriPasar {
  ModelGetKategoriPasar({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory ModelGetKategoriPasar.fromJson(Map<String, dynamic> json) => ModelGetKategoriPasar(
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
    this.idKategoriProduk,
    this.namaKategori,
    this.kategoriSeo,
  });

  int idPasar;
  int idKategoriProduk;
  String namaKategori;
  String kategoriSeo;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    idPasar: json["id_pasar"] == null ? null : json["id_pasar"],
    idKategoriProduk: json["id_kategori_produk"] == null ? null : json["id_kategori_produk"],
    namaKategori: json["nama_kategori"] == null ? null : json["nama_kategori"],
    kategoriSeo: json["kategori_seo"] == null ? null : json["kategori_seo"],
  );

  Map<String, dynamic> toJson() => {
    "id_pasar": idPasar == null ? null : idPasar,
    "id_kategori_produk": idKategoriProduk == null ? null : idKategoriProduk,
    "nama_kategori": namaKategori == null ? null : namaKategori,
    "kategori_seo": kategoriSeo == null ? null : kategoriSeo,
  };
}
