import 'package:dio/dio.dart';
import 'package:kubik/core/base_url.dart';
import 'package:kubik/core/flutter_no_sql.dart';
import 'package:kubik/core/log.dart';

class BicaraCepatApi {
  static String bicaracepatUrl = 'api/v1/bicara-cepat';

  static getDataBicaracepat() async {
    String url = BaseUrl.baseUrl + bicaracepatUrl;
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
