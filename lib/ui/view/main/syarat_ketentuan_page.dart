import 'package:flutter/material.dart';
import 'package:kubik/ui/router/router.dart';
import 'package:kubik/ui/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:kubik/core/provider/syarat_ketentuan_provider.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class SyaratKetentuanPage extends StatefulWidget {
  final String namaUser;
  const SyaratKetentuanPage(this.namaUser, {Key? key}) : super(key: key);

  @override
  _SyaratKetentuanPageState createState() => _SyaratKetentuanPageState();
}

class _SyaratKetentuanPageState extends State<SyaratKetentuanPage> {
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
      home: ChangeNotifierProvider<SyaratKetentuanProvider>(
        create: (context) => SyaratKetentuanProvider(context),
        child: Consumer<SyaratKetentuanProvider>(
          builder: (context, provider, _) => (provider.loading == true)
              ? Container()
              : Scaffold(
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
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
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
                                  child: Column(
                                    children: [
                                      Container(
                                        padding:
                                            const EdgeInsets.only(bottom: 60),
                                        child: Text(
                                          'Syarat & Ketentuan',
                                          style: AppTextStyle.boldTextStyle
                                              .copyWith(fontSize: 34),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.all(0),
                                          decoration: BoxDecoration(
                                            color: AppColors.mainWhiteColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: AppColors.mainWhiteColor,
                                              ),
                                            ],
                                          ),
                                          child: SingleChildScrollView(
                                            padding: const EdgeInsets.all(24),
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: double.infinity,
                                                  padding:
                                                      const EdgeInsets.all(0),
                                                  child: HtmlWidget(
                                                    provider
                                                        .syaratKetentuanModelData
                                                        .deskripsi,
                                                    // customStylesBuilder: AppTextStyle.,
                                                    textStyle: AppTextStyle
                                                        .regularTextStyle
                                                        .copyWith(
                                                            color: AppColors
                                                                .mainGrayColor,
                                                            fontSize: 12),
                                                    // 'Dictumst eu sed sagittis tempor, fringilla ultricies. Venenatis, risus enim neque iaculis quam mus. Accumsan blandit tincidunt tristique aenean orci non. Eget purus nibh vel vel orci vel sapien magnis sagittis. Vitae lorem etiam sit tortor augue tellus. Duis quam duis enim sapien felis lacus, massa. Tortor amet dui ac orci. At non amet condimentum faucibus leo tempus quis mattis lacinia. Viverra euismod tristique volutpat risus mi cras. Amet, quisque pellentesque sed ut feugiat ac accumsan..',
                                                    // style: AppTextStyle
                                                    //     .regularTextStyle
                                                    //     .copyWith(
                                                    //         color: AppColors
                                                    //             .mainGrayColor,
                                                    //         fontSize: 12),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 28,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      // padding:
                                                      //     const EdgeInsets.only(top: 10),
                                                      // alignment: Alignment.centerRight,
                                                      child: Container(
                                                        height: 45,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0),
                                                        child: OutlinedButton(
                                                          style: ButtonStyle(
                                                            shape: MaterialStateProperty.all(
                                                                RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.0))),
                                                            side: MaterialStateProperty
                                                                .all(BorderSide(
                                                                    color: AppColors
                                                                        .btnLinear2Color,
                                                                    // width: 2.0,
                                                                    style: BorderStyle
                                                                        .solid)),
                                                          ),
                                                          onPressed: () {
                                                            AppRouter
                                                                .navToHomePage(
                                                                    context);
                                                          },
                                                          child: Text(
                                                            'Tidak Setuju',
                                                            style: AppTextStyle
                                                                .boldTextStyle
                                                                .copyWith(
                                                                    color: AppColors
                                                                        .btnLinear2Color,
                                                                    fontSize:
                                                                        14),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 16,
                                                    ),
                                                    Expanded(
                                                      // padding:
                                                      //     const EdgeInsets.only(top: 10),
                                                      // alignment: Alignment.centerRight,
                                                      child: Container(
                                                        height: 45,
                                                        decoration: BoxDecoration(
                                                            gradient:
                                                                LinearGradient(
                                                                    colors: [
                                                                  AppColors
                                                                      .btnLinear2Color,
                                                                  AppColors
                                                                      .btnLinear1Color
                                                                ]),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            AppRouter
                                                                .navToSelesaiDaftarPage(
                                                                    context,
                                                                    widget
                                                                        .namaUser);
                                                          },
                                                          style: ElevatedButton.styleFrom(
                                                              primary: Colors
                                                                  .transparent,
                                                              shadowColor: Colors
                                                                  .transparent),
                                                          child: const Text(
                                                              'Saya Setuju'),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 18,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 10),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 8),
                                                    child: Text(
                                                      'Dengan memilih SETUJU, Anda telah, membaca, mengerti, memahami, dan setuju dengan syarat dan ketentuan',
                                                      style: AppTextStyle
                                                          .regularTextStyle
                                                          .copyWith(
                                                              color: AppColors
                                                                  .mainRedColor,
                                                              fontSize: 12),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 28,
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
        ),
      ),
    );
  }
}
