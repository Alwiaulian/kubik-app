import 'package:flutter/material.dart';
import 'package:kubik/ui/router/router.dart';
import 'package:kubik/ui/theme/theme.dart';
import 'package:kubik/core/provider/daftar_provider.dart';
import 'package:provider/provider.dart';

class DaftarPage extends StatefulWidget {
  const DaftarPage({Key? key}) : super(key: key);

  @override
  _DaftarPageState createState() => _DaftarPageState();
}

class _DaftarPageState extends State<DaftarPage> {
  bool _isObscure = false;
  bool _isObscurecfm = false;
  String? namaUser;
  String? email;
  String? password;
  String? konfirmasiPassword;
  String? namaOrangtua;
  String? namaAnak;

  String? isViewPage;
  // String slug;
  // String updatedAt;
  // String createdAt;
  // int id;

  @override
  void initState() {
    _isObscure = false;
    _isObscurecfm = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    double widthContent;
    double widthTextInput;
    if (screenSize.width > 600) {
      widthContent = MediaQuery.of(context).size.width * 0.6;
      widthTextInput = widthContent * 0.5 - 30;
      isViewPage = 'Tablet';
    } else {
      widthContent = MediaQuery.of(context).size.width;
      widthTextInput = widthContent;
      isViewPage = 'Mobile';
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        primaryColor: AppColors.mainRedColor,
        fontFamily: AppFontName.poppinsRegular,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChangeNotifierProvider<DaftarProvider>(
        create: (context) => DaftarProvider(context),
        child: Consumer<DaftarProvider>(
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
                          height: 80,
                          padding: const EdgeInsets.only(
                              left: 0, top: 30, right: 0, bottom: 0),
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                  },
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: AppColors.mainBlackColor,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4),
                                child: TextButton(
                                  onPressed: () {},
                                  child: Icon(
                                    Icons.help_outline,
                                    color: AppColors.mainBlackColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            constraints: BoxConstraints(
                                minHeight:
                                    MediaQuery.of(context).size.height - 80,
                                maxWidth: widthContent),
                            padding: const EdgeInsets.only(
                                left: 20, top: 30, right: 20, bottom: 20),
                            child: Form(
                              key: provider.formKey,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom),
                                        child: Column(
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              padding: const EdgeInsets.only(
                                                  bottom: 5),
                                              child: Text(
                                                'Buat User',
                                                style: AppTextStyle
                                                    .boldTextStyle
                                                    .copyWith(fontSize: 34),
                                                textAlign:
                                                    (isViewPage == 'Mobile')
                                                        ? TextAlign.left
                                                        : TextAlign.center,
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              padding: const EdgeInsets.only(
                                                  bottom: 50),
                                              child: Text(
                                                'Isi biodata dibawah ini untuk membuat user',
                                                style: AppTextStyle
                                                    .regularTextStyle
                                                    .copyWith(
                                                        color: AppColors
                                                            .mainBlackColor
                                                            .withOpacity(0.4),
                                                        fontSize: 12),
                                                textAlign:
                                                    (isViewPage == 'Mobile')
                                                        ? TextAlign.left
                                                        : TextAlign.center,
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 8),
                                                    child: Text(
                                                      'Info login',
                                                      style: AppTextStyle
                                                          .boldTextStyle
                                                          .copyWith(
                                                              color: AppColors
                                                                  .mainRedColor
                                                                  .withOpacity(
                                                                      0.4),
                                                              fontSize: 12),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 8),
                                                    padding:
                                                        const EdgeInsets.all(0),
                                                    width: double.infinity,
                                                    child: Wrap(
                                                      spacing: 17,
                                                      runSpacing: 17,
                                                      children: [
                                                        Container(
                                                          width: widthTextInput,
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 20),
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
                                                                        fontSize:
                                                                            11),
                                                              ),
                                                              const SizedBox(
                                                                height: 6,
                                                              ),
                                                              TextFormField(
                                                                controller: provider
                                                                    .namauserController,
                                                                initialValue:
                                                                    namaUser,
                                                                decoration:
                                                                    InputDecoration(
                                                                  hintText:
                                                                      'Masukan nama user',
                                                                  hintStyle: AppTextStyle.regularTextStyle.copyWith(
                                                                      color: AppColors
                                                                          .mainBlackColor
                                                                          .withOpacity(
                                                                              0.4),
                                                                      fontSize:
                                                                          14),
                                                                  filled: true,
                                                                  fillColor:
                                                                      AppColors
                                                                          .mainWhiteColor,
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    borderSide:
                                                                        BorderSide
                                                                            .none,
                                                                  ),
                                                                ),
                                                                validator:
                                                                    (value) {
                                                                  if (value!
                                                                      .isEmpty) {
                                                                    return 'Silahkan input nama user';
                                                                  }
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          width: widthTextInput,
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 20),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'Email',
                                                                style: AppTextStyle
                                                                    .boldTextStyle
                                                                    .copyWith(
                                                                        color: AppColors
                                                                            .mainBlackColor
                                                                            .withOpacity(
                                                                                0.4),
                                                                        fontSize:
                                                                            11),
                                                              ),
                                                              const SizedBox(
                                                                height: 6,
                                                              ),
                                                              TextFormField(
                                                                controller: provider
                                                                    .emailController,
                                                                initialValue:
                                                                    email,
                                                                decoration:
                                                                    InputDecoration(
                                                                  hintText:
                                                                      'Masukan alamat email',
                                                                  hintStyle: AppTextStyle.regularTextStyle.copyWith(
                                                                      color: AppColors
                                                                          .mainBlackColor
                                                                          .withOpacity(
                                                                              0.4),
                                                                      fontSize:
                                                                          14),
                                                                  filled: true,
                                                                  fillColor:
                                                                      AppColors
                                                                          .mainWhiteColor,
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    borderSide:
                                                                        BorderSide
                                                                            .none,
                                                                  ),
                                                                ),
                                                                validator:
                                                                    (value) {
                                                                  if (value!
                                                                      .isEmpty) {
                                                                    return 'Silahkan input nama email';
                                                                  }
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 8),
                                                    padding:
                                                        const EdgeInsets.all(0),
                                                    width: double.infinity,
                                                    child: Wrap(
                                                      spacing: 17,
                                                      runSpacing: 17,
                                                      children: [
                                                        Container(
                                                          width: widthTextInput,
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 20),
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
                                                                        fontSize:
                                                                            11),
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
                                                                initialValue:
                                                                    password,
                                                                obscureText:
                                                                    !_isObscure,
                                                                decoration:
                                                                    InputDecoration(
                                                                  suffixIcon:
                                                                      IconButton(
                                                                          icon: Icon(_isObscure
                                                                              ? Icons.visibility_outlined
                                                                              : Icons.visibility_off_outlined),
                                                                          onPressed: () {
                                                                            setState(() {
                                                                              _isObscure = !_isObscure;
                                                                            });
                                                                          }),
                                                                  hintText:
                                                                      'Masukan password',
                                                                  hintStyle: AppTextStyle.regularTextStyle.copyWith(
                                                                      color: AppColors
                                                                          .mainBlackColor
                                                                          .withOpacity(
                                                                              0.4),
                                                                      fontSize:
                                                                          14),
                                                                  filled: true,
                                                                  fillColor:
                                                                      AppColors
                                                                          .mainWhiteColor,
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    borderSide:
                                                                        BorderSide
                                                                            .none,
                                                                  ),
                                                                ),
                                                                validator:
                                                                    (value) {
                                                                  if (value!
                                                                      .isEmpty) {
                                                                    return 'Silahkan input password';
                                                                  }
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          width: widthTextInput,
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 20),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'Ulangi Password',
                                                                style: AppTextStyle
                                                                    .boldTextStyle
                                                                    .copyWith(
                                                                        color: AppColors
                                                                            .mainBlackColor
                                                                            .withOpacity(
                                                                                0.4),
                                                                        fontSize:
                                                                            11),
                                                              ),
                                                              const SizedBox(
                                                                height: 6,
                                                              ),
                                                              TextFormField(
                                                                keyboardType:
                                                                    TextInputType
                                                                        .visiblePassword,
                                                                controller: provider
                                                                    .konfirmasipasswordController,
                                                                initialValue:
                                                                    konfirmasiPassword,
                                                                obscureText:
                                                                    !_isObscurecfm,
                                                                decoration:
                                                                    InputDecoration(
                                                                  suffixIcon:
                                                                      IconButton(
                                                                          icon: Icon(_isObscurecfm
                                                                              ? Icons.visibility_outlined
                                                                              : Icons.visibility_off_outlined),
                                                                          onPressed: () {
                                                                            setState(() {
                                                                              _isObscurecfm = !_isObscurecfm;
                                                                            });
                                                                          }),
                                                                  hintText:
                                                                      'Masukan konfirmasi password',
                                                                  hintStyle: AppTextStyle.regularTextStyle.copyWith(
                                                                      color: AppColors
                                                                          .mainBlackColor
                                                                          .withOpacity(
                                                                              0.4),
                                                                      fontSize:
                                                                          14),
                                                                  filled: true,
                                                                  fillColor:
                                                                      AppColors
                                                                          .mainWhiteColor,
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    borderSide:
                                                                        BorderSide
                                                                            .none,
                                                                  ),
                                                                ),
                                                                validator:
                                                                    (value) {
                                                                  if (value!
                                                                      .isEmpty) {
                                                                    return 'Silahkan input konfirmasi password';
                                                                  }
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 8),
                                                    child: Text(
                                                      'Biodata diri',
                                                      style: AppTextStyle
                                                          .boldTextStyle
                                                          .copyWith(
                                                              color: AppColors
                                                                  .mainRedColor
                                                                  .withOpacity(
                                                                      0.4),
                                                              fontSize: 12),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 8),
                                                    padding:
                                                        const EdgeInsets.all(0),
                                                    width: double.infinity,
                                                    child: Wrap(
                                                      spacing: 17,
                                                      runSpacing: 17,
                                                      children: [
                                                        Container(
                                                          width: widthTextInput,
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 20),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'Nama Orang Tua',
                                                                style: AppTextStyle
                                                                    .boldTextStyle
                                                                    .copyWith(
                                                                        color: AppColors
                                                                            .mainBlackColor
                                                                            .withOpacity(
                                                                                0.4),
                                                                        fontSize:
                                                                            11),
                                                              ),
                                                              const SizedBox(
                                                                height: 6,
                                                              ),
                                                              TextFormField(
                                                                controller: provider
                                                                    .namaorangtuaController,
                                                                initialValue:
                                                                    namaOrangtua,
                                                                decoration:
                                                                    InputDecoration(
                                                                  hintText:
                                                                      'Masukan nama orang tua',
                                                                  hintStyle: AppTextStyle.regularTextStyle.copyWith(
                                                                      color: AppColors
                                                                          .mainBlackColor
                                                                          .withOpacity(
                                                                              0.4),
                                                                      fontSize:
                                                                          14),
                                                                  filled: true,
                                                                  fillColor:
                                                                      AppColors
                                                                          .mainWhiteColor,
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    borderSide:
                                                                        BorderSide
                                                                            .none,
                                                                  ),
                                                                ),
                                                                validator:
                                                                    (value) {
                                                                  if (value!
                                                                      .isEmpty) {
                                                                    return 'Silahkan input nama orang tua';
                                                                  }
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 20),
                                                          width: widthTextInput,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'Nama Anak',
                                                                style: AppTextStyle
                                                                    .boldTextStyle
                                                                    .copyWith(
                                                                        color: AppColors
                                                                            .mainBlackColor
                                                                            .withOpacity(
                                                                                0.4),
                                                                        fontSize:
                                                                            11),
                                                              ),
                                                              const SizedBox(
                                                                height: 6,
                                                              ),
                                                              TextFormField(
                                                                controller: provider
                                                                    .namaanakController,
                                                                initialValue:
                                                                    namaAnak,
                                                                decoration:
                                                                    InputDecoration(
                                                                  hintText:
                                                                      'Masukan nama anak',
                                                                  hintStyle: AppTextStyle.regularTextStyle.copyWith(
                                                                      color: AppColors
                                                                          .mainBlackColor
                                                                          .withOpacity(
                                                                              0.4),
                                                                      fontSize:
                                                                          14),
                                                                  filled: true,
                                                                  fillColor:
                                                                      AppColors
                                                                          .mainWhiteColor,
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    borderSide:
                                                                        BorderSide
                                                                            .none,
                                                                  ),
                                                                ),
                                                                validator:
                                                                    (value) {
                                                                  if (value!
                                                                      .isEmpty) {
                                                                    return 'Silahkan input nama anak';
                                                                  }
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
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
                                  Container(
                                    padding: const EdgeInsets.only(top: 10),
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      height: 45,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(colors: [
                                            AppColors.btnLinear2Color,
                                            AppColors.btnLinear1Color
                                          ]),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          provider.daftar();
                                          // AppRouter.navToPilihSuaraPage(
                                          //     context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.transparent,
                                            shadowColor: Colors.transparent),
                                        child: const Icon(Icons.arrow_forward),
                                      ),
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
