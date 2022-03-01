import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kubik/core/api/bicara_cepat_api.dart';
import 'package:kubik/core/api/frase_api.dart';
import 'package:kubik/core/api/login_api.dart';
import 'package:kubik/core/flutter_no_sql.dart';
import 'package:kubik/core/flutter_toast.dart';
import 'package:kubik/core/sql_no_key.dart';
import 'package:kubik/model/bicara_cepat_model.dart';
import 'package:kubik/model/frase_model.dart';
import 'package:kubik/model/login_model.dart';
import 'package:kubik/ui/router/dialog_router.dart';
import 'package:kubik/ui/router/router.dart';

class LoginProvider with ChangeNotifier {
  final BuildContext context;
  LoginProvider(this.context);

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String username = "";
  String password = "";
  final formKey = GlobalKey<FormState>();

  login(bool isChecked) async {
    if (formKey.currentState!.validate()) {
      DialogRouter.displayProgressDialog(context);

      var data = await LoginApi.postLogin(
        username: usernameController.text.trim(),
        password: passwordController.text.trim(),
      );
      if (data == null) {
        DialogRouter.closeProgressDialog(context);
        return;
      } else {
        if (data['success'] == true) {
          LoginModel model = LoginModel.fromJson(data);

          await FlutterNoSql.saveToken(model.data.apiToken);
          await FlutterNoSql.saveJsonString(key: NoSqlKey.loginApiKey, json: json.encode(model.toJson()));

          var dataBicaraCepat = await BicaraCepatApi.getDataBicaracepat();
          if (dataBicaraCepat['success'] == true) {
            BicaraCepatModel bicaraCepatModel = BicaraCepatModel.fromJson(dataBicaraCepat);
            await FlutterNoSql.saveJsonBicaraCepat(key: NoSqlKey.bicaraCepatApiKey, json: json.encode(bicaraCepatModel.toJson()));
          }

          var dataFrase = await FraseApi.getDataFrase();
          if (dataFrase['success'] == true) {
            FraseModel fraseModel = FraseModel.fromJson(dataFrase);
            await FlutterNoSql.saveJsonFrase(key: NoSqlKey.fraseApiKey, json: json.encode(fraseModel.toJson()));
          }

          // if (isChecked){
          //   await FlutterNoSql.saveUsernamePassword(usernameController.text.trim(), passwordController.text.trim());
          //   await FlutterNoSql.saveIsRememberMe(true);
          // }else{
          //   await FlutterNoSql.saveUsernamePassword("", "");
          //   await FlutterNoSql.saveIsRememberMe(false);
          // }
          DialogRouter.closeProgressDialog(context);
          FlutterToast.showSuccess(context: context, message: data['message'].toString());
          AppRouter.navToDashboardPage(context);
        } else {
          // L.error(data);
          DialogRouter.closeProgressDialog(context);
          FlutterToast.showErrorToast(context: context, message: data['message'].toString());
        }
      }
    }
  }

}
