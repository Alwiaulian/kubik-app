class FraseModel {
  bool? success;
  dynamic error;
  String? message;
  List<FraseModelData>? data;

  FraseModel(
    this.success,
    this.error,
    this.message,
    this.data,
  );

  FraseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    error = json['error'];
    message = json['message'];
    if (json['data'] != null) {
      data = <FraseModelData>[];
      json['data'].forEach((v) {
        data?.add(FraseModelData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['error'] = error;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FraseModelData {
  String? namaKategori;
  List<FraseModelDetailData>? data;
  FraseModelData({
    this.namaKategori,
    this.data,
  });

  FraseModelData.fromJson(Map<String, dynamic> json) {
    namaKategori = json["nama_kategori"];
    if (json['data'] != null) {
      data = <FraseModelDetailData>[];
      json['data'].forEach((v) {
        data?.add(FraseModelDetailData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nama_kategori'] = namaKategori;
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FraseModelDetailData {
  int id;
  String slug;
  String namaKategori;
  String namaSubKategori;
  String kalimat;
  String updatedAt;
  String createdAt;

  FraseModelDetailData({
    required this.id,
    required this.slug,
    required this.namaKategori,
    required this.namaSubKategori,
    required this.kalimat,
    required this.updatedAt,
    required this.createdAt,
  });

  factory FraseModelDetailData.fromJson(Map<String, dynamic> json) =>
      FraseModelDetailData(
        id: json["id"],
        slug: json["slug"],
        namaKategori: json["nama_kategori"],
        namaSubKategori: json["nama_sub_kategori"],
        kalimat: json["kalimat"],
        updatedAt: json["updated_at"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "nama_kategori": namaKategori,
        "nama_sub_kategori": namaSubKategori,
        "kalimat": kalimat,
        "updated_at": updatedAt,
        "created_at": createdAt,
      };
}
