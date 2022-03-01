import 'dart:io';
import 'package:accordion/accordion.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:kubik/core/provider/dashboard_provider.dart';
import 'package:kubik/ui/router/router.dart';
import 'package:kubik/ui/theme/theme.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

enum TtsState { playing, stopped, paused, continued }

class _DashboardPageState extends State<DashboardPage> {
  Future<void> _signOut(DashboardProvider provider) async {
    provider.logout();
  }

  bool isVisibleBicaraCepat = true;
  bool isVisibleFrase = true;

  late FlutterTts flutterTts;
  String? language = "id-ID";
  String? engine;
  double volume = 0.5;
  double pitch = 1.0;
  double rate = 0.5;
  bool isCurrentLanguageInstalled = false;

  TextEditingController voiceTextController = TextEditingController();

  String? _newVoiceText;
  int? _inputLength;

  TtsState ttsState = TtsState.stopped;
  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;
  get isPaused => ttsState == TtsState.paused;
  get isContinued => ttsState == TtsState.continued;

  bool get isIOS => !kIsWeb && Platform.isIOS;
  bool get isAndroid => !kIsWeb && Platform.isAndroid;
  bool get isWeb => kIsWeb;

  @override
  initState() {
    super.initState();
    initTts();
  }

  initTts() {
    flutterTts = FlutterTts();

    _setAwaitOptions();

    _getDefaultLanguage();

    if (isAndroid) {
      _getDefaultEngine();
    }

    flutterTts.setStartHandler(() {
      setState(() {
        print("Playing");
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        print("Complete");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setCancelHandler(() {
      setState(() {
        print("Cancel");
        ttsState = TtsState.stopped;
      });
    });

    if (isWeb || isIOS) {
      flutterTts.setPauseHandler(() {
        setState(() {
          print("Paused");
          ttsState = TtsState.paused;
        });
      });

      flutterTts.setContinueHandler(() {
        setState(() {
          print("Continued");
          ttsState = TtsState.continued;
        });
      });
    }

    flutterTts.setErrorHandler((msg) {
      setState(() {
        print("error: $msg");
        ttsState = TtsState.stopped;
      });
    });
  }

  // Future<dynamic> _getLanguages() => flutterTts.getLanguages;

  // Future<dynamic> _getEngines() => flutterTts.getEngines;

  void _getDefaultLanguage() {
    setState(() {
      flutterTts.setLanguage(language!);
      if (isAndroid) {
        flutterTts
            .isLanguageInstalled(language!)
            .then((value) => isCurrentLanguageInstalled = (value as bool));
      }
    });
  }

  Future _getDefaultEngine() async {
    var engine = await flutterTts.getDefaultEngine;
    if (engine != null) {
      print(engine);
    }
  }

  Future _speak() async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    if (_newVoiceText != null) {
      if (_newVoiceText!.isNotEmpty) {
        await flutterTts.speak(_newVoiceText!);
      }
    }
  }

  Future _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }

  Future _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  Future _pause() async {
    var result = await flutterTts.pause();
    if (result == 1) setState(() => ttsState = TtsState.paused);
  }

  Future _clear() async {
    _stop();
    _newVoiceText = '';
    voiceTextController.text = '';
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

  void _onChange(String text) {
    setState(() {
      _newVoiceText = text;
    });
  }

  // List<DropdownMenuItem<String>> getEnginesDropDownMenuItems(dynamic engines) {
  //   var items = <DropdownMenuItem<String>>[];
  //   for (dynamic type in engines) {
  //     items.add(DropdownMenuItem(
  //         value: type as String?, child: Text(type as String)));
  //   }
  //   return items;
  // }

  // void changedEnginesDropDownItem(String? selectedEngine) {
  //   flutterTts.setEngine(selectedEngine!);
  //   language = null;
  //   setState(() {
  //     engine = selectedEngine;
  //   });
  // }

  // List<DropdownMenuItem<String>> getLanguageDropDownMenuItems(
  //     dynamic languages) {
  //   var items = <DropdownMenuItem<String>>[];
  //   for (dynamic type in languages) {
  //     items.add(DropdownMenuItem(
  //         value: type as String?, child: Text(type as String)));
  //   }
  //   return items;
  // }

  // void changedLanguageDropDownItem(String? selectedType) {
  //   setState(() {
  //     language = selectedType;
  //     flutterTts.setLanguage(language!);
  //     if (isAndroid) {
  //       flutterTts
  //           .isLanguageInstalled(language!)
  //           .then((value) => isCurrentLanguageInstalled = (value as bool));
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    double widthContent;
    double widthSidebar;
    if (screenSize.width > 600) {
      widthContent = MediaQuery.of(context).size.width * 0.44;
      widthSidebar = MediaQuery.of(context).size.width * 0.28;
    } else {
      widthContent = MediaQuery.of(context).size.width;
      widthSidebar = MediaQuery.of(context).size.width * 0;
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        primaryColor: AppColors.mainRedColor,
        fontFamily: AppFontName.poppinsRegular,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChangeNotifierProvider<DashboardProvider>(
        create: (context) => DashboardProvider(context),
        child: Consumer<DashboardProvider>(
          builder: (context, provider, _) => (provider.loading == true)
              ? Container()
              : Scaffold(
                  resizeToAvoidBottomInset: false,
                  body: SafeArea(
                    child: Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height,
                          width: widthSidebar,
                          padding: const EdgeInsets.only(
                              left: 24, top: 18, right: 24, bottom: 18),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    'assets/images/icon_sidebar_left.png',
                                    width: 25,
                                  ),
                                  // Container(
                                  //   width: 30,
                                  //   height: 22,
                                  //   padding: const EdgeInsets.all(0),
                                  //   child: TextButton(
                                  //     style: TextButton.styleFrom(
                                  //       padding: const EdgeInsets.all(0),
                                  //     ),
                                  //     onPressed: () {},
                                  //     child: Text(
                                  //       'Edit',
                                  //       style: AppTextStyle.regularTextStyle
                                  //           .copyWith(
                                  //         color: AppColors.mainRedColor,
                                  //         fontSize: 17,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              Expanded(
                                // padding: const EdgeInsets.all(0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          padding: const EdgeInsets.all(0),
                                        ),
                                        onPressed: () {
                                          if (isVisibleFrase == false) {
                                            isVisibleFrase = true;
                                          } else {
                                            isVisibleFrase = false;
                                          }
                                          setState(() {});
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Frase',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: AppTextStyle
                                                    .blackTextStyle
                                                    .copyWith(
                                                        color: AppColors
                                                            .mainRedColor,
                                                        fontSize: 34),
                                              ),
                                            ),
                                            Icon(
                                              (isVisibleFrase)
                                                  ? Icons
                                                      .keyboard_arrow_up_rounded
                                                  : Icons
                                                      .keyboard_arrow_down_rounded,
                                              size: 22,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Visibility(
                                        visible: isVisibleFrase,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: AppColors.mainRedColor
                                                .withOpacity(0.07),
                                            borderRadius:
                                                BorderRadius.circular(13),
                                          ),
                                          margin: const EdgeInsets.only(top: 14),
                                          padding: const EdgeInsets.only(
                                              left: 16,
                                              top: 11,
                                              right: 16,
                                              bottom: 11),
                                          child: Column(
                                            children: [
                                              for (var dataKategori
                                                  in provider.fraseModelData)
                                                Container(
                                                  padding: const EdgeInsets.only(
                                                      top: 5, bottom: 5),
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                      bottom: BorderSide(
                                                          color: AppColors
                                                              .mainRedColor
                                                              .withOpacity(0.1),
                                                          width: 1.0,
                                                          style:
                                                              BorderStyle.solid),
                                                    ),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      TextButton(
                                                        style: TextButton.styleFrom(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(0)),
                                                        onPressed: () {
                                                          if (provider.arrayKategoriFrase[dataKategori.namaKategori] == false) {
                                                            provider.arrayKategoriFrase.updateAll((key, value) => false);
                                                            provider.arrayKategoriFrase[dataKategori.namaKategori] = true;  
                                                          } else {
                                                            provider.arrayKategoriFrase.updateAll((key, value) => false);
                                                          }
                                                          setState(() {});
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                dataKategori
                                                                    .namaKategori
                                                                    .toString(),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 2,
                                                                style: AppTextStyle
                                                                    .boldTextStyle
                                                                    .copyWith(
                                                                        color: AppColors
                                                                            .mainRedColor,
                                                                        fontSize:
                                                                            16),
                                                              ),
                                                            ),
                                                            const Icon(
                                                              Icons
                                                                  .keyboard_arrow_right_rounded,
                                                              size: 16,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Visibility(
                                                        visible: (provider.arrayKategoriFrase[dataKategori.namaKategori] != null) ? provider.arrayKategoriFrase[dataKategori.namaKategori] : false,
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            color: AppColors
                                                                .mainRedColor
                                                                .withOpacity(0.1),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(13),
                                                          ),
                                                          padding:
                                                              const EdgeInsets.only(
                                                            left: 8,
                                                            right: 8,
                                                          ),
                                                          child: Column(
                                                            children: [
                                                              for (var dataDetailFrase
                                                                  in dataKategori
                                                                      .data!
                                                                      .toList())
                                                                Container(
                                                                  width: double
                                                                      .infinity,
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(0),
                                                                  child: TextButton(
                                                                    style: TextButton.styleFrom(
                                                                        padding:
                                                                            const EdgeInsets.all(
                                                                                0),
                                                                        alignment:
                                                                            Alignment
                                                                                .centerLeft),
                                                                    onPressed: () {
                                                                      setState(() {
                                                                        String?
                                                                            currentVoiceText =
                                                                            _newVoiceText;
                                                                        if (currentVoiceText !=
                                                                                '' &&
                                                                            currentVoiceText !=
                                                                                null) {
                                                                          currentVoiceText = currentVoiceText +
                                                                              ' ' +
                                                                              dataDetailFrase
                                                                                  .kalimat
                                                                                  .toLowerCase();
                                                                        } else {
                                                                          currentVoiceText = dataDetailFrase
                                                                              .kalimat
                                                                              .toLowerCase();
                                                                        }
                                                                                            
                                                                        _newVoiceText =
                                                                            currentVoiceText;
                                                                        voiceTextController
                                                                                .text =
                                                                            currentVoiceText;
                                                                        voiceTextController
                                                                                .selection =
                                                                            TextSelection.collapsed(
                                                                                offset:
                                                                                    currentVoiceText.length);
                                                                      });
                                                                    },
                                                                    child: Text(
                                                                      dataDetailFrase
                                                                          .namaSubKategori
                                                                          .toString(),
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      maxLines: 2,
                                                                      style: AppTextStyle
                                                                          .boldTextStyle
                                                                          .copyWith(
                                                                              color: AppColors
                                                                                  .mainRedColor,
                                                                              fontSize:
                                                                                  14),
                                                                    ),
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
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: widthContent,
                          padding: const EdgeInsets.all(0),
                          child: Stack(
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
                                    image: AssetImage(
                                        "assets/images/background.png"),
                                    fit: BoxFit.cover,
                                    alignment: Alignment.topLeft,
                                  ),
                                ),
                              ),
                              Positioned.fill(
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(0),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 50,
                                                  height: 50,
                                                  padding:
                                                      const EdgeInsets.all(0),
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary: AppColors
                                                          .mainWhiteColor,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0),
                                                    ),
                                                    onPressed: () {},
                                                    child: Icon(
                                                      Icons
                                                          .zoom_out_map_outlined,
                                                      color: AppColors
                                                          .mainRedColor,
                                                      size: 22,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                Container(
                                                  width: 50,
                                                  height: 50,
                                                  padding:
                                                      const EdgeInsets.all(0),
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary: AppColors
                                                          .mainWhiteColor,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0),
                                                    ),
                                                    onPressed: () {},
                                                    child: Icon(
                                                      Icons.share_outlined,
                                                      color: AppColors
                                                          .mainRedColor,
                                                      size: 24,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 50,
                                            height: 50,
                                            padding: const EdgeInsets.all(0),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary:
                                                    AppColors.mainWhiteColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(0),
                                              ),
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .all(0),
                                                        content: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppColors
                                                                .mainLightRedColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                width: 40,
                                                                height: 40,
                                                                margin:
                                                                    const EdgeInsets
                                                                        .all(10),
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(0),
                                                                child:
                                                                    TextButton(
                                                                  style: TextButton
                                                                      .styleFrom(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(0),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: Icon(
                                                                    Icons
                                                                        .arrow_back,
                                                                    color: AppColors
                                                                        .mainBlackColor,
                                                                    size: 20,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child:
                                                                    SingleChildScrollView(
                                                                  child:
                                                                      Container(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .only(
                                                                      left: 18,
                                                                      top: 10,
                                                                      right: 18,
                                                                      bottom:
                                                                          10,
                                                                    ),
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: <
                                                                          Widget>[
                                                                        Container(
                                                                          padding:
                                                                              const EdgeInsets.all(0),
                                                                          child:
                                                                              Text(
                                                                            'Settings',
                                                                            style:
                                                                                AppTextStyle.boldTextStyle.copyWith(fontSize: 30),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              25,
                                                                        ),
                                                                        Container(
                                                                          padding:
                                                                              const EdgeInsets.all(12),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                AppColors.mainWhiteColor,
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                          ),
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Image.asset(
                                                                                'assets/images/icon_user.png',
                                                                                height: 34,
                                                                                width: 34,
                                                                              ),
                                                                              const SizedBox(
                                                                                width: 8,
                                                                              ),
                                                                              Expanded(
                                                                                child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Text(
                                                                                      provider.loginModel.data.username,
                                                                                      // 'Amanda',
                                                                                      style: AppTextStyle.boldTextStyle.copyWith(fontSize: 14),
                                                                                    ),
                                                                                    const SizedBox(
                                                                                      height: 1,
                                                                                    ),
                                                                                    Text(
                                                                                      provider.loginModel.data.email,
                                                                                      style: AppTextStyle.regularTextStyle.copyWith(
                                                                                        fontSize: 11,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              const SizedBox(
                                                                                width: 8,
                                                                              ),
                                                                              Container(
                                                                                height: 30,
                                                                                width: 30,
                                                                                padding: const EdgeInsets.all(0),
                                                                                child: TextButton(
                                                                                  style: TextButton.styleFrom(
                                                                                    padding: const EdgeInsets.all(0),
                                                                                  ),
                                                                                  onPressed: () {
                                                                                    Navigator.of(context).pop();
                                                                                    AppRouter.navToEditProfilPage(context);
                                                                                  },
                                                                                  child: Image.asset(
                                                                                    'assets/images/icon_edit.png',
                                                                                    height: 20,
                                                                                    width: 20,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              25,
                                                                        ),
                                                                        Container(
                                                                          padding:
                                                                              const EdgeInsets.all(0),
                                                                          child:
                                                                              Text(
                                                                            'Pengaturan user',
                                                                            style:
                                                                                AppTextStyle.boldTextStyle.copyWith(
                                                                              color: AppColors.mainRedColor.withOpacity(.6),
                                                                              fontSize: 12,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        Container(
                                                                          padding:
                                                                              const EdgeInsets.all(12),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                AppColors.mainWhiteColor,
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                          ),
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              TextButton(
                                                                                style: TextButton.styleFrom(
                                                                                    padding: const EdgeInsets.all(0),
                                                                                    shape: RoundedRectangleBorder(
                                                                                      borderRadius: BorderRadius.circular(12),
                                                                                    )),
                                                                                onPressed: () {},
                                                                                child: Row(
                                                                                  children: [
                                                                                    Image.asset(
                                                                                      'assets/images/icon_tampilan.png',
                                                                                      height: 30,
                                                                                      width: 30,
                                                                                    ),
                                                                                    const SizedBox(
                                                                                      width: 10,
                                                                                    ),
                                                                                    Expanded(
                                                                                      child: Text(
                                                                                        'Tampilan',
                                                                                        style: AppTextStyle.regularTextStyle.copyWith(fontSize: 14),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              const SizedBox(
                                                                                height: 19,
                                                                              ),
                                                                              TextButton(
                                                                                style: TextButton.styleFrom(
                                                                                    padding: const EdgeInsets.all(0),
                                                                                    shape: RoundedRectangleBorder(
                                                                                      borderRadius: BorderRadius.circular(12),
                                                                                    )),
                                                                                onPressed: () {},
                                                                                child: Row(
                                                                                  children: [
                                                                                    Image.asset(
                                                                                      'assets/images/icon_suara.png',
                                                                                      height: 30,
                                                                                      width: 30,
                                                                                    ),
                                                                                    const SizedBox(
                                                                                      width: 10,
                                                                                    ),
                                                                                    Expanded(
                                                                                      child: Text(
                                                                                        'Suara',
                                                                                        style: AppTextStyle.regularTextStyle.copyWith(fontSize: 14),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              const SizedBox(
                                                                                height: 19,
                                                                              ),
                                                                              TextButton(
                                                                                style: TextButton.styleFrom(
                                                                                    padding: const EdgeInsets.all(0),
                                                                                    shape: RoundedRectangleBorder(
                                                                                      borderRadius: BorderRadius.circular(12),
                                                                                    )),
                                                                                onPressed: () {},
                                                                                child: Row(
                                                                                  children: [
                                                                                    Image.asset(
                                                                                      'assets/images/icon_keyboard.png',
                                                                                      height: 30,
                                                                                      width: 30,
                                                                                    ),
                                                                                    const SizedBox(
                                                                                      width: 10,
                                                                                    ),
                                                                                    Expanded(
                                                                                      child: Text(
                                                                                        'Keyboard',
                                                                                        style: AppTextStyle.regularTextStyle.copyWith(fontSize: 14),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              const SizedBox(
                                                                                height: 19,
                                                                              ),
                                                                              TextButton(
                                                                                style: TextButton.styleFrom(
                                                                                    padding: const EdgeInsets.all(0),
                                                                                    shape: RoundedRectangleBorder(
                                                                                      borderRadius: BorderRadius.circular(12),
                                                                                    )),
                                                                                onPressed: () {},
                                                                                child: Row(
                                                                                  children: [
                                                                                    Image.asset(
                                                                                      'assets/images/icon_prediksi.png',
                                                                                      height: 30,
                                                                                      width: 30,
                                                                                    ),
                                                                                    const SizedBox(
                                                                                      width: 10,
                                                                                    ),
                                                                                    Expanded(
                                                                                      child: Text(
                                                                                        'Prediksi',
                                                                                        style: AppTextStyle.regularTextStyle.copyWith(fontSize: 14),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              25,
                                                                        ),
                                                                        Container(
                                                                          padding:
                                                                              const EdgeInsets.all(0),
                                                                          child:
                                                                              Text(
                                                                            'Aplikasi',
                                                                            style:
                                                                                AppTextStyle.boldTextStyle.copyWith(
                                                                              color: AppColors.mainRedColor.withOpacity(.6),
                                                                              fontSize: 12,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        Container(
                                                                          padding:
                                                                              const EdgeInsets.all(12),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                AppColors.mainWhiteColor,
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                          ),
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              TextButton(
                                                                                style: TextButton.styleFrom(
                                                                                    padding: const EdgeInsets.all(0),
                                                                                    shape: RoundedRectangleBorder(
                                                                                      borderRadius: BorderRadius.circular(12),
                                                                                    )),
                                                                                onPressed: () {
                                                                                  Navigator.of(context).pop();
                                                                                  AppRouter.navToTentangKami(context);
                                                                                },
                                                                                child: Row(
                                                                                  children: [
                                                                                    Image.asset(
                                                                                      'assets/images/icon_tentang_kami.png',
                                                                                      height: 30,
                                                                                      width: 30,
                                                                                    ),
                                                                                    const SizedBox(
                                                                                      width: 10,
                                                                                    ),
                                                                                    Expanded(
                                                                                      child: Text(
                                                                                        'Tentang Kami',
                                                                                        style: AppTextStyle.regularTextStyle.copyWith(fontSize: 14),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              const SizedBox(
                                                                                height: 19,
                                                                              ),
                                                                              TextButton(
                                                                                style: TextButton.styleFrom(
                                                                                    padding: const EdgeInsets.all(0),
                                                                                    shape: RoundedRectangleBorder(
                                                                                      borderRadius: BorderRadius.circular(12),
                                                                                    )),
                                                                                onPressed: () {},
                                                                                child: Row(
                                                                                  children: [
                                                                                    Image.asset(
                                                                                      'assets/images/icon_pusat_bantuan.png',
                                                                                      height: 30,
                                                                                      width: 30,
                                                                                    ),
                                                                                    const SizedBox(
                                                                                      width: 10,
                                                                                    ),
                                                                                    Expanded(
                                                                                      child: Text(
                                                                                        'Pusat Bantuan',
                                                                                        style: AppTextStyle.regularTextStyle.copyWith(fontSize: 14),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              18,
                                                                        ),
                                                                        Container(
                                                                          padding:
                                                                              const EdgeInsets.all(0),
                                                                          width:
                                                                              double.infinity,
                                                                          child:
                                                                              Text(
                                                                            'Versi ' +
                                                                                AppConfig.appVersionName,
                                                                            style:
                                                                                AppTextStyle.regularTextStyle.copyWith(
                                                                              color: AppColors.mainGrayColor,
                                                                              fontSize: 12,
                                                                            ),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              35,
                                                                        ),
                                                                        Container(
                                                                          padding:
                                                                              const EdgeInsets.all(0),
                                                                          height:
                                                                              50,
                                                                          width:
                                                                              double.infinity,
                                                                          child:
                                                                              OutlinedButton(
                                                                            style:
                                                                                ButtonStyle(
                                                                              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                                                                              side: MaterialStateProperty.all(BorderSide(color: AppColors.btnLinear2Color, width: 2.0, style: BorderStyle.solid)),
                                                                              padding: MaterialStateProperty.all(const EdgeInsets.only(top: 15, bottom: 15)),
                                                                            ),
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.of(context).pop();
                                                                              _signOut(provider);
                                                                            },
                                                                            child:
                                                                                Text(
                                                                              'Keluar Aplikasi',
                                                                              style: AppTextStyle.boldTextStyle.copyWith(color: AppColors.btnLinear2Color, fontSize: 16),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              25,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    });
                                              },
                                              child: Icon(
                                                Icons.settings_outlined,
                                                color: AppColors.mainRedColor,
                                                size: 24,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height -
                                                  180,
                                              padding: EdgeInsets.only(
                                                  left: 10,
                                                  top: 0,
                                                  right: 10,
                                                  bottom: MediaQuery.of(context)
                                                      .viewInsets
                                                      .bottom),
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                  filled: false,
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0),
                                                    borderSide: BorderSide.none,
                                                  ),
                                                ),
                                                cursorColor:
                                                    AppColors.mainWhiteColor,
                                                style: AppTextStyle
                                                    .blackTextStyle
                                                    .copyWith(
                                                        color: AppColors
                                                            .mainWhiteColor,
                                                        fontSize: 26),
                                                keyboardType:
                                                    TextInputType.multiline,
                                                maxLines: null,
                                                controller: voiceTextController,
                                                onChanged: (String value) {
                                                  _onChange(value);
                                                },
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'Silahkan masukan text';
                                                  }
                                                },
                                              ),
                                            ),
                                            // _inputSection(),
                                            // _btnSection(),
                                            // _engineSection(),
                                            // _futureBuilder(),
                                            // _buildSliders(),
                                            // if (isAndroid) _getMaxSpeechInputLengthSection(),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 50,
                                            height: 50,
                                            padding: const EdgeInsets.all(0),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary:
                                                    AppColors.mainWhiteColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(0),
                                              ),
                                              onPressed: () {
                                                _clear();
                                              },
                                              child: Icon(
                                                Icons.close_outlined,
                                                color: AppColors.mainRedColor,
                                                size: 22,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 50,
                                            height: 50,
                                            padding: const EdgeInsets.all(0),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary:
                                                    AppColors.mainWhiteColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(0),
                                              ),
                                              onPressed: () {
                                                _speak();
                                              },
                                              child: Icon(
                                                Icons.play_arrow,
                                                color: AppColors.mainRedColor,
                                                size: 22,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 50,
                                            height: 50,
                                            padding: const EdgeInsets.all(0),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary:
                                                    AppColors.mainWhiteColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(0),
                                              ),
                                              onPressed: () {
                                                _stop();
                                              },
                                              child: Icon(
                                                Icons.stop,
                                                color: AppColors.mainRedColor,
                                                size: 22,
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
                        Container(
                          width: widthSidebar,
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Image.asset(
                                    'assets/images/icon_sidebar_right.png',
                                    width: 25,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  // padding: const EdgeInsets.only(bottom: 10),

                                  child: Column(
                                    children: [
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          padding: const EdgeInsets.all(0),
                                        ),
                                        onPressed: () {
                                          if (isVisibleBicaraCepat == false) {
                                            isVisibleBicaraCepat = true;
                                          } else {
                                            isVisibleBicaraCepat = false;
                                          }
                                          setState(() {});
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Bicara Cepat',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: AppTextStyle
                                                    .blackTextStyle
                                                    .copyWith(
                                                        color: AppColors
                                                            .mainRedColor,
                                                        fontSize: 34),
                                              ),
                                            ),
                                            Icon(
                                              (isVisibleBicaraCepat)
                                                  ? Icons
                                                      .keyboard_arrow_up_rounded
                                                  : Icons
                                                      .keyboard_arrow_down_rounded,
                                              size: 22,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Visibility(
                                        visible: isVisibleBicaraCepat,
                                        child: Container(
                                          width: double.infinity,
                                          margin: const EdgeInsets.only(top: 8),
                                          padding: const EdgeInsets.all(0),
                                          child: Wrap(
                                            runAlignment: WrapAlignment.start,
                                            alignment: WrapAlignment.start,
                                            crossAxisAlignment:
                                                WrapCrossAlignment.start,
                                            children: [
                                              for (var element in provider
                                                  .bicaraCepatModelData)
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(6),
                                                  child: TextButton(
                                                    style: TextButton.styleFrom(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 24,
                                                              top: 12,
                                                              right: 24,
                                                              bottom: 12),
                                                      backgroundColor: AppColors
                                                          .mainRedColor
                                                          .withOpacity(.1),
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        String?
                                                            currentVoiceText =
                                                            _newVoiceText;
                                                        if (currentVoiceText !=
                                                                '' &&
                                                            currentVoiceText !=
                                                                null) {
                                                          currentVoiceText =
                                                              currentVoiceText +
                                                                  ' ' +
                                                                  element.kata
                                                                      .toLowerCase();
                                                        } else {
                                                          currentVoiceText =
                                                              element.kata
                                                                  .toLowerCase();
                                                        }

                                                        _newVoiceText =
                                                            currentVoiceText;
                                                        voiceTextController
                                                                .text =
                                                            currentVoiceText;
                                                        voiceTextController
                                                                .selection =
                                                            TextSelection.collapsed(
                                                                offset:
                                                                    currentVoiceText
                                                                        .length);
                                                      });
                                                    },
                                                    child: Text(
                                                      element.kata,
                                                      style: AppTextStyle
                                                          .boldTextStyle
                                                          .copyWith(
                                                              color: AppColors
                                                                  .mainRedColor,
                                                              fontSize: 16),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
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
      ),
    );
  }

  // Widget _engineSection() {
  //   if (isAndroid) {
  //     return FutureBuilder<dynamic>(
  //         future: _getEngines(),
  //         builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
  //           if (snapshot.hasData) {
  //             return _enginesDropDownSection(snapshot.data);
  //           } else if (snapshot.hasError) {
  //             return Text('Error loading engines...');
  //           } else
  //             return Text('Loading engines...');
  //         });
  //   } else
  //     return Container(width: 0, height: 0);
  // }

  // Widget _futureBuilder() => FutureBuilder<dynamic>(
  //     future: _getLanguages(),
  //     builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
  //       if (snapshot.hasData) {
  //         return _languageDropDownSection(snapshot.data);
  //       } else if (snapshot.hasError) {
  //         return Text('Error loading languages...');
  //       } else
  //         return Text('Loading Languages...');
  //     },);

  // Widget _inputSection() => Container(
  //     alignment: Alignment.topCenter,
  //     padding: EdgeInsets.only(top: 25.0, left: 25.0, right: 25.0),
  //     child: TextField(
  //       onChanged: (String value) {
  //         _onChange(value);
  //       },
  //     ));

  // Widget _btnSection() {
  //   if (isAndroid) {
  //     return Container(
  //         padding: EdgeInsets.only(top: 50.0),
  //         child:
  //             Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
  //           _buildButtonColumn(Colors.green, Colors.greenAccent,
  //               Icons.play_arrow, 'PLAY', _speak),
  //           _buildButtonColumn(
  //               Colors.red, Colors.redAccent, Icons.stop, 'STOP', _stop),
  //         ]));
  //   } else {
  //     return Container(
  //         padding: EdgeInsets.only(top: 50.0),
  //         child:
  //             Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
  //           _buildButtonColumn(Colors.green, Colors.greenAccent,
  //               Icons.play_arrow, 'PLAY', _speak),
  //           _buildButtonColumn(
  //               Colors.red, Colors.redAccent, Icons.stop, 'STOP', _stop),
  //           _buildButtonColumn(
  //               Colors.blue, Colors.blueAccent, Icons.pause, 'PAUSE', _pause),
  //         ]));
  //   }
  // }

  // Widget _enginesDropDownSection(dynamic engines) => Container(
  //       padding: EdgeInsets.only(top: 50.0),
  //       child: DropdownButton(
  //         value: engine,
  //         items: getEnginesDropDownMenuItems(engines),
  //         onChanged: changedEnginesDropDownItem,
  //       ),
  //     );

  // Widget _languageDropDownSection(dynamic languages) => Container(
  //     padding: EdgeInsets.only(top: 10.0),
  //     child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
  //       DropdownButton(
  //         value: language,
  //         items: getLanguageDropDownMenuItems(languages),
  //         onChanged: changedLanguageDropDownItem,
  //       ),
  //       Visibility(
  //         visible: isAndroid,
  //         child: Text("Is installed: $isCurrentLanguageInstalled"),
  //       ),
  //     ]));

  // Column _buildButtonColumn(Color color, Color splashColor, IconData icon,
  //     String label, Function func) {
  //   return Column(
  //       mainAxisSize: MainAxisSize.min,
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         IconButton(
  //             icon: Icon(icon),
  //             color: color,
  //             splashColor: splashColor,
  //             onPressed: () => func()),
  //         Container(
  //             margin: const EdgeInsets.only(top: 8.0),
  //             child: Text(label,
  //                 style: TextStyle(
  //                     fontSize: 12.0,
  //                     fontWeight: FontWeight.w400,
  //                     color: color)))
  //       ]);
  // }

  // Widget _getMaxSpeechInputLengthSection() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //     children: [
  //       ElevatedButton(
  //         child: Text('Get max speech input length'),
  //         onPressed: () async {
  //           _inputLength = await flutterTts.getMaxSpeechInputLength;
  //           setState(() {});
  //         },
  //       ),
  //       Text("$_inputLength characters"),
  //     ],
  //   );
  // }

  // Widget _buildSliders() {
  //   return Column(
  //     children: [_volume(), _pitch(), _rate()],
  //   );
  // }

  // Widget _volume() {
  //   return Slider(
  //       value: volume,
  //       onChanged: (newVolume) {
  //         setState(() => volume = newVolume);
  //       },
  //       min: 0.0,
  //       max: 1.0,
  //       divisions: 10,
  //       label: "Volume: $volume");
  // }

  // Widget _pitch() {
  //   return Slider(
  //     value: pitch,
  //     onChanged: (newPitch) {
  //       setState(() => pitch = newPitch);
  //     },
  //     min: 0.5,
  //     max: 2.0,
  //     divisions: 15,
  //     label: "Pitch: $pitch",
  //     activeColor: Colors.red,
  //   );
  // }

  // Widget _rate() {
  //   return Slider(
  //     value: rate,
  //     onChanged: (newRate) {
  //       setState(() => rate = newRate);
  //     },
  //     min: 0.0,
  //     max: 1.0,
  //     divisions: 10,
  //     label: "Rate: $rate",
  //     activeColor: Colors.green,
  //   );
  // }

}
