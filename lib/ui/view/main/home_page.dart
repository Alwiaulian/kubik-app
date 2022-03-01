import 'package:flutter/material.dart';
import 'package:kubik/ui/router/router.dart';
import 'package:kubik/ui/theme/theme.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  String? isViewPage;

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
      home: Scaffold(
        resizeToAvoidBottomInset: false,
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
              child: SingleChildScrollView(
                child: Center(
                  child: Container(
                    constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height,
                        maxWidth: widthContent),
                    padding: const EdgeInsets.only(
                        left: 20, top: 30, right: 20, bottom: 20),
                    child: Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Image.asset(
                              'assets/images/logo.png',
                              width: 120,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              'Berkomunikasi kini jauh lebih mudah',
                              style: AppTextStyle.blackTextStyle.copyWith(
                                  color: AppColors.mainWhiteColor,
                                  fontSize: 36),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Text(
                              'Elit vivamus amet felis tincidunt tellus. Vestibulum fermentum vulputate ut sed lectus imperdiet sapien fermentum vulputate ut sed lectus,',
                              style: AppTextStyle.regularTextStyle.copyWith(
                                  color:
                                      AppColors.mainWhiteColor.withOpacity(.6),
                                  fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: Image.asset(
                              'assets/images/mention.png',
                              width: 200,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: (isViewPage == 'Tablet')
                                  ? Colors.transparent
                                  : AppColors.mainWhiteColor,
                            ),
                            padding: (isViewPage == 'Tablet')
                                ? const EdgeInsets.all(0)
                                : const EdgeInsets.all(10),
                            width: double.infinity,
                            child: Column(
                              children: [
                                (isViewPage == 'Tablet')
                                    ? Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        spacing: 17,
                                        runSpacing: 17,
                                        children: [
                                          Container(
                                            width: widthTextInput,
                                            padding: const EdgeInsets.all(0),
                                            child: OutlinedButton(
                                              style: ButtonStyle(
                                                shape:
                                                    MaterialStateProperty.all(
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0))),
                                                side: MaterialStateProperty.all(
                                                    BorderSide(
                                                        color: AppColors
                                                            .mainWhiteColor,
                                                        width: 2.0,
                                                        style:
                                                            BorderStyle.solid)),
                                                padding:
                                                    MaterialStateProperty.all(
                                                        const EdgeInsets.all(
                                                            15)),
                                              ),
                                              onPressed: () {
                                                AppRouter.navToLoginPage(
                                                    context);
                                              },
                                              child: Text(
                                                'Sudah punya akun? Login',
                                                style: AppTextStyle
                                                    .blackTextStyle
                                                    .copyWith(
                                                  color:
                                                      AppColors.mainWhiteColor,
                                                  fontSize: 16,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: widthTextInput,
                                            padding: const EdgeInsets.all(0),
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                shape:
                                                    MaterialStateProperty.all(
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0))),
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        AppColors
                                                            .mainWhiteColor),
                                                padding:
                                                    MaterialStateProperty.all(
                                                        const EdgeInsets.only(
                                                            top: 15,
                                                            bottom: 15)),
                                              ),
                                              onPressed: () {
                                                AppRouter.navToDaftarPage(
                                                    context);
                                              },
                                              child: Text(
                                                'Ayo Mulai!',
                                                style: AppTextStyle
                                                    .blackTextStyle
                                                    .copyWith(
                                                        color: AppColors
                                                            .mainRedColor,
                                                        fontSize: 16),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        spacing: 17,
                                        runSpacing: 17,
                                        children: [
                                          Container(
                                            width: widthTextInput,
                                            padding: const EdgeInsets.all(0),
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                shape:
                                                    MaterialStateProperty.all(
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0))),
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        AppColors
                                                            .btnLinear2Color),
                                                padding:
                                                    MaterialStateProperty.all(
                                                        const EdgeInsets.only(
                                                            top: 15,
                                                            bottom: 15)),
                                              ),
                                              onPressed: () {
                                                AppRouter.navToDaftarPage(
                                                    context);
                                              },
                                              child: Text(
                                                'Ayo Mulai!',
                                                style: AppTextStyle
                                                    .blackTextStyle
                                                    .copyWith(
                                                        color: AppColors
                                                            .mainWhiteColor,
                                                        fontSize: 16),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: widthTextInput,
                                            padding: const EdgeInsets.all(0),
                                            child: OutlinedButton(
                                              style: ButtonStyle(
                                                shape:
                                                    MaterialStateProperty.all(
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0))),
                                                side: MaterialStateProperty.all(
                                                    BorderSide(
                                                        color: AppColors
                                                            .btnLinear2Color,
                                                        width: 2.0,
                                                        style:
                                                            BorderStyle.solid)),
                                                padding:
                                                    MaterialStateProperty.all(
                                                        const EdgeInsets.all(
                                                            15)),
                                              ),
                                              onPressed: () {
                                                AppRouter.navToLoginPage(
                                                    context);
                                              },
                                              child: Text(
                                                'Sudah punya akun? Login',
                                                style: AppTextStyle
                                                    .blackTextStyle
                                                    .copyWith(
                                                  color:
                                                      AppColors.btnLinear2Color,
                                                  fontSize: 16,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Wrap(
                                    alignment: WrapAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Text(
                                          'Dengan masuk, kamu meyetujui ',
                                          style: AppTextStyle.regularTextStyle
                                              .copyWith(
                                                  color: (isViewPage ==
                                                          'Tablet')
                                                      ? AppColors.mainWhiteColor
                                                          .withOpacity(.6)
                                                      : AppColors.mainGrayColor
                                                          .withOpacity(.6),
                                                  fontSize: 12),
                                        ),
                                      ),
                                      Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.transparent,
                                        ),
                                        height: 28,
                                        child: TextButton(
                                          style: ButtonStyle(
                                            padding: MaterialStateProperty.all(
                                                EdgeInsets.zero),
                                          ),
                                          onPressed: () {},
                                          child: Text(
                                            'Ketentuan Layanan',
                                            style: AppTextStyle.regularTextStyle
                                                .copyWith(
                                              color: (isViewPage == 'Tablet')
                                                  ? AppColors.mainWhiteColor
                                                      .withOpacity(.6)
                                                  : AppColors.mainGrayColor
                                                      .withOpacity(.6),
                                              fontSize: 12,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Text(
                                          ' dan ',
                                          style: AppTextStyle.regularTextStyle
                                              .copyWith(
                                                  color: (isViewPage ==
                                                          'Tablet')
                                                      ? AppColors.mainWhiteColor
                                                          .withOpacity(.6)
                                                      : AppColors.mainGrayColor
                                                          .withOpacity(.6),
                                                  fontSize: 12),
                                        ),
                                      ),
                                      Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.transparent,
                                        ),
                                        height: 28,
                                        child: TextButton(
                                          style: ButtonStyle(
                                            padding: MaterialStateProperty.all(
                                                EdgeInsets.zero),
                                          ),
                                          onPressed: () {},
                                          child: Text(
                                            'Kebijakan Privasi',
                                            style: AppTextStyle.regularTextStyle
                                                .copyWith(
                                              color: (isViewPage == 'Tablet')
                                                  ? AppColors.mainWhiteColor
                                                      .withOpacity(.6)
                                                  : AppColors.mainGrayColor
                                                      .withOpacity(.6),
                                              fontSize: 12,
                                              decoration:
                                                  TextDecoration.underline,
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
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
