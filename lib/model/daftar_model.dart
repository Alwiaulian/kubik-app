class DaftarModel {
  bool? success;
  dynamic error;
  String? message;
  DaftarModelData? data;

  DaftarModel(
    this.success,
    this.error,
    this.message,
    this.data,
  );

  DaftarModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    error = json['error'];
    message = json['message'];
    data = json['data'] != null ? DaftarModelData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['error'] = error;
    data['message'] = message;
    data['data'] = this.data?.toJson();
    return data;
  }

  // factory DaftarModel.fromJson(Map<String, dynamic> json) => DaftarModel(
  //       success: json["success"],
  //       error: json["error"],
  //       message: json["message"],
  //       data: json["data"],
  //     );

  // Map<String, dynamic> toJson() => {
  //       "success": success,
  //       "error": error,
  //       "message": message,
  //       "data": data,
  //     };
}

class DaftarModelData {
  String namaLengkap;
  String namaAnak;
  String email;
  String username;
  String slug;
  String updatedAt;
  String createdAt;
  int id;

  DaftarModelData({
    required this.namaLengkap,
    required this.namaAnak,
    required this.email,
    required this.username,
    required this.slug,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory DaftarModelData.fromJson(Map<String, dynamic> json) =>
      DaftarModelData(
        namaLengkap: json["nama_lengkap"],
        namaAnak: json["nama_anak"],
        email: json["email"],
        username: json["username"],
        slug: json["slug"],
        updatedAt: json["updated_at"],
        createdAt: json["created_at"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "nama_lengkap": namaLengkap,
        "nama_anak": namaAnak,
        "email": email,
        "username": username,
        "slug": slug,
        "updated_at": updatedAt,
        "created_at": createdAt,
        "id": id,
      };
}
