class BicaraCepatModel {
  bool? success;
  dynamic error;
  String? message;
  List<BicaraCepatModelData>? data;

  BicaraCepatModel({
    this.success,
    this.error,
    this.message,
    this.data,
  });

  BicaraCepatModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    error = json['error'];
    message = json['message'];
    if (json['data'] != null) {
      data = <BicaraCepatModelData>[];
      json['data'].forEach((v) {
        data?.add(BicaraCepatModelData.fromJson(v));
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

class BicaraCepatModelData {
  int id;
  String slug;
  String kata;
  String kalimat;
  String createdAt;
  String updatedAt;
  String urlFilesuara;

  BicaraCepatModelData({
    required this.id,
    required this.slug,
    required this.kata,
    required this.kalimat,
    required this.createdAt,
    required this.updatedAt,
    required this.urlFilesuara,
  });

  factory BicaraCepatModelData.fromJson(Map<String, dynamic> json) =>
      BicaraCepatModelData(
        id: json["id"],
        slug: json["slug"],
        kata: json["kata"],
        kalimat: json["kalimat"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        urlFilesuara: json["url_file_suara"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "kata": kata,
        "kalimat": kalimat,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "url_file_suara": urlFilesuara,
      };
}
