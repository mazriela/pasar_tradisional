// To parse this JSON data, do
//
//     final modelGetSubKategori = modelGetSubKategoriFromJson(jsonString);

import 'dart:convert';

ModelSubKategoriProduk modelGetSubKategoriFromJson(String str) => ModelSubKategoriProduk.fromJson(json.decode(str));

String modelGetSubKategoriToJson(ModelSubKategoriProduk data) => json.encode(data.toJson());

class ModelSubKategoriProduk {
  ModelSubKategoriProduk({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory ModelSubKategoriProduk.fromJson(Map<String, dynamic> json) => ModelSubKategoriProduk(
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
    this.idKategoriProdukSub,
    this.idKategoriProduk,
    this.namaKategoriSub,
    this.kategoriSeoSub,
    this.gambar,
  });

  int idPasar;
  int idKategoriProdukSub;
  int idKategoriProduk;
  String namaKategoriSub;
  String kategoriSeoSub;
  String gambar;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    idPasar: json["id_pasar"] == null ? null : json["id_pasar"],
    idKategoriProdukSub: json["id_kategori_produk_sub"] == null ? null : json["id_kategori_produk_sub"],
    idKategoriProduk: json["id_kategori_produk"] == null ? null : json["id_kategori_produk"],
    namaKategoriSub: json["nama_kategori_sub"] == null ? null : json["nama_kategori_sub"],
    kategoriSeoSub: json["kategori_seo_sub"] == null ? null : json["kategori_seo_sub"],
    gambar: json["gambar"] == null ? null : json["gambar"],
  );

  Map<String, dynamic> toJson() => {
    "id_pasar": idPasar == null ? null : idPasar,
    "id_kategori_produk_sub": idKategoriProdukSub == null ? null : idKategoriProdukSub,
    "id_kategori_produk": idKategoriProduk == null ? null : idKategoriProduk,
    "nama_kategori_sub": namaKategoriSub == null ? null : namaKategoriSub,
    "kategori_seo_sub": kategoriSeoSub == null ? null : kategoriSeoSub,
    "gambar": gambar == null ? null : gambar,
  };
}
