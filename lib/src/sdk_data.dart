import 'model/label.dart';
import 'model/release_data.dart';

class SdkData {
  static Map<String, List<String>>? metadata;
  static String? appBuildNumber;
  static ReleaseData? releaseData;

  SdkData._();

  static bool get hasReleaseData => releaseData != null;

  static int? get releaseVersion => releaseData?.version;

  static Map<String, Label>? getData(String locale) =>
      releaseData?.data != null ? releaseData!.data[locale] : null;

  static List<String>? getOrigArgs(String? label) =>
      metadata != null ? metadata![label] : null;
}
