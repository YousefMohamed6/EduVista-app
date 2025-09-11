# Edu Vista
Edu Vista is a comprehensive educational app designed for Android, built using Flutter. It offers a range of features to enhance the learning experience. The app leverages BLoC for efficient state management and Firebase for backend services, ensuring a robust and scalable platform.
<div>
<img src="https://github.com/e-khalifa/EduVista-app/blob/main/assets/screenshots/Blue%20Modern%20Mobile%20Application%20Presentation%20(1).jpg">
<div>
  
## Table of Contents
1. [✨ Key Features](#-key-features)
2. [📸 Demo](#-demo)
3. [📸 Screenshots](#-screenshots)
4. [📚 Dependencies](#-dependencies)

## ✨ Key Features

### Course Management
-   [x] Browse available courses
-   [x] Search for specific courses
-   [x] Manage course enrollments
-   [x] Purchase courses
-   [x] View purchased courses

### User Authentication
-   [x] Secure sign-up
-   [x] Easy login with Firebase Authentication

### Payment Integration
-   [x] Smooth and secure payment process with Paymob

### Content Display
-   [x] Embedded video playback
-   [x] Dynamic content loading
-   [x] Efficient image caching

### Customization and UX
-   [x] Smooth animations and transitions
-   [x] Responsive UI design



## 📸 Demo
[Edu Vista Demo](https://drive.google.com/drive/u/0/folders/1ctOTkt5xmhGO-bCRY0Cc-EnJ3IhvKti3)



## 📸 Screenshots
<!-- Variables -->
[onboarding]: assets/screenshots/onboarding.jpg 'OnBoarding #1'
[onboarding2]: assets/screenshots/onboarding2.jpg 'Onboarding #2'
[onboarding3]: assets/screenshots/onboarding3.jpg 'Onboarding #3'
[onboarding4]: assets/screenshots/onboarding4.jpg 'OnBoarding #4'
[login]: assets/screenshots/login.jpg 'Login'
[home]: assets/screenshots/home.jpg 'Home'
[search]: assets/screenshots/search.jpg 'Search'
[profile]: assets/screenshots/profile.jpg 'Profile'
[cart]: assets/screenshots/cart.jpg 'Cart'
[paymob]: assets/screenshots/paymob.jpg 'Paymob'
[course]: assets/screenshots/course.jpg 'Course'
[video]: assets/screenshots/video.jpg 'Video'
[certificate]: assets/screenshots/certificate.jpg 'Course - Certificate'
[sign up]: assets/screenshots/signup.jpg 'Sign Up'
[reset password]: assets/screenshots/resetpassword.jpg 'Reset Password #1'
[reset password2]: assets/screenshots/resetpassword2.jpg 'Reset Password #2'
[edit profile]: assets/screenshots/editprofile.jpg 'Edit Profile'
[category courses]: assets/screenshots/categorycourses.jpg 'Category Courses #1'
[category courses2]: assets/screenshots/categorycourses2.jpg 'Category Courses #2'
[cart error]: assets/screenshots/carterror.jpg 'Cart Error'
[bought courses]: assets/screenshots/boughtcourses.jpg 'Bought Courses'
[my courses]: assets/screenshots/mycourses.jpg 'My Courses'
[course more]: assets/screenshots/coursemore.jpg 'Course - More'

### Onboarding and Authentication

|      OnBoarding #1       |      OnBoarding #2      |      OnBoarding #3      |
| :---------------: | :-------------: | :---------------: |
| ![OnBoarding #1][onboarding] | ![OnBoarding #2][onboarding2] | ![OnBoarding #3][onboarding3] |

|        OnBoarding #4        |       Login       |      Sign Up      |
| :---------------------: | :-----------------: | :---------------: |
| ![OnBoarding #4][onboarding4] | ![Login][login] | ![Sign Up][sign up] |

### Password Management and Home

|      Reset Password #1       |      Reset Password #2       |      Home       |
| :---------------: | :---------------: | :---------------: |
| ![Reset Password #1][reset password] | ![Reset Password #2][reset password2] | ![Home][home] |

### Profile and Search

|        Search        |       Profile       |      Edit Profile      |
| :---------------------: | :-----------------: | :---------------: |
| ![Search][search] | ![Profile][profile] | ![Edit Profile][edit profile] |

### Course and Cart Management

|      Category Courses #1       |      Category Courses #2       |      Cart       |
| :---------------: | :---------------: | :---------------: |
| ![Category Courses #1][category courses] | ![Category Courses #2][category courses2] | ![Cart][cart] |

|        Cart Error       |       Paymob       |      Bought Courses      |
| :---------------------: | :-----------------: | :---------------: |
| ![Cart Error][cart error] | ![Paymob][paymob] | ![Bought Courses][bought courses] |

### Course Content and Completion

|      My Courses       |      Course       |      Video       |
| :---------------: | :---------------: | :---------------: |
| ![My Courses][my courses] | ![Course][course] | ![Video][video] |

|      Course - More      |      Course - Certificate      |
| :---------------: | :---------------: |
| ![Course - More][course more] | ![Course - Certificate][certificate] |



## 📚 Dependencies

| Name                                                                                  | Version       | Description                                                                                                                                                              |
| ------------------------------------------------------------------------------------- | ------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| [device_preview](https://pub.dev/packages/device_preview)                                             | 1.1.0        | Helps ensure your app's UI looks great and functions well across different devices and screen sizes without needing to deploy it to physical devices. as it allows you to preview your app on various device screens and orientations directly from your development environment.  |
| [flutter_screenutil](https://pub.dev/packages/flutter_screenutil)                                                 | 5.9.3       |  A popular package for building a responsive UI that adapts to different screen sizes and resolutions.                                                                                                                        |
| [flutter_bloc](https://pub.dev/packages/flutter_bloc)                                 | 8.1.6        | It Manages app state using the BLoC (Business Logic Component) pattern, promoting separation of business logic from UI.                                                                                                                                |
| [shared_preferences](https://pub.dev/packages/shared_preferences)                                     | 2.2.3       | It Stores simple data persistently across app launches, such as user preferences and settings.                                                                                                                                 |
| [firebase_core](https://pub.dev/packages/firebase_core)               | 3.3.0 | It's essential for integrating firebase services, as it initializes them in the app.                                                                                              |
| [firebase_auth](https://pub.dev/packages/firebase_auth)                                             | 2.1.0       |  Handles user authentication securely and efficiently, supporting various methods such as email/password and social logins.                                         |
| [cloud_firestore](https://pub.dev/packages/cloud_firestore)                                             | 5.2.1       |  This package manages and retrieves data in real-time using a NoSQL cloud database.                                         |
| [firebase_storage](https://pub.dev/packages/firebase_storage)                                             | 12.2.0       |  It Provides a secure and scalable way to handle file storage, such as images, videos, and other user content.                                       |
| [file_picker](https://pub.dev/packages/file_picker)               | 8.0.5 | It allows users to select files from their device storage..                                                                                              |
| [flutter_dotenv](https://pub.dev/packages/flutter_dotenv)                                             | 5.1.0      |  It Keeps sensitive information like API keys secure and separate from the source code.                                        |
| [url_launcher](https://pub.dev/packages/url_launcher)                                             | 6.3.0       |  It Allows users to open external links easily.                                         |
| [youtube_player_flutter](https://pub.dev/packages/youtube_player_flutter)                                             | 8.1.2      |  It Provides a youtube IFrame Within your app.                                        |
| [cached_network_image](https://pub.dev/packages/cached_network_image)                                           | 3.4.0         | It stores loaded images from the web in its cache directory, reducing the need for frequent network requests. This improves performance and ensures images are available even when the device is offline.                                                                                                                           | | [paymob_payment](https://pub.dev/packages/paymob_payment)                                           | 0.0.1+1        | Integrates Paymob’s payment gateway to handle transactions securely and efficiently.                                                                                                                           |
| [animated_rating_stars](https://pub.dev/packages/animated_rating_stars)                                           | 1.0.1       | Offers animated star rating widgets for engaging course ratings.                                                                                                                           |

