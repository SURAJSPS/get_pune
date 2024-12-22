

import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
 Map<String, dynamic> config = <String, dynamic>{};

abstract class ConfigReader {


  static FutureOr<void> initialize() async {
    final String response = await rootBundle.loadString('assets/images/gst.json');
     config = await json.decode(response);

  }

  // static String getBaseUrl() {
  //   return _config['BASEURL'] as String;
  // }
  //
  // static Uri uri() {
  //   return Uri.tryParse(_config['BASEURL'] as String) as Uri;
  // }
  //
  // static String getCountryId() {
  //   return _config['COUNTRY_ID'] as String;
  // }
  //
  // static String getCountryPartner() {
  //   return _config['COUNTRY_PARTNER'] as String;
  // }
  //
  // static String getAppVariant() {
  //   return _config['APP_VARIANT'] as String;
  // }
}
