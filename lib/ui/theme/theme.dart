import 'package:flutter/material.dart';

class AppConfig {
  static String appName = 'KUBIK';
  static String appVersionName = '1.0.0';
}

// Color
class AppColors {
  static Color mainBlackColor = const Color(0xff212222);
  static Color mainGrayColor = const Color(0xffA4A4A4);
  static Color mainWhiteColor = const Color(0xffFFFFFF);
  static Color mainRedColor = const Color(0xffEE4158);
  static Color mainLightGrayColor = const Color(0xffE9E9E9);
  static Color mainLightRedColor = const Color(0xffFFF3F4);
  static Color redLinear1Color = const Color(0xffEF665E);
  static Color redLinear2Color = const Color(0xffEE3556);
  static Color btnLinear1Color = const Color(0xffE7926F);
  static Color btnLinear2Color = const Color(0xffE07163);
  static Color keyLinear1Color = const Color(0xffFFFFFF);
  static Color keyLinear2Color = const Color(0xffF7F7F7);
}

// Font Name
class AppFontName {
  static const String googleSansRegular = 'GoogleSans_Regular';
  static const String googleSansBold = 'GoogleSans_Bold';
  static const String nunitoBlack = 'Nunito_Black';
  static const String poppinsRegular = 'Poppins_Regular';
  static const String poppinsBold = 'Poppins_Bold';
}

// Text style
class AppTextStyle {
  static final TextStyle regularTextStyle = TextStyle(
    fontFamily: AppFontName.googleSansRegular,
    fontWeight: FontWeight.w400,
    color: AppColors.mainBlackColor,
  );
  static final TextStyle boldTextStyle = TextStyle(
    fontFamily: AppFontName.googleSansBold,
    fontWeight: FontWeight.w700,
    color: AppColors.mainBlackColor,
  );
  static final TextStyle blackTextStyle = TextStyle(
    fontFamily: AppFontName.nunitoBlack,
    fontWeight: FontWeight.w900,
    color: AppColors.mainBlackColor,
  );
  static final TextStyle regularPoppinsTextStyle = TextStyle(
    fontFamily: AppFontName.poppinsRegular,
    fontWeight: FontWeight.w400,
    color: AppColors.mainBlackColor,
  );
  static final TextStyle boldPoppinsTextStyle = TextStyle(
    fontFamily: AppFontName.poppinsBold,
    fontWeight: FontWeight.w700,
    color: AppColors.mainBlackColor,
  );
}

// Padding or Margin
class AppEdgeSize {
  static const double mainEdge = 20;
}