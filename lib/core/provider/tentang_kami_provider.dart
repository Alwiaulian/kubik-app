import 'package:flutter/material.dart';
import 'package:kubik/core/flutter_no_sql.dart';
import 'package:kubik/core/flutter_toast.dart';
import 'package:kubik/core/sql_no_key.dart';
import 'package:kubik/ui/router/router.dart';
import 'package:kubik/model/tentang_kami_model.dart';
import 'package:kubik/core/api/tentang_kami_api.dart';

class TentangKamiProvider with ChangeNotifier {
  final BuildContext context;
  TentangKamiProvider(this.context) {
    getTentangKamiPageData();
  }

  bool loading = true;
  getTentangKamiPageData() async {
    loading = true;
    await getTentangKamiData();
    notifyListeners();
    loading = false;
  }

  late TentangKamiModelData tentangKamiModelData;

  getTentangKamiData() async {
    var data = await TentangKamiApi.getDataTentangKami();
    if (data['error'] == "AuthenticationException") {
      AppRouter.navToLoginPage(context);
      FlutterToast.showSuccess(context: context, message: 'Unauthorized!');
      FlutterNoSql.clearToken();
      // FlutterNoSql.clearProjectId();
      FlutterNoSql.clearJsonString(key: NoSqlKey.loginApiKey);
    }
    if (data == null) return;
    if (data['success'] == true) {
      tentangKamiModelData = TentangKamiModelData.fromJson(data['data']);
      // L.log('data project_id: '+project_id.toString());
      notifyListeners();
    }
  }
}
