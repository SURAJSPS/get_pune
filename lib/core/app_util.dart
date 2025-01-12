import 'dart:io';

import 'package:flutter/foundation.dart';

class AppUtil {
  static bool isMobile() {
    if (kIsWeb) {
      return false;
    }

    if (Platform.isAndroid || Platform.isIOS) {
      return true;
    } else if (Platform.isWindows ||
        Platform.isMacOS ||
        Platform.isLinux ||
        Platform.isFuchsia) {
      return false;
    }
    return false;
  }

  static String pdfPath(String title) {
    if (title.contains("जीएसटी-एपीएल 01") || title.contains("GST-APL 01")) {
      return "assets/pdf/gst.pdf";
    }
    if (title.contains("एसटी-04") || title.contains("ST-04")) {
      return "assets/pdf/st.pdf";
    }
    if (title.contains("ईए-01") || title.contains("EA-01")) {
      return "assets/pdf/ea.pdf";
    }
    if (title.contains("सीए-01") || title.contains("CA-01")) {
      return "assets/pdf/ca.pdf";
    }

    return "";
  }

  static bool checkPdfPath(String title) {
    if (title.contains("जीएसटी-एपीएल 01") || title.contains("GST-APL 01")) {
      return true;
    }
    if (title.contains("एसटी-04") || title.contains("ST-04")) {
      return true;
    }
    if (title.contains("ईए-01") || title.contains("EA-01")) {
      return true;
    }
    if (title.contains("सीए-01") || title.contains("CA-01")) {
      return true;
    }
    return false;
  }




static String pdfText(String title, String languageId) {
    if (title.contains("जीएसटी-एपीएल 01") || title.contains("GST-APL 01")) {
      return languageId == "hi" ? "जीएसटी-एपीएल 01" : "GST-APL 01";
    }
    if (title.contains("ST-04") || title.contains("ST-04")) {
      return languageId == "hi" ? "एसटी-04" : "ST-04";
    }
    if (title.contains("ईए-01") || title.contains("EA-01")) {
      return languageId == "hi" ? "ईए-01" : "EA-01";
    }
    if (title.contains("सीए-01") || title.contains("CA-01")) {
      return languageId == "hi" ? "सीए-01" : "CA-01";
    }

    return "";
  }




}



