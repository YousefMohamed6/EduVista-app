import 'package:shared_preferences/shared_preferences.dart';

abstract class PreferencesService {
  static SharedPreferences? prefs;

  static Future<void> init() async {
    try {
      prefs = await SharedPreferences.getInstance();
      print('prefs is setup Successfully');
    } catch (e) {
      print('Failed to initialize preferences: $e');
    }
  }

  static bool get isOnBoardingSeen =>
      prefs!.getBool('isOnBoardingSeen') ?? false;

  static set isOnBoardingSeen(bool value) =>
      prefs!.setBool('isOnBoardingSeen', value);

  static String get locale => prefs!.getString('locale') ?? 'en';

  static set locale(String value) => prefs!.setString('locale', value);

  static String get themeMode => prefs!.getString('themeMode') ?? 'light';

  static set themeMode(String value) => prefs!.setString('themeMode', value);
}
