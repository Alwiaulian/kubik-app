import 'package:flutter/material.dart';
import 'package:kubik/core/provider/edit_profil_provider.dart';
import 'package:kubik/ui/view/auth/daftar_page.dart';
import 'package:kubik/ui/view/auth/login_page.dart';
import 'package:kubik/ui/view/main/dashboard_page.dart';
import 'package:kubik/ui/view/main/edit_profil_page.dart';
import 'package:kubik/ui/view/main/home_page.dart';
import 'package:kubik/ui/view/main/pilih_suara_page.dart';
import 'package:kubik/ui/view/main/selesai_daftar_page.dart';
import 'package:kubik/ui/view/main/syarat_ketentuan_page.dart';
import 'package:kubik/ui/view/main/tentang_kami_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class AppRouter {
  static navToHomePage(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      PageTransition(
        type: PageTransitionType.scale,
        alignment: Alignment.bottomCenter,
        child: HomePage(),
      ),
      (Route<dynamic> route) => false,
      // ModalRoute.withName('/'),
    );
  }

  static navToLoginPage(BuildContext context) {
    return Navigator.pushAndRemoveUntil(
      context,
      PageTransition(
        type: PageTransitionType.scale,
        alignment: Alignment.bottomCenter,
        child: const LoginPage(),
      ),
      (Route<dynamic> route) => false,
    );
  }

  static navToDashboardPage(BuildContext context) {
    return Navigator.pushAndRemoveUntil(
      context,
      PageTransition(
        type: PageTransitionType.scale,
        alignment: Alignment.bottomCenter,
        child: const DashboardPage(),
      ),
      (Route<dynamic> route) => false,
    );
  }

  static navToPilihSuaraPage(BuildContext context) {
    return Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.scale,
        alignment: Alignment.bottomCenter,
        child: const PilihSuaraPage(),
      ),
    );
  }

  static navToSyaratKetentuan(BuildContext context, String namaUser) {
    return Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.scale,
        alignment: Alignment.bottomCenter,
        child: SyaratKetentuanPage(namaUser),
      ),
    );
  }

  static navToTentangKami(BuildContext context) {
    return Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.scale,
        alignment: Alignment.bottomCenter,
        child: const TentangKamiPage(),
      ),
    );
  }

  static navToDaftarPage(BuildContext context) {
    return Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.scale,
        alignment: Alignment.bottomCenter,
        child: const DaftarPage(),
      ),
    );
  }

  static navToSelesaiDaftarPage(BuildContext context, String namaUser) {
    return Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.scale,
        alignment: Alignment.bottomCenter,
        child: SelesaiDaftarPage(namaUser),
      ),
    );
  }

  static navToEditProfilPage(BuildContext context) {
    return Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.scale,
        alignment: Alignment.bottomCenter,
        child: const EditProfilPage(),
      ),
    );
  }

  //   static navToHomePage(BuildContext context) {
  //   Navigator.pushAndRemoveUntil(
  //     context,
  //     PageTransition(
  //       type: PageTransitionType.scale,
  //       alignment: Alignment.bottomCenter,
  //       child: const HomePage(),
  //     ),
  //     (Route<dynamic> route) => false,
  //     // ModalRoute.withName('/'),
  //   );
  // }
}
