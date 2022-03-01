class LoginModel {
  bool success;
  dynamic error;
  String message;
  Data data;

  LoginModel({
    required this.success,
    this.error,
    required this.message,
    required this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        success: json["success"],
        error: json["error"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "error": error,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  String namaLengkap;
  String username;
  String namaAnak;
  String email;
  String apiToken;

  Data({
    required this.namaLengkap,
    required this.username,
    required this.namaAnak,
    required this.email,
    required this.apiToken,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        namaLengkap: json["nama_lengkap"],
        username: json["username"],
        namaAnak: json["nama_anak"],
        email: json["email"],
        apiToken: json["api_token"],
      );

  Map<String, dynamic> toJson() => {
        "nama_lengkap": namaLengkap,
        "username": username,
        "nama_anak": namaAnak,
        "email": email,
        "api_token": apiToken,
      };
}
