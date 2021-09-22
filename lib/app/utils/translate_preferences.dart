import 'dart:ui';

import 'package:community_sos/app/modules/sharedpref/shared_preference_helper.dart';
import 'package:flutter_translate/flutter_translate.dart';

class TranslatePreferences implements ITranslatePreferences {
  final SharedPreferenceHelper sharedPreferenceHelper;

  TranslatePreferences({this.sharedPreferenceHelper});

  @override
  Future<Locale> getPreferredLocale() async {
    if (!sharedPreferenceHelper.isKeyExists(SharedPreferenceHelper.keySelectedLocale)) return null;

    var locale = sharedPreferenceHelper.getString(SharedPreferenceHelper.keySelectedLocale);

    return localeFromString(locale);
  }

  @override
  Future savePreferredLocale(Locale locale) async {
    await sharedPreferenceHelper.putString(SharedPreferenceHelper.keySelectedLocale, localeToString(locale));
  }
}
