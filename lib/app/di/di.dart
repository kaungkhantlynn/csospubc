import 'package:community_sos/app/modules/sharedpref/shared_preference_helper.dart';
import 'package:community_sos/app/services/trusted_list_service.dart';
import 'package:community_sos/app/utils/translate_preferences.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.I;

Future<void> init() async {
  SharedPreferenceHelper sharedPreferenceHelper = await SharedPreferenceHelper.getInstance();
  getIt.registerSingleton<SharedPreferenceHelper>(sharedPreferenceHelper);

  getIt.registerFactory<TranslatePreferences>(() => TranslatePreferences(
      sharedPreferenceHelper: getIt<SharedPreferenceHelper>()
  ));

  getIt.registerSingletonAsync<TrustedListService>(
          () async => await TrustedListService.getInstance()
  );
}