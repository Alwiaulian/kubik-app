import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kubik/core/api/daftar_api.dart';
import 'package:kubik/core/flutter_toast.dart';
import 'package:kubik/ui/router/dialog_router.dart';
import 'package:kubik/ui/router/router.dart';

class DaftarProvider with ChangeNotifier {
  final BuildContext context;
  DaftarProvider(this.context);

  TextEditingController namauserController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController konfirmasipasswordController = TextEditingController();
  TextEditingController namaorangtuaController = TextEditingController();
  TextEditingController namaanakController = TextEditingController();

  String nama_user = "";
  String email = "";
  String password = "";
  String konfirmasi_password = "";
  String nama_orang_tua = "";
  String nama_anak = "";
  final formKey = GlobalKey<FormState>();

  daftar() async {
    if (formKey.currentState!.validate()) {
      DialogRouter.displayProgressDialog(context);
      var data = await DaftarApi.postDaftar(
        nama_user: namauserController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        konfirmasi_password: konfirmasipasswordController.text.trim(),
        nama_orang_tua: namaorangtuaController.text.trim(),
        nama_anak: namaorangtuaController.text.trim(),
        // username: usernameController.text.trim(),
        // password: passwordController.text.trim(),
      );
      if (data == null) {
        DialogRouter.closeProgressDialog(context);
        return;
      } else {
        if (data['success'] == true) {
          DialogRouter.closeProgressDialog(context);
          FlutterToast.showSuccess(
              context: context, message: data['message'].toString());

          AppRouter.navToSyaratKetentuan(
              context, namauserController.text.trim());
        } else {
          // L.error(data);
          DialogRouter.closeProgressDialog(context);
          FlutterToast.showErrorToast(
              context: context, message: data['message'].toString());
        }
      }
    }
  }
}
