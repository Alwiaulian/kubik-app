import 'package:flutter/material.dart';
import 'package:kubik/ui/router/router.dart';
import 'package:kubik/ui/theme/theme.dart';

class PilihSuaraPage extends StatefulWidget {
  const PilihSuaraPage({Key? key}) : super(key: key);

  @override
  _PilihSuaraPageState createState() => _PilihSuaraPageState();
}

class _PilihSuaraPageState extends State<PilihSuaraPage> {
  bool isChecked = false;
  bool _isObscure = false;

  int _value = 1;

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
      widthContent = MediaQuery.of(context).size.width * 0.6;
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
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(color: AppColors.mainLightRedColor),
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
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.all(4),
                        //   child: TextButton(
                        //     onPressed: () {
                        //       Navigator.of(context).pop();
                        //     },
                        //     child: Icon(
                        //       Icons.arrow_back,
                        //       color: AppColors.mainBlackColor,
                        //     ),
                        //   ),
                        // ),
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
                          minHeight: MediaQuery.of(context).size.height - 80,
                          maxWidth: widthContent),
                      padding: const EdgeInsets.only(
                          left: 20, top: 30, right: 20, bottom: 20),
                      child: Form(
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
                                        padding:
                                            const EdgeInsets.only(bottom: 5),
                                        child: Text(
                                          'Pilih Suara',
                                          style: AppTextStyle.boldTextStyle
                                              .copyWith(fontSize: 34),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Container(
                                        padding:
                                            const EdgeInsets.only(bottom: 50),
                                        child: Text(
                                          'Pilih suara yang kamu inginkan',
                                          style: AppTextStyle.regularTextStyle
                                              .copyWith(
                                                  color: AppColors
                                                      .mainBlackColor
                                                      .withOpacity(0.4),
                                                  fontSize: 12),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              padding: const EdgeInsets.all(15),
                                              decoration: BoxDecoration(
                                                color: AppColors.mainWhiteColor,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: AppColors
                                                        .mainWhiteColor,
                                                  ),
                                                ],
                                              ),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(0),
                                                          child: Image.asset(
                                                            'assets/images/icon_pilihsuara.png',
                                                            width: 20,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'Suara Laki laki',
                                                                style: AppTextStyle
                                                                    .regularTextStyle,
                                                              ),
                                                              const SizedBox(
                                                                height: 4,
                                                              ),
                                                              Text(
                                                                '33,4mb',
                                                                style: AppTextStyle
                                                                    .regularTextStyle
                                                                    .copyWith(
                                                                        color: AppColors
                                                                            .mainGrayColor,
                                                                        fontSize:
                                                                            10),
                                                              ),
                                                            ]),
                                                      ],
                                                    ),
                                                    Radio(
                                                        value: 1,
                                                        groupValue: _value,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            _value = 1;
                                                          });
                                                        }),
                                                  ]),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              width: double.infinity,
                                              padding: const EdgeInsets.all(15),
                                              decoration: BoxDecoration(
                                                color: AppColors.mainWhiteColor,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: AppColors
                                                        .mainWhiteColor,
                                                  ),
                                                ],
                                              ),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(0),
                                                          child: Image.asset(
                                                            'assets/images/icon_pilihsuara.png',
                                                            width: 20,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'Suara Perempuan',
                                                                style: AppTextStyle
                                                                    .regularTextStyle,
                                                              ),
                                                              const SizedBox(
                                                                height: 4,
                                                              ),
                                                              Text(
                                                                '33,4mb',
                                                                style: AppTextStyle
                                                                    .regularTextStyle
                                                                    .copyWith(
                                                                        color: AppColors
                                                                            .mainGrayColor,
                                                                        fontSize:
                                                                            10),
                                                              ),
                                                            ]),
                                                      ],
                                                    ),
                                                    Radio(
                                                        value: 2,
                                                        groupValue: _value,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            _value = 2;
                                                          });
                                                        }),
                                                  ]),
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
                                    borderRadius: BorderRadius.circular(10)),
                                child: ElevatedButton(
                                  onPressed: () {
                                    // AppRouter.navToSyaratKetentuan(context);
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
      ),
    );
  }
}
