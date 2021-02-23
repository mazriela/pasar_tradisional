// To parse this JSON data, do
//
//     final modelGetProduct = modelGetProductFromJson(jsonString);

import 'dart:convert';

ModelGetProduk modelGetProductFromJson(String str) => ModelGetProduk.fromJson(json.decode(str));

String modelGetProductToJson(ModelGetProduk data) => json.encode(data.toJson());

class ModelGetProduk {
  ModelGetProduk({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory ModelGetProduk.fromJson(Map<String, dynamic> json) => ModelGetProduk(
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
    this.idProduk,
    this.idReseller,
    this.idPasar,
    this.namaProduk,
    this.produkSeo,
    this.gambar,
    this.keterangan,
    this.namaReseller,
    this.noTelpon,
    this.namaPasar,
    this.alamat,
    this.detail,
  });

  int idProduk;
  int idReseller;
  int idPasar;
  String namaProduk;
  String produkSeo;
  String gambar;
  String keterangan;
  String namaReseller;
  String noTelpon;
  String namaPasar;
  String alamat;
  List<Detail> detail;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    idProduk: json["id_produk"] == null ? null : json["id_produk"],
    idReseller: json["id_reseller"] == null ? null : json["id_reseller"],
    idPasar: json["id_pasar"] == null ? null : json["id_pasar"],
    namaProduk: json["nama_produk"] == null ? null : json["nama_produk"],
    produkSeo: json["produk_seo"] == null ? null : json["produk_seo"],
    gambar: json["gambar"] == null ? null : json["gambar"],
    keterangan: json["keterangan"] == null ? null : json["keterangan"],
    namaReseller: json["nama_reseller"] == null ? null : json["nama_reseller"],
    noTelpon: json["no_telpon"] == null ? null : json["no_telpon"],
    namaPasar: json["nama_pasar"] == null ? null : json["nama_pasar"],
    alamat: json["alamat"] == null ? null : json["alamat"],
    detail: json["detail"] == null ? null : List<Detail>.from(json["detail"].map((x) => Detail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id_produk": idProduk == null ? null : idProduk,
    "id_reseller": idReseller == null ? null : idReseller,
    "id_pasar": idPasar == null ? null : idPasar,
    "nama_produk": namaProduk == null ? null : namaProduk,
    "produk_seo": produkSeo == null ? null : produkSeo,
    "gambar": gambar == null ? null : gambar,
    "keterangan": keterangan == null ? null : keterangan,
    "nama_reseller": namaReseller == null ? null : namaReseller,
    "no_telpon": noTelpon == null ? null : noTelpon,
    "nama_pasar": namaPasar == null ? null : namaPasar,
    "alamat": alamat == null ? null : alamat,
    "detail": detail == null ? null : List<dynamic>.from(detail.map((x) => x.toJson())),
  };
}

class Detail {
  Detail({
    this.idDetailProduk,
    this.satuan,
    this.stok,
    this.berat,
    this.hargaModal,
    this.hargaKonsumen,
    this.diskon,
    this.id,
  });

  int idDetailProduk;
  String satuan;
  int stok;
  int berat;
  int hargaModal;
  int hargaKonsumen;
  int diskon;
  int id;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    idDetailProduk: json["id_detail_produk"] == null ? null : json["id_detail_produk"],
    satuan: json["satuan"] == null ? null : json["satuan"],
    stok: json["stok"] == null ? null : json["stok"],
    berat: json["berat"] == null ? null : json["berat"],
    hargaModal: json["harga_modal"] == null ? null : json["harga_modal"],
    hargaKonsumen: json["harga_konsumen"] == null ? null : json["harga_konsumen"],
    diskon: json["diskon"] == null ? null : json["diskon"],
    id: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toJson() => {
    "id_detail_produk": idDetailProduk == null ? null : idDetailProduk,
    "satuan": satuan == null ? null : satuan,
    "stok": stok == null ? null : stok,
    "berat": berat == null ? null : berat,
    "harga_modal": hargaModal == null ? null : hargaModal,
    "harga_konsumen": hargaKonsumen == null ? null : hargaKonsumen,
    "diskon": diskon == null ? null : diskon,
    "id": id == null ? null : id,
  };
}
