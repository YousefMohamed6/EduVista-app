import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/services/pref_service.dart';

class SettingsState {
  final ThemeMode themeMode;
  final Locale locale;

  SettingsState({
    required this.themeMode,
    required this.locale,
  });

  SettingsState copyWith({
    ThemeMode? themeMode,
    Locale? locale,
  }) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
    );
  }
}

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit()
      : super(SettingsState(
          themeMode: PreferencesService.themeMode == 'dark'
              ? ThemeMode.dark
              : ThemeMode.light,
          locale: Locale(PreferencesService.locale),
        ));

  void toggleTheme() {
    final newMode =
        state.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    PreferencesService.themeMode = newMode == ThemeMode.dark ? 'dark' : 'light';
    emit(state.copyWith(themeMode: newMode));
  }

  void changeLocale(String languageCode) {
    PreferencesService.locale = languageCode;
    emit(state.copyWith(locale: Locale(languageCode)));
  }
}
