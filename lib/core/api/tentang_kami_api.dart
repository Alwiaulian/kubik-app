import 'package:dio/dio.dart';
import 'package:kubik/core/base_url.dart';
import '../flutter_no_sql.dart';
import '../log.dart';

class TentangKamiApi {
  static String tentangkamiUrl = 'api/v1/tentang-kami';

  static getDataTentangKami() async {
    String url = BaseUrl.baseUrl + tentangkamiUrl;
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
