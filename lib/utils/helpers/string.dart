import 'dart:convert';
import 'dart:math' show Random;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:crypto/crypto.dart';
import 'dart:math';

class StringHelper {
  StringHelper._();

  static NumberFormat money(BuildContext context, {int dp = 2}) {
    return NumberFormat.currency(
      locale: locale(context),
      symbol: '',
      decimalDigits: dp,
    );
  }

  static bool isEmpty(String? s) => s == null || s.trim().isEmpty;

  static bool isNotEmpty(String? s) => !isEmpty(s);

  static String hideText(String text) =>
      text.replaceAll((RegExp(r'[0-9]')), '\u203B ');

  static String titleCaseSingle(String s) =>
      '${s[0].toUpperCase()}${s.substring(1)}';

  static String titleCase(String s) =>
      s.split(" ").map(titleCaseSingle).join(" ");

  static String genId() {
    final rnd = Random.secure();
    final bytes = List<int>.generate(16, (_) => rnd.nextInt(256));
    bytes[6] = (bytes[6] & 0x0F) | 0x40;
    bytes[8] = (bytes[8] & 0x3f) | 0x80;

    final chars = bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();

    return '${chars.substring(0, 8)}-${chars.substring(8, 12)}-'
        '${chars.substring(12, 16)}-${chars.substring(16, 20)}-${chars.substring(20, 32)}';
  }

  ///  Method to nullify an empty String.
  ///  [value] - A string we want to be sure to keep null if empty
  ///  Returns null if a value is empty or null, otherwise, returns the value
  static String? nullify(String value) {
    if (isEmpty(value)) {
      return null;
    }
    return value;
  }

  static String locale(BuildContext context) =>
      Localizations.localeOf(context).toString();


  static String generateRandomText([String name = '']) {
    final _name = name;
    final _listOfText = ['Show someone you ❤ them, send funds Odogwu!'];
    final _listOfMorningText = [
      'Good Morning, $_name  😊',
      'Something here and some text'
    ];
    final _listOfAfternoonText = ['Good afternoon ✌ $_name', "Chief!"];
    final _listOfEveningText = ['Good Evening $_name'];
    final thisHour = DateTime.now().hour;
    if (thisHour > 16) {
      // evening period (passed 4pm)
      _listOfText.addAll(_listOfEveningText);
    } else if (thisHour > 12) {
      // afternoon period (passed 12pm)
      _listOfText.addAll(_listOfAfternoonText);
    } else {
      _listOfText.addAll(_listOfMorningText);
    }
    _listOfText.shuffle();
    return _listOfText[Random().nextInt(_listOfText.length)];
  }

  static String getAvatar(String? email) {
    final String str =
        md5.convert(utf8.encode(email!.toLowerCase())).toString();
    return 'https://www.gravatar.com/avatar/$str?s=500?&d=retro';
  }

  static String getHash(data, {algo = 'sha'}) {
    if (data == null) return "";
    var bytes = utf8.encode(data); // data being hashed
    var hash = algo == "md5" ? md5.convert(bytes) : sha512.convert(bytes);
    return hash.toString();
  }

  static String abbrMoney(String currentBalance) {
    try {
      double value = double.parse(currentBalance);

      if (value < 1000) {
        return value.toStringAsFixed(2);
      } else if (value >= 1000 && value < (1000 * 100 * 10)) {
        double result = value / 1000;
        return result.toStringAsFixed(2) + "k";
      } else if (value >= 1000000 && value < (1000000 * 10 * 100)) {
        double result = value / 1000000;
        return result.toStringAsFixed(2) + "M";
      } else if (value >= (1000000 * 10 * 100) &&
          value < (1000000 * 10 * 100 * 100)) {
        double result = value / (1000000 * 10 * 100);
        return result.toStringAsFixed(2) + "B";
      } else if (value >= (1000000 * 10 * 100 * 100) &&
          value < (1000000 * 10 * 100 * 100 * 100)) {
        double result = value / (1000000 * 10 * 100 * 100);
        return result.toStringAsFixed(2) + "T";
      }
      return currentBalance;
    } catch (e) {
      return currentBalance;
    }
  }
}
