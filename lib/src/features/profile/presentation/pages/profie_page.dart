import 'package:edu_vista/src/features/auth/logic/auth_cubit/auth_cubit.dart';
import 'package:edu_vista/src/features/auth/presentation/pages/login_page.dart';
import 'package:edu_vista/src/features/profile/presentation/widgets/profile_settings_expansion_tile.dart';
import 'package:edu_vista/src/shared/widgets/buttons/my_text_button.dart';
import 'package:edu_vista/src/features/profile/presentation/widgets/profile_edit_expansion_tile.dart';
import 'package:edu_vista/src/features/profile/presentation/widgets/user_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../cart/presentation/widgets/shopping_cart_button.dart';
import '../../data/model/user_model.dart';
import '../../logic/user_cubit/user_cubit.dart';
import '../../logic/user_cubit/user_state.dart';
import '../../../../shared/utils/text_utility.dart';
import '../../../../shared/widgets/tiles/my_expansion_tile.dart';

import 'package:edu_vista/l10n/app_localizations.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final List<String> profileOptions = [
      localization.edit,
      localization.settings,
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          localization.profile,
          style: TextUtility.titleText(),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: const ShoppingCartButton(),
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => UserCubit()..fetchUserData(),
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is UserLoaded) {
              AppUser user = state.user;
              return Padding(
                padding: EdgeInsets.all(16.h),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      UserImage(
                        user: user,
                        onPressed: () async {
                          await context.read<UserCubit>().uploadImage(context);
                        },
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        user.name ?? '',
                        style: TextUtility.nameText(),
                      ),
                      Text(user.email ?? '', style: TextUtility.body2Text()),
                      SizedBox(height: 50.h),
                      SingleChildScrollView(
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 20.h),
                          itemCount: profileOptions.length,
                          itemBuilder: (context, index) => MyExpansionTile(
                            title: profileOptions[index],
                            child: index == 0
                                ? ProfileEditExpansionTile(user: user)
                                : index == 1
                                    ? const ProfileSettingsExpansionTile()
                                    : const SizedBox(),
                          ),
                        ),
                      ),
                      MyTextButton(
                          text: localization.logout,
                          textStyle: TextUtility.headerText(
                              color: Colors.red, fontWeight: FontWeight.w700),
                          onPressed: () {
                            context.read<AuthCubit>().logoutUser();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()));
                          })
                    ],
                  ),
                ),
              );
            } else if (state is UserError) {
              return Center(child: Text(state.message));
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
