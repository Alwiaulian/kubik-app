import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kubik/core/api/logout_api.dart';
import 'package:kubik/core/api/bicara_cepat_api.dart';
import 'package:kubik/core/api/frase_api.dart';
import 'package:kubik/core/flutter_no_sql.dart';
import 'package:kubik/core/flutter_toast.dart';
import 'package:kubik/core/log.dart';
import 'package:kubik/core/sql_no_key.dart';
import 'package:kubik/model/bicara_cepat_model.dart';
import 'package:kubik/model/login_model.dart';
import 'package:kubik/model/frase_model.dart';
import 'package:kubik/ui/router/dialog_router.dart';
import 'package:kubik/ui/router/router.dart';

class DashboardProvider with ChangeNotifier {
  final BuildContext context;
  DashboardProvider(this.context) {
    getDashboardData();
  }

  bool loading = true;
  getDashboardData() async {
    loading = true;
    await getLoginData();
    await getBicaraCepatData();
    await getFraseData();
    notifyListeners();
    loading = false;
  }

  late LoginModel loginModel;
  List<BicaraCepatModelData> bicaraCepatModelData = [];
  List<FraseModelData> fraseModelData = [];
  Map arrayKategoriFrase = {};

  getLoginData() async {
    loginModel = LoginModel.fromJson(
        json.decode(FlutterNoSql.getJsonString(key: NoSqlKey.loginApiKey)));
  }

  getBicaraCepatData() async {
    var bicaraCepatdata = await json.decode(FlutterNoSql.getJsonBicaraCepat(key: NoSqlKey.bicaraCepatApiKey));
    List dataList = bicaraCepatdata['data'];
    for (var element in dataList) {
      bicaraCepatModelData.add(BicaraCepatModelData.fromJson(element));
    }
  }

  getFraseData() async {
    var frasedata = await json.decode(FlutterNoSql.getJsonFrase(key: NoSqlKey.fraseApiKey));
    List dataList = frasedata['data'];
    for (var element in dataList) {
      arrayKategoriFrase[element['nama_kategori']] = false;
      fraseModelData.add(FraseModelData.fromJson(element));
    }
  }

  logout() async {
    DialogRouter.displayProgressDialog(context);

    var data = await LogoutApi.postLogout();
    DialogRouter.closeProgressDialog(context);
    if (data == null) {
      FlutterToast.showErrorToast(
          context: context, message: 'connection failed.');
      return;
    } else {
      if (data['success'] == true) {
        FlutterToast.showSuccess(
            context: context, message: data['message'].toString());
        FlutterNoSql.clearToken();
        FlutterNoSql.clearJsonString(key: NoSqlKey.loginApiKey);
        DialogRouter.closeProgressDialog(context);
        AppRouter.navToLoginPage(context);
      } else {
        // L.error(data);
        FlutterToast.showErrorToast(
            context: context, message: data['message'].toString());
      }
    }
  }
}
