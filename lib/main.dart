//import 'dart:js';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job/constants/app_constants.dart';
import 'package:job/controllers/chat_provider.dart';
import 'package:job/controllers/exports.dart';
import 'package:job/firebase_options.dart';
import 'package:job/views/ui/auth/login.dart';
import 'package:job/views/ui/mainscreen.dart';
import 'package:job/views/ui/onboarding/onboarding_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import 'views/common/exports.dart';

Widget defaultHome = const OnBoardingScreen();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final SharedPreferences prefs = await SharedPreferences.getInstance();

  final entryPoint = prefs.getBool('entrypoint') ?? false;

  final loggedIn = prefs.getBool('loggedIn') ?? false;

  if (entryPoint & !loggedIn) {
    defaultHome = const LoginPage();
  } else if (entryPoint && loggedIn) {
    defaultHome = const MainScreen();
  }

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => OnBoardNotfier()),
    ChangeNotifierProvider(create: (context) => LoginNotifier()),
    ChangeNotifierProvider(create: (context) => ZoomNotifire()),
    ChangeNotifierProvider(create: (context) => JobNotifire()),
    ChangeNotifierProvider(create: (context) => BookMarNotifier()),
    ChangeNotifierProvider(create: (context) => ImageUploader()),
    ChangeNotifierProvider(create: (context) => ProfileNotifier()),
    ChangeNotifierProvider(create: (context) => ChatNotifier()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        useInheritedMediaQuery: true,
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Job App",
            theme: ThemeData(
                scaffoldBackgroundColor: Color(kLight.value),
                iconTheme: IconThemeData(color: Color(kDark.value)),
                primarySwatch: Colors.grey),
            home: defaultHome,
          );
        });
  }
}
