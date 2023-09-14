

//import 'dart:js';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job/constants/app_constants.dart';
import 'package:job/controllers/exports.dart';
import 'package:job/views/ui/onboarding/onboarding_screen.dart';
import 'package:provider/provider.dart';

//import 'views/common/exports.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
     MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => OnBoardNotfier()),
        ChangeNotifierProvider(create: (context)=> LoginNotifier()),
        ChangeNotifierProvider(create: (context) => ZoomNotifire()),
        ChangeNotifierProvider(create: (context) => JobNotifire()),
        ChangeNotifierProvider(create: (context) => BookMarNotifier()),
        ChangeNotifierProvider(create: (context) => ImageUploader()),
        ChangeNotifierProvider(create: (context) => ProfileNotifier()),

      ],
      child: const MyApp())
  );
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
                  primarySwatch: Colors.grey
                 ),
                 home: const OnBoardingScreen(),
          );
      }
      
      );
    
  }
}