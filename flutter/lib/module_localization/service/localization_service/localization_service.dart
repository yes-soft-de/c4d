import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:c4d/module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart';

@provide
@singleton
class LocalizationService {
  static final PublishSubject<String> _localizationSubject =
      PublishSubject<String>();
  Stream<String> get localizationStream => _localizationSubject.stream;
  final LocalizationPreferencesHelper _preferencesHelper;
  LocalizationService(this._preferencesHelper);

  Future<void> setLanguage(String lang) async {
    await _preferencesHelper.setLanguage(lang);
    _localizationSubject.add(lang);
  }

  Future<String> getLanguage() async {
    String lang = await _preferencesHelper.getLanguage();
    lang ??= 'en';
    return lang;
  }

  void dispose() {
    _localizationSubject.close();
  }
}
