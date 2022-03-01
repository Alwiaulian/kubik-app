import 'package:flutter/material.dart';
import 'package:kubik/core/provider/login_provider.dart';
import 'package:kubik/ui/router/router.dart';
import 'package:kubik/ui/theme/theme.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isChecked = true;
  bool _isObscure = false;
  String? username;
  String? password;

  @override
  void initState() {
    _isObscure = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    double widthContent;
    if (screenSize.width > 600) {
      widthContent = MediaQuery.of(context).size.width * 0.4;
    } else {
      widthContent = MediaQuery.of(context).size.width;
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        primaryColor: AppColors.mainRedColor,
        fontFamily: AppFontName.poppinsRegular,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChangeNotifierProvider<LoginProvider>(
        create: (context) => LoginProvider(context),
        child: Consumer<LoginProvider>(
          builder: (context, provider, _) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              body: Stack(
                children: [
                  Container(
                    decoration:
                        BoxDecoration(color: AppColors.mainLightRedColor),
                  ),
                  Positioned.fill(
                    child: Column(
                      children: [
                        Container(
                          height: 85,
                          padding: const EdgeInsets.only(
                              left: 10, top: 36, right: 10, bottom: 9),
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                padding: const EdgeInsets.all(0),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.all(0),
                                  ),
                                  onPressed: () {
                                    AppRouter.navToHomePage(context);
                                  },
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: AppColors.mainBlackColor,
                                    size: 20,
                                  ),
                                ),
                              ),
                              Container(
                                width: 40,
                                height: 40,
                                padding: const EdgeInsets.all(0),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.all(0),
                                  ),
                                  onPressed: () {},
                                  child: Icon(
                                    Icons.help_outline,
                                    color: AppColors.mainBlackColor,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: Column(
                                children: [
                                  Container(
                                    constraints: BoxConstraints(
                                        minHeight:
                                            MediaQuery.of(context).size.height -
                                                85,
                                        maxWidth: widthContent),
                                    padding: const EdgeInsets.only(
                                        left: 20,
                                        top: 0,
                                        right: 20,
                                        bottom: 20),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding:
                                              const EdgeInsets.only(bottom: 2),
                                          child: Text(
                                            'Login',
                                            style: AppTextStyle.blackTextStyle
                                                .copyWith(fontSize: 34),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Container(
                                          padding:
                                              const EdgeInsets.only(bottom: 59),
                                          child: Text(
                                            'Masukan nama user dan password kamu',
                                            style: AppTextStyle.regularTextStyle
                                                .copyWith(
                                                    color: AppColors
                                                        .mainBlackColor
                                                        .withOpacity(0.4),
                                                    fontSize: 14),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(0),
                                          child: Form(
                                            key: provider.formKey,
                                            child: Column(
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 19),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Nama user',
                                                        style: AppTextStyle
                                                            .boldTextStyle
                                                            .copyWith(
                                                                color: AppColors
                                                                    .mainBlackColor
                                                                    .withOpacity(
                                                                        0.4),
                                                                fontSize: 11),
                                                      ),
                                                      const SizedBox(
                                                        height: 6,
                                                      ),
                                                      TextFormField(
                                                        controller: provider
                                                            .usernameController,
                                                        initialValue: username,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              'Masukan nama user',
                                                          hintStyle: AppTextStyle
                                                              .regularTextStyle
                                                              .copyWith(
                                                            color: AppColors
                                                                .mainBlackColor
                                                                .withOpacity(
                                                                    0.4),
                                                            fontSize: 14,
                                                          ),
                                                          filled: true,
                                                          fillColor: AppColors
                                                              .mainWhiteColor,
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            borderSide:
                                                                BorderSide.none,
                                                          ),
                                                        ),
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            return 'Silahkan input nama user';
                                                          }
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 26),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Password',
                                                        style: AppTextStyle
                                                            .boldTextStyle
                                                            .copyWith(
                                                                color: AppColors
                                                                    .mainBlackColor
                                                                    .withOpacity(
                                                                        0.4),
                                                                fontSize: 11),
                                                      ),
                                                      const SizedBox(
                                                        height: 6,
                                                      ),
                                                      TextFormField(
                                                        keyboardType:
                                                            TextInputType
                                                                .visiblePassword,
                                                        controller: provider
                                                            .passwordController,
                                                        initialValue: password,
                                                        obscureText:
                                                            !_isObscure,
                                                        decoration:
                                                            InputDecoration(
                                                          suffixIcon:
                                                              IconButton(
                                                                  icon: Icon(_isObscure
                                                                      ? Icons
                                                                          .visibility_outlined
                                                                      : Icons
                                                                          .visibility_off_outlined),
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      _isObscure =
                                                                          !_isObscure;
                                                                    });
                                                                  }),
                                                          hintText:
                                                              'Masukan password',
                                                          hintStyle: AppTextStyle
                                                              .regularTextStyle
                                                              .copyWith(
                                                            color: AppColors
                                                                .mainBlackColor
                                                                .withOpacity(
                                                                    0.4),
                                                            fontSize: 14,
                                                          ),
                                                          filled: true,
                                                          fillColor: AppColors
                                                              .mainWhiteColor,
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            borderSide:
                                                                BorderSide.none,
                                                          ),
                                                        ),
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            return 'Silahkan input kata sandi';
                                                          }
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                          colors: [
                                                            AppColors
                                                                .btnLinear2Color,
                                                            AppColors
                                                                .btnLinear1Color
                                                          ]),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      provider.login(isChecked);
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            primary: Colors
                                                                .transparent,
                                                            shadowColor: Colors
                                                                .transparent),
                                                    child: Text('Masuk',
                                                        style: AppTextStyle
                                                            .blackTextStyle
                                                            .copyWith(
                                                                color: AppColors
                                                                    .mainWhiteColor,
                                                                fontSize: 16)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
