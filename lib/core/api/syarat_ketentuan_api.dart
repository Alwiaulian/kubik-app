import 'package:dio/dio.dart';
import 'package:kubik/core/base_url.dart';

import '../flutter_no_sql.dart';
import '../log.dart';

class SyaratKetentuanApi {
  static String syaratketentuanUrl = 'api/v1/syarat-ketentuan';

  static getDataSyaratketentuan() async {
    String url = BaseUrl.baseUrl + syaratketentuanUrl;
    Dio dio = Dio();

    String? token = FlutterNoSql.getToken();
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers['Authorization'] = 'Bearer $token';

    Response response;
    try {
      response = await dio.get(url);
      L.map(response.data);
      return response.data;
    } catch (e) {
      L.error(e.toString());
      return null;
    }
  }
}
