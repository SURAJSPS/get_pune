import 'dart:io';

import 'package:flutter/foundation.dart';


class AppUtil {
  static bool isMobile() {

if(kIsWeb){
  return false;
}

    if(Platform.isAndroid || Platform.isIOS){
    return true;
  }else if(Platform.isWindows || Platform.isMacOS || Platform.isLinux||Platform.isFuchsia){
    return false;
  }
  return false;
}
}