import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:kubik/core/base_url.dart';

class DaftarApi {
  static String daftarUrl = 'api/v1/register';

  static postDaftar(
      {required String nama_user,
      required String email,
      required String password,
      required String konfirmasi_password,
      required String nama_orang_tua,
      required String nama_anak}) async {
    String url = BaseUrl.baseUrl + daftarUrl;

    Dio dio = Dio();

    dio.options.headers['Accept'] = 'application/json';
    Map<String, dynamic> mp = {};

    mp['nama_user'] = nama_user;
    mp['email'] = email;
    mp['password'] = password;
    mp['konfirmasi_password'] = konfirmasi_password;
    mp['nama_orang_tua'] = nama_orang_tua;
    mp['nama_anak'] = nama_anak;

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
