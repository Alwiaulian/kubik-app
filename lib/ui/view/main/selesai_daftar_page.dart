import 'package:flutter/material.dart';
import 'package:kubik/ui/router/router.dart';
import 'package:kubik/ui/theme/theme.dart';

class SelesaiDaftarPage extends StatefulWidget {
  final String namaUser;
  const SelesaiDaftarPage(this.namaUser, {Key? key}) : super(key: key);

  @override
  State<SelesaiDaftarPage> createState() => _SelesaiDaftarPageState();
}

class _SelesaiDaftarPageState extends State<SelesaiDaftarPage> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    double widthContent;
    if (screenSize.width > 600) {
      widthContent = MediaQuery.of(context).size.width * 0.55;
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
                          minHeight: MediaQuery.of(context).size.height,
                          maxWidth: widthContent),
                      padding: const EdgeInsets.only(
                          left: 20, top: 30, right: 20, bottom: 20),
                      child: SingleChildScrollView(
                        child: Center(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 25),
                                child: Image.asset(
                                  'assets/images/atasnya_chat.png',
                                  width: 45,
                                  height: 33,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 30),
                                child: Image.asset(
                                  'assets/images/chat.png',
                                  width: 200,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Text(
                                  'Selamat datang, ${widget.namaUser} Disini!',
                                  style: AppTextStyle.blackTextStyle.copyWith(
                                      color: AppColors.mainBlackColor,
                                      fontSize: 34),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Text(
                                  'Elit vivamus amet felis tincidunt tellus. Vestibulum fermentum vulputate ut sed lectus imperdiet sapien, ',
                                  style: AppTextStyle.regularTextStyle.copyWith(
                                      color: AppColors.mainGrayColor
                                          .withOpacity(.6),
                                      fontSize: 16),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              // const SizedBox(
                              //   width: 10,
                              // ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Container(
                                  height: 50,
                                  width: widthContent * 0.5,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        AppColors.btnLinear2Color,
                                        AppColors.btnLinear1Color
                                      ]),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Future.delayed(const Duration(seconds: 1),
                                          () {
                                        AppRouter.navToLoginPage(context);
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.transparent,
                                        shadowColor: Colors.transparent),
                                    child: const Text('Selesai'),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
