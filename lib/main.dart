import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:rentcartest/host/host_analytics.dart';
import 'package:rentcartest/host/host_image.dart';
import 'package:rentcartest/user/addcar.dart';
import 'package:rentcartest/user/favourite.dart';
import 'package:rentcartest/user/global.dart';
import 'package:rentcartest/user/home.dart';
import 'package:rentcartest/user/navbar.dart';
import 'package:rentcartest/user/new.dart';
import 'package:rentcartest/user/theme.dart';
import 'package:rentcartest/user/trips.dart';

import 'host/host_bio.dart';
import 'host/host_eligibility.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
          title: 'Flutter Demo',
          theme: theme(),
          navigatorKey: navigatorKey,
          //home: HostNav()
          initialRoute: '/',
          routes: {
            '/': (context) => UserRegistrationPage(),
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
            '/bio': (context) {
              final arguments = ModalRoute.of(context)!.settings.arguments
                  as Map<String, String?>; // Make sure the cast is correct
              return HostBio(arguments: arguments);
            },
            '/image': (context) {
              final arguments = ModalRoute.of(context)!.settings.arguments
                  as Map<String, String?>; // Make sure the cast is correct
              return Hostimg(arguments: arguments);
            },

            '/add_car': (context) {
              final arguments = ModalRoute.of(context)!.settings.arguments
                  as Map<String, String>;
              return HostEli(arguments: arguments);
            },
          }

          // BackTest()
          // We use routeName so that we dont need to remember the name
          //initialRoute: SplashScreen.routeName,
          //routes: routes,
          ),
    );
  }
}
