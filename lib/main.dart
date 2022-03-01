import 'dart:convert';

import 'package:flutter/material.dart';

import 'core/flutter_no_sql.dart';
import 'core/sql_no_key.dart';
import 'model/login_model.dart';
import 'ui/router/router.dart';
import 'ui/theme/theme.dart';

void main() {
  runApp(const MyApp());
  Future.delayed(const Duration(seconds: 0), () async {
    WidgetsFlutterBinding.ensureInitialized();
    await FlutterNoSql.initFlutter();
    WidgetsFlutterBinding.ensureInitialized();
    // await checkToken();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        primaryColor: AppColors.mainRedColor,
        fontFamily: AppFontName.poppinsRegular,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      title: AppConfig.appName,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      next();
    });
  }

  late LoginModel loginModel;

  void next() async {
    String? loginToken = FlutterNoSql.getToken();
    print('Token : $loginToken');

    Future.delayed(const Duration(seconds: 0)).then(
      (value) async {
        if (loginToken == null) {
          AppRouter.navToHomePage(context);
        } else {
          await getLoginData();
          AppRouter.navToDashboardPage(context);
        }
      },
    );
  }

  getLoginData() async {
    loginModel = LoginModel.fromJson(
      json.decode(FlutterNoSql.getJsonString(key: NoSqlKey.loginApiKey)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  AppColors.redLinear2Color,
                  AppColors.redLinear1Color,
                ],
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover,
                alignment: Alignment.topLeft,
              ),
            ),
          ),
          Positioned.fill(
            child: Center(
              child: Image.asset(
                'assets/images/logo.png',
                width: 150,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
