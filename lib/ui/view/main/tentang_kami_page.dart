import 'package:flutter/material.dart';
import 'package:kubik/ui/router/router.dart';
import 'package:kubik/ui/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:kubik/core/provider/tentang_kami_provider.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class TentangKamiPage extends StatefulWidget {
  const TentangKamiPage({Key? key}) : super(key: key);

  @override
  TentangKamiPageState createState() => TentangKamiPageState();
}

class TentangKamiPageState extends State<TentangKamiPage> {
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
      home: ChangeNotifierProvider<TentangKamiProvider>(
        create: (context) => TentangKamiProvider(context),
        child: Consumer<TentangKamiProvider>(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: TextButton(
                                      onPressed: () {
                                        AppRouter.navToDashboardPage(context);
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
                                  child: Column(
                                    children: [
                                      Container(
                                        padding:
                                            const EdgeInsets.only(bottom: 60),
                                        child: Text(
                                          'Tentang Kami',
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
                                                        .tentangKamiModelData
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
