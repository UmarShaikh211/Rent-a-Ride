import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:rentcartest/Admin/adminpanel.dart';
import 'package:rentcartest/host/host_analytics.dart';
import 'package:rentcartest/host/host_image.dart';
import 'package:rentcartest/screens/splash/splash_screen.dart';
import 'package:rentcartest/user/Userlogin/pages/registert.dart';
import 'package:rentcartest/user/addnotification.dart';
import 'package:rentcartest/user/favourite.dart';
import 'package:rentcartest/user/global.dart';
import 'package:rentcartest/user/home.dart';
import 'package:rentcartest/user/navbar.dart';
import 'package:rentcartest/user/new.dart';
import 'package:rentcartest/user/routes.dart';
import 'package:rentcartest/user/theme.dart';
import 'package:rentcartest/user/trips.dart';
import 'package:rentcartest/user/umar.dart';

import 'firebase_options.dart';
import 'host/host_bio.dart';
import 'host/host_eligibility.dart';
import 'package:firebase_core/firebase_core.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
//const String globalapiUrl = 'http://172.20.10.3:8000/'; //Umar
const String globalapiUrl = 'http://192.168.0.120:8000';

final ThemeData myTheme = ThemeData(
  primaryColor: Color.fromRGBO(254, 205, 59, 1.0),
  // Define your primary color
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();
  Hive.registerAdapter(BookingStatusAdapter()); // Register your adapter
  Hive.registerAdapter(FavoriteCarAdapter());
  // Register the adapter
  // Other initialization code
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserDataProvider>(
          create: (context) => UserDataProvider(),
        ),
        ChangeNotifierProvider<BookingStatusProvider>(
          create: (context) => BookingStatusProvider(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Rent-a-Ride',
          theme: myTheme,
          navigatorKey: navigatorKey,
          // // home: AdminDashboard()
          //  initialRoute: SplashScreen.routeName,
          //  routes: routes,
          initialRoute: '/',
          routes: {
            '/': (context) => SplashScreen(),

            // '/hregister': (context) => UserRegistrationPage(),
            // '/ccreate': (context) =>
            //     CarAdd(ModalRoute.of(context)!.settings.arguments as String),
            // '/car_creation': (context) => CarCreationPage(
            //     ModalRoute.of(context)!.settings.arguments as String),
            // '/notification': (context) {
            //   final arguments = ModalRoute.of(context)!.settings.arguments
            //       as Map<String, String?>; // Make sure the cast is correct
            //   return NotificationPage(arguments: arguments);
            // },
            '/trips': (context) => Trip(), // Define the /favourite route
            // '/bio': (context) {
            //   final arguments = ModalRoute.of(context)!.settings.arguments
            //       as Map<String, String?>; // Make sure the cast is correct
            //   return HostBio(arguments: arguments);
            // },

            '/add_car': (context) {
              final arguments = ModalRoute.of(context)!.settings.arguments
                  as Map<String, String>;
              return HostEli(arguments: arguments);
            },
          }

          // BackTest()
          // We use routeName so that we dont need to remember the name
          ),
    );
  }
}
