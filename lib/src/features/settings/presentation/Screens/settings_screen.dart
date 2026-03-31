import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/my_app_bar.dart';
import '../manager/settings_cubit.dart';
import '../widgets/setting_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: MyAppBar(
        title: localization.settings,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              return Column(
                children: [
                  SettingTile(
                    title: localization.darkMode,
                    icon: state.themeMode == ThemeMode.dark
                        ? Icons.dark_mode
                        : Icons.light_mode,
                    trailing: Switch.adaptive(
                      value: state.themeMode == ThemeMode.dark,
                      onChanged: (value) {
                        context.read<SettingsCubit>().toggleTheme();
                      },
                    ),
                  ),
                  Divider(height: 30.h),
                  SettingTile(
                    title: localization.language,
                    icon: Icons.language,
                    trailing: DropdownButton<String>(
                      value: state.locale.languageCode,
                      underline: const SizedBox(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          context.read<SettingsCubit>().changeLocale(newValue);
                        }
                      },
                      items: [
                        DropdownMenuItem(
                          value: 'en',
                          child: Text(localization.english),
                        ),
                        DropdownMenuItem(
                          value: 'ar',
                          child: Text(localization.arabic),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
