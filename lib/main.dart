import 'package:device_preview/device_preview.dart';
import 'package:edu_vista/src/features/cart/logic/cart_cubit/cart_cubit.dart';
import 'package:edu_vista/src/features/category/data/repositories/category_repository_impl.dart';
import 'package:edu_vista/src/features/category/domain/repositories/category_repository.dart';
import 'package:edu_vista/src/features/category/presentation/manager/category_bloc.dart';
import 'package:edu_vista/src/features/course/data/repositories/course_repository_impl.dart';
import 'package:edu_vista/src/features/course/domain/repositories/course_repository.dart';
import 'package:edu_vista/src/features/course/presentation/manager/course_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'src/app.dart';
import 'src/features/auth/logic/auth_cubit/auth_cubit.dart';
import 'src/features/lecture/logic/lecture_bloc/lecture_bloc.dart';
import 'src/features/profile/logic/user_cubit/user_cubit.dart';
import 'src/features/settings/presentation/manager/settings_cubit.dart';
import 'firebase_options.dart';
import 'src/shared/services/pref_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesService.init();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    if (kDebugMode) {
      print('Failed to initialize Firebase: $e');
    }
  }
  await dotenv.load(fileName: ".env");

  // Repository instances
  final categoryRepository = CategoryRepositoryImpl();
  final courseRepository = CourseRepositoryImpl();

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MultiRepositoryProvider(
        providers: [
          RepositoryProvider<CategoryRepository>(
              create: (context) => categoryRepository),
          RepositoryProvider<CourseRepository>(
              create: (context) => courseRepository),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (ctx) => AuthCubit()),
            BlocProvider(create: (ctx) => UserCubit()),
            BlocProvider(create: (ctx) => CartCubit()..fetchCart()),
            BlocProvider(
                create: (ctx) => CategoryBloc(categoryRepository)
                  ..add(GetCategoriesEvent())),
            BlocProvider(create: (ctx) => CourseBloc(courseRepository)),
            BlocProvider(create: (ctx) => LectureBloc()),
            BlocProvider(create: (ctx) => SettingsCubit()),
          ],
          child: const MyApp(),
        ),
      ),
    ),
  );
}
