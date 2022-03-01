class TentangKamiModel {
  bool success;
  dynamic error;
  String message;
  TentangKamiModelData data;

  TentangKamiModel({
    required this.success,
    this.error,
    required this.message,
    required this.data,
  });

  factory TentangKamiModel.fromJson(Map<String, dynamic> json) =>
      TentangKamiModel(
        success: json["success"],
        error: json["error"],
        message: json["message"],
        data: TentangKamiModelData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "error": error,
        "message": message,
        "data": data.toJson(),
      };
}

class TentangKamiModelData {
  int id;
  String deskripsi;
  var image;
  String createdAt;
  String updatedAt;
  TentangKamiModelData({
    required this.id,
    required this.deskripsi,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TentangKamiModelData.fromJson(Map<String, dynamic> json) =>
      TentangKamiModelData(
        id: json["id"],
        deskripsi: json["deskripsi"],
        image: json["image"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "deskripsi": deskripsi,
        "image": image,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
