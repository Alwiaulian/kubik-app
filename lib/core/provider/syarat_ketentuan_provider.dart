import 'package:flutter/material.dart';
import 'package:kubik/core/flutter_no_sql.dart';
import 'package:kubik/core/flutter_toast.dart';
import 'package:kubik/core/sql_no_key.dart';
import 'package:kubik/ui/router/router.dart';
import 'package:kubik/model/syarat_ketentuan_model.dart';
import 'package:kubik/core/api/syarat_ketentuan_api.dart';

class SyaratKetentuanProvider with ChangeNotifier {
  final BuildContext context;
  SyaratKetentuanProvider(this.context) {
    getSyaratKetentuanPageData();
  }

  bool loading = true;
  getSyaratKetentuanPageData() async {
    loading = true;
    await getSyaratKetentuanData();
    notifyListeners();
    loading = false;
  }

  late SyaratKetentuanModelData syaratKetentuanModelData;

  getSyaratKetentuanData() async {
    var data = await SyaratKetentuanApi.getDataSyaratketentuan();
    if (data['error'] == "AuthenticationException") {
      AppRouter.navToLoginPage(context);
      FlutterToast.showSuccess(context: context, message: 'Unauthorized!');
      FlutterNoSql.clearToken();
      // FlutterNoSql.clearProjectId();
      FlutterNoSql.clearJsonString(key: NoSqlKey.loginApiKey);
    }
    if (data == null) return;
    if (data['success'] == true) {
      syaratKetentuanModelData =
          SyaratKetentuanModelData.fromJson(data['data']);
      // L.log('data project_id: '+project_id.toString());
      notifyListeners();
    }
  }
}
