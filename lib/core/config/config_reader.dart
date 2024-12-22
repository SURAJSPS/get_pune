import '../../../presentation/common_libs.dart';

abstract class ConfigReader {
  static Map<String, dynamic> _config = <String, dynamic>{};

  static FutureOr<void> initialize(
      {AppEnvironment env = AppEnvironment.DEBUG}) async {
    switch (env) {
      case AppEnvironment.DEBUG:
        await dotenv.load(fileName: "assets/.env");

      case AppEnvironment.Local:
        await dotenv.load(fileName: "assets/.env.development");

        break;
      case AppEnvironment.PROFILE:
        await dotenv.load(fileName: "assets/.env");
        break;
      case AppEnvironment.RELEASE:
        await dotenv.load(fileName: "assets/.env");
        break;
    }
    _config = dotenv.env;
  }

  static String getBaseUrl() {
    return _config['BASEURL'] as String;
  }

  static Uri uri() {
    return Uri.tryParse(_config['BASEURL'] as String) as Uri;
  }

  static String getCountryId() {
    return _config['COUNTRY_ID'] as String;
  }

  static String getCountryPartner() {
    return _config['COUNTRY_PARTNER'] as String;
  }

  static String getAppVariant() {
    return _config['APP_VARIANT'] as String;
  }
}
