import 'dart:convert' as convert;

import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';
import 'package:logger/logger.dart';

import '../platform/platform.dart';

class Util {
  static final Logger _logger = Logger(printer: PrettyPrinter(methodCount: 0));

  static final String _sdkBuildNumber = '2.3.0';

  Util._();

  static String generateUuid() {
    return Uuid().v4();
  }

  static String canonicalizedLocale(String locale) {
    return Intl.canonicalizedLocale(locale);
  }

  static Future<String?> getAppBuildNumber() async {
    String? appBuildNumber;

    try {
      var packageInfo = await PackageInfo.fromPlatform();
      appBuildNumber = packageInfo.version;
    } catch (e) {
      _logger.w('Failed to detect app version');
    }

    return appBuildNumber;
  }

  static String getSdkBuildNumber() {
    return _sdkBuildNumber;
  }

  static String getCurrentLocale() {
    return Intl.getCurrentLocale();
  }

  static String? getDeviceLocale() {
    String? deviceLocale;

    try {
      var platform = Platform();
      deviceLocale = platform.getLocale();
    } catch (e) {
      _logger.w('Failed to detect device locale');
    }

    return deviceLocale;
  }

  /// Converts to inline json message.
  static String formatJsonMessage(String jsonMessage) {
    try {
      var decoded = convert.jsonDecode(jsonMessage);
      return convert.jsonEncode(decoded);
    } catch (e) {
      return jsonMessage;
    }
  }

  static bool isValidSemanticVersion(String value) {
    final maxSegmentValue = 2147483647;
    final semanticVersionRegExp = RegExp(r'^([0-9]+)\.([0-9]+)\.([0-9]+)$');

    if (semanticVersionRegExp.hasMatch(value)) {
      var segments = value.split('.');
      var exceededSegments =
          segments.where((segment) => int.parse(segment) > maxSegmentValue);

      return exceededSegments.isEmpty;
    }

    return false;
  }
}
