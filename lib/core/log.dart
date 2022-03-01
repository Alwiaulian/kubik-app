import 'dart:convert';

import 'package:ansicolor/ansicolor.dart';
import 'package:logger/logger.dart';

class L {
  static final _logger = Logger(
    printer: PrettyPrinter(
        printEmojis: false,
        printTime: false,
        colors: true,
        errorMethodCount: 1,
        methodCount: 2),
  );
  static final _loggerNoStack = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      printEmojis: false,
    ),
  );

  static void header(data) {
    var pen = AnsiPen()
      ..white(bg: true, bold: true)
      ..xterm(17, bg: true)
      ..rgb(r: 0.0, g: 128.8, b: 0.0);
    print(pen(data.toString() + '\n'));
  }

  static void success(data) {
    var pen = AnsiPen()
      //  ..white(bg: true, bold: true)
      //  ..xterm(17, bg: false)
      ..rgb(r: 0.1, g: 255.0, b: 0.4);
    print(pen(data.toString() + '\n'));
  }

  static void log(data, {bool track = false}) {
    if (track) {
      _logger.e('L.log');
    }
    var pen = AnsiPen()
      ..white(bg: true, bold: true)
      ..xterm(14, bg: false)
      ..rgb(r: 255.0, g: 0.265, b: 0.00);
    print(pen('\n' + data.toString() + '\n'));
  }

  static void error(data, {bool track = true}) {
    if (track) {
      _logger.e('L.error');
    }
    var pen = AnsiPen()
      // ..white(bg: true, bold: true)
      ..xterm(17, bg: false)
      ..rgb(r: 255.1, g: 0.0, b: 0.0);
    print(pen(data.toString() + '\n'));
  }

  static void warning(data, {bool track = false}) {
    if (track) {
      _logger.w('L.warning');
    }
    var pen = AnsiPen()
      // ..white(bg: true, bold: true)
      ..xterm(17, bg: false)
      ..rgb(r: 255.1, g: 0.2, b: 0.4);
    print(pen(data.toString() + '\n'));
  }

  static void json(data, {bool track = false}) {
    var object = {};
    if (data is String) {
      try {
        object = jsonDecode(data);
      } catch (e) {
        _logger.e('String is not json');
        return;
      }
    }

    if (data is Map) {
      object = data;
    } else {
      return;
    }
    var prettyString = JsonEncoder.withIndent('  ').convert(object);
    if (track) _logger.i('L.json');
    var pen = AnsiPen()
      ..white(bg: true, bold: true)
      ..xterm(17, bg: false)
      ..rgb(r: 0.1, g: 255.0, b: 0.4);
      print(pen(prettyString.toString() + '\n'));
  //  _printFunction(prettyString, pen);
  }

  static void map(Map data, {bool track = true}) {
    if (track) {
      _logger.v('L.map\n');
      _loggerNoStack.e(data);
    } else {
      var prettyString = JsonEncoder.withIndent('  ').convert(data);
      var pen = AnsiPen()
        ..white(bg: true, bold: true)
        ..xterm(17, bg: false)
        ..rgb(r: 255.0, g: 0.29, b: 0.1);
      _printFunction(prettyString, pen);
      //print(pen(prettyString.toString() + '\n'));
      // _logger.v(prettyString);
    }
  }

  static _printFunction(String prettyString, AnsiPen ansiPen) {
    prettyString.toString().split('\n').forEach((element) {
      print(ansiPen(element.toString() + '\n'));
    });
  }
}