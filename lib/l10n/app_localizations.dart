import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @topRatedCourses.
  ///
  /// In en, this message translates to:
  /// **'Top Rated Courses'**
  String get topRatedCourses;

  /// No description provided for @bestSellerCourses.
  ///
  /// In en, this message translates to:
  /// **'Best Seller Courses'**
  String get bestSellerCourses;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get seeAll;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search...'**
  String get searchHint;

  /// No description provided for @myCourses.
  ///
  /// In en, this message translates to:
  /// **'My Courses'**
  String get myCourses;

  /// No description provided for @cart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cart;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Your Password?'**
  String get forgotPassword;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @signUpHere.
  ///
  /// In en, this message translates to:
  /// **'Sign Up Here'**
  String get signUpHere;

  /// No description provided for @loginHere.
  ///
  /// In en, this message translates to:
  /// **'Login Here'**
  String get loginHere;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get currentPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @confirmNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get confirmNewPassword;

  /// No description provided for @enterCurrentPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your current Password'**
  String get enterCurrentPassword;

  /// No description provided for @enterNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your New Password'**
  String get enterNewPassword;

  /// No description provided for @confirmYourNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm your New Password'**
  String get confirmYourNewPassword;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @changesSaved.
  ///
  /// In en, this message translates to:
  /// **'Changes have been saved!'**
  String get changesSaved;

  /// No description provided for @changeEmail.
  ///
  /// In en, this message translates to:
  /// **'Change Email'**
  String get changeEmail;

  /// No description provided for @changeName.
  ///
  /// In en, this message translates to:
  /// **'Change Name'**
  String get changeName;

  /// No description provided for @addPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Add Phone Number'**
  String get addPhoneNumber;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @addAge.
  ///
  /// In en, this message translates to:
  /// **'Add Age'**
  String get addAge;

  /// No description provided for @age.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get age;

  /// No description provided for @selectGender.
  ///
  /// In en, this message translates to:
  /// **'Select Gender'**
  String get selectGender;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @aboutUs.
  ///
  /// In en, this message translates to:
  /// **'About us'**
  String get aboutUs;

  /// No description provided for @welcomeToEduVista.
  ///
  /// In en, this message translates to:
  /// **'Welcome to EduVista!'**
  String get welcomeToEduVista;

  /// No description provided for @eduVistaDescription.
  ///
  /// In en, this message translates to:
  /// **'At EduVista, we\'re passionate about making learning accessible and enjoyable for everyone. Our mission is to bring high-quality education to your fingertips, whether you\'re a student looking to excel or a lifelong learner exploring new interests.'**
  String get eduVistaDescription;

  /// No description provided for @eduVistaCTA.
  ///
  /// In en, this message translates to:
  /// **'Join our community of learners today and start your journey towards achieving your goals!'**
  String get eduVistaCTA;

  /// No description provided for @eduVistaSlogan.
  ///
  /// In en, this message translates to:
  /// **'EduVista – Learning Made Simple.'**
  String get eduVistaSlogan;

  /// No description provided for @eduVistaVersion.
  ///
  /// In en, this message translates to:
  /// **'EduVista @Version 1.0'**
  String get eduVistaVersion;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @letsStartLearning.
  ///
  /// In en, this message translates to:
  /// **'Let\'s Start Learning!'**
  String get letsStartLearning;

  /// No description provided for @certificationAndBadges.
  ///
  /// In en, this message translates to:
  /// **'Certification and Badges'**
  String get certificationAndBadges;

  /// No description provided for @certificationDesc.
  ///
  /// In en, this message translates to:
  /// **'Earn a certificate after completion of every course'**
  String get certificationDesc;

  /// No description provided for @progressTracking.
  ///
  /// In en, this message translates to:
  /// **'Progress Tracking'**
  String get progressTracking;

  /// No description provided for @progressDesc.
  ///
  /// In en, this message translates to:
  /// **'Check your Progress of every course'**
  String get progressDesc;

  /// No description provided for @offlineAccess.
  ///
  /// In en, this message translates to:
  /// **'Offline Access'**
  String get offlineAccess;

  /// No description provided for @offlineDesc.
  ///
  /// In en, this message translates to:
  /// **'Make your course available offline'**
  String get offlineDesc;

  /// No description provided for @courseCatalog.
  ///
  /// In en, this message translates to:
  /// **'Course Catalog'**
  String get courseCatalog;

  /// No description provided for @courseCatalogDesc.
  ///
  /// In en, this message translates to:
  /// **'View in which courses you are enrolled'**
  String get courseCatalogDesc;

  /// No description provided for @noCoursesBought.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t bought any courses yet'**
  String get noCoursesBought;

  /// No description provided for @noCoursesAvailable.
  ///
  /// In en, this message translates to:
  /// **'No Courses Available at the moment'**
  String get noCoursesAvailable;

  /// No description provided for @noLecturesFound.
  ///
  /// In en, this message translates to:
  /// **'No lectures found'**
  String get noLecturesFound;

  /// No description provided for @noResourcesAvailable.
  ///
  /// In en, this message translates to:
  /// **'No resources available for this course'**
  String get noResourcesAvailable;

  /// No description provided for @aboutInstructor.
  ///
  /// In en, this message translates to:
  /// **'About Instructor'**
  String get aboutInstructor;

  /// No description provided for @courseResource.
  ///
  /// In en, this message translates to:
  /// **'Course Resource'**
  String get courseResource;

  /// No description provided for @instructorInfo.
  ///
  /// In en, this message translates to:
  /// **'Instructor Info'**
  String get instructorInfo;

  /// No description provided for @education.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get education;

  /// No description provided for @yearsOfExperience.
  ///
  /// In en, this message translates to:
  /// **'Years of Experience'**
  String get yearsOfExperience;

  /// No description provided for @years.
  ///
  /// In en, this message translates to:
  /// **'Years'**
  String get years;

  /// No description provided for @continueLearning.
  ///
  /// In en, this message translates to:
  /// **'Continue Learning with More Courses by the Instructor!'**
  String get continueLearning;

  /// No description provided for @noCoursesForInstructor.
  ///
  /// In en, this message translates to:
  /// **'No courses available for this instructor'**
  String get noCoursesForInstructor;

  /// No description provided for @courses.
  ///
  /// In en, this message translates to:
  /// **'Courses'**
  String get courses;

  /// No description provided for @instructors.
  ///
  /// In en, this message translates to:
  /// **'Instructors'**
  String get instructors;

  /// No description provided for @purchaseSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Purchase successful!'**
  String get purchaseSuccessful;

  /// No description provided for @cartEmpty.
  ///
  /// In en, this message translates to:
  /// **'Your cart is empty'**
  String get cartEmpty;

  /// No description provided for @startCoursesNow.
  ///
  /// In en, this message translates to:
  /// **'Start Your Courses Now: {price} {currency}'**
  String startCoursesNow(Object price, Object currency);

  /// No description provided for @egp.
  ///
  /// In en, this message translates to:
  /// **'EGP'**
  String get egp;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @deleteConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this course from your cart?'**
  String get deleteConfirmation;

  /// No description provided for @cartLoadError.
  ///
  /// In en, this message translates to:
  /// **'Can\'t load cart now, try again later!'**
  String get cartLoadError;

  /// No description provided for @emailInUse.
  ///
  /// In en, this message translates to:
  /// **'Email is already in use.'**
  String get emailInUse;

  /// No description provided for @weakPassword.
  ///
  /// In en, this message translates to:
  /// **'Password is too weak.'**
  String get weakPassword;

  /// No description provided for @signupFailed.
  ///
  /// In en, this message translates to:
  /// **'Signup failed. Please try again.'**
  String get signupFailed;

  /// No description provided for @loginFailed.
  ///
  /// In en, this message translates to:
  /// **'Login failed. Please try again.'**
  String get loginFailed;

  /// No description provided for @userNotFound.
  ///
  /// In en, this message translates to:
  /// **'User not found.'**
  String get userNotFound;

  /// No description provided for @incorrectPassword.
  ///
  /// In en, this message translates to:
  /// **'Incorrect password.'**
  String get incorrectPassword;

  /// No description provided for @noUserFoundForEmail.
  ///
  /// In en, this message translates to:
  /// **'No user found for that email.'**
  String get noUserFoundForEmail;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid email address.'**
  String get invalidEmail;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong.'**
  String get somethingWentWrong;

  /// No description provided for @unknownError.
  ///
  /// In en, this message translates to:
  /// **'An unknown error occurred.'**
  String get unknownError;

  /// No description provided for @pleaseEnterEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter an email'**
  String get pleaseEnterEmail;

  /// No description provided for @emailSent.
  ///
  /// In en, this message translates to:
  /// **'Password reset email sent'**
  String get emailSent;

  /// No description provided for @passwordChangedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Password has been changed successfully'**
  String get passwordChangedSuccessfully;

  /// No description provided for @lecture.
  ///
  /// In en, this message translates to:
  /// **'Lecture'**
  String get lecture;

  /// No description provided for @certificate.
  ///
  /// In en, this message translates to:
  /// **'Certificate'**
  String get certificate;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @lectureCount.
  ///
  /// In en, this message translates to:
  /// **'Lecture {count}'**
  String lectureCount(Object count);

  /// No description provided for @durationMin.
  ///
  /// In en, this message translates to:
  /// **'Duration: {duration} min'**
  String durationMin(Object duration);

  /// No description provided for @lectureVideo.
  ///
  /// In en, this message translates to:
  /// **'Lecture Video'**
  String get lectureVideo;

  /// No description provided for @invalidUrl.
  ///
  /// In en, this message translates to:
  /// **'Invalid Url'**
  String get invalidUrl;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
