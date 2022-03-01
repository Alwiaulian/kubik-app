class SyaratKetentuanModel {
  bool success;
  dynamic error;
  String message;
  SyaratKetentuanModelData data;

  SyaratKetentuanModel({
    required this.success,
    this.error,
    required this.message,
    required this.data,
  });

  factory SyaratKetentuanModel.fromJson(Map<String, dynamic> json) =>
      SyaratKetentuanModel(
        success: json["success"],
        error: json["error"],
        message: json["message"],
        data: SyaratKetentuanModelData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "error": error,
        "message": message,
        "data": data.toJson(),
      };
}

class SyaratKetentuanModelData {
  int id;
  String deskripsi;
  String createdAt;
  String updatedAt;
  SyaratKetentuanModelData({
    required this.id,
    required this.deskripsi,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SyaratKetentuanModelData.fromJson(Map<String, dynamic> json) =>
      SyaratKetentuanModelData(
        id: json["id"],
        deskripsi: json["deskripsi"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "deskripsi": deskripsi,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
