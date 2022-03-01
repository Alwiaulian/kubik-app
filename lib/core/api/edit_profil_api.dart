import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:kubik/core/base_url.dart';
import 'package:kubik/core/flutter_no_sql.dart';

class EditProfilApi {
  static String editProfilUrl = 'api/v1/edit-user';

  static postEditProfil(
      {String? namaAnak,
      String? namaOrangtua,
      String? namaUser,
      String? passwordLama,
      String? passwordBaru,
      String? konfirmasiPasswordbaru}) async {
    String url = BaseUrl.baseUrl + editProfilUrl;

    Dio dio = Dio();

    String? token = FlutterNoSql.getToken();
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers['Authorization'] = 'Bearer $token';

    Map<String, dynamic> mp = {};

    mp['nama_anak'] = namaAnak;
    mp['nama_orang_tua'] = namaOrangtua;
    mp['nama_user'] = namaUser;
    mp['password_lama'] = passwordLama;
    mp['password_baru'] = passwordBaru;
    mp['konfirmasi_password_baru'] = konfirmasiPasswordbaru;

    Response response;

    try {
      response = await dio.post(url, data: mp);
      if (kDebugMode) {
        print(response);
      }
      return response.data;
    } catch (e) {
      // L.error(e.toString());
      return null;
    }
  }
}
