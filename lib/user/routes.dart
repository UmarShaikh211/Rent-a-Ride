import 'package:flutter/widgets.dart';
import 'package:rentcartest/user/home.dart';
import 'package:rentcartest/user/navbar.dart';
import 'package:rentcartest/screens/sign_in/sign_in_screen.dart';
import 'package:rentcartest/screens/sign_up/sign_up_screen.dart';
import 'package:rentcartest/screens/splash/splash_screen.dart';

import 'package:rentcartest/screens/complete_profile/complete_profile_screen.dart';
import 'package:rentcartest/screens/forgot_password/forgot_password_screen.dart';
import 'package:rentcartest/screens/otp/otp_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  OtpScreen.routeName: (context) => OtpScreen(),
  bottomnav.routeName: (context) => bottomnav(),
};
