import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kubik/core/api/edit_profil_api.dart';
import 'package:kubik/core/api/logout_api.dart';
import 'package:kubik/core/flutter_no_sql.dart';
import 'package:kubik/core/flutter_toast.dart';
import 'package:kubik/core/log.dart';
import 'package:kubik/core/sql_no_key.dart';
import 'package:kubik/ui/router/dialog_router.dart';
import 'package:kubik/ui/router/router.dart';

class EditProfilProvider with ChangeNotifier {
  final BuildContext context;
  EditProfilProvider(this.context) {
    getEditProfilData();
  }

  bool loading = true;
  getEditProfilData() async {
    loading = true;

    notifyListeners();
    loading = false;
  }

  TextEditingController namaAnakController = TextEditingController();
  TextEditingController namaOrangtuaController = TextEditingController();
  TextEditingController namaUserController = TextEditingController();
  TextEditingController passwordLamaController = TextEditingController();
  TextEditingController passwordBaruController = TextEditingController();
  TextEditingController konfirmasiPasswordbaruController =
      TextEditingController();

  final formKey = GlobalKey<FormState>();

  changeProfil() async {
    if (formKey.currentState!.validate()) {
      if (passwordLamaController.text.trim() == '') {
        FlutterToast.showErrorToast(
            context: context, message: 'password harus di isi');
        return;
      }

      if (passwordBaruController.text.trim() != '') {
        if (passwordBaruController.text.trim() !=
            konfirmasiPasswordbaruController.text.trim()) {
          FlutterToast.showErrorToast(
              context: context, message: 'password konfirmasi tidak sama');
          return;
        }
      }
      DialogRouter.displayProgressDialog(context);
      var data = await EditProfilApi.postEditProfil(
        namaAnak: namaAnakController.text.trim(),
        namaOrangtua: namaOrangtuaController.text.trim(),
        namaUser: namaUserController.text.trim(),
        passwordLama: passwordLamaController.text.trim(),
        passwordBaru: passwordBaruController.text.trim(),
        konfirmasiPasswordbaru: konfirmasiPasswordbaruController.text.trim(),
      );
      DialogRouter.closeProgressDialog(context);
      if (data == null) {
        FlutterToast.showErrorToast(
            context: context, message: 'connection failed.');
        return;
      } else {
        if (data['success'] == true) {
          FlutterToast.showSuccess(
              context: context, message: data['message'].toString());
          return logout();

          // return;
        } else {
          L.error(data);
          FlutterToast.showErrorToast(
              context: context, message: data['message'].toString());
        }
      }
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
