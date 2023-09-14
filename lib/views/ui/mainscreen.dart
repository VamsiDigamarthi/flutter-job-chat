

import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:job/constants/app_constants.dart';
import 'package:job/controllers/exports.dart';
import 'package:job/views/common/drawer/drawer_screen.dart';
import 'package:job/views/ui/chat/chatpage.dart';
import 'package:job/views/ui/homepage.dart';
import 'package:provider/provider.dart';

import 'jobs/job_page.dart';

// import 'jobs/job_page.dart';

// import 'package:job/views/ui/jobs/job_page.dart'

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ZoomNotifire>(builder: (context, zoomNotifire, child){
      return ZoomDrawer(
      menuScreen : DrawerScreen(
        indexSetter: (index){
          zoomNotifire.currentIndex = index;
        },
      ),
      mainScreen : currentScreen(),
      borderRadius : 30,
      showShadow : true,
      angle : 0.0,
      slideWidth : 250,
      menuBackgroundColor : Color(kLightBlue.value),
    );
    });
  }

  Widget currentScreen(){
    var zoomNotifire = Provider.of<ZoomNotifire>(context);

    switch (zoomNotifire.currentIndex){
      case 0 :
        return const HomePage();
      case 1 :
        return const ChatsPage();
      case 2 :
        return const JobPage(title: "Jobs", id: "2",);
      case 3 :
        return const HomePage();
      case 4 :
        return const HomePage();
      default :
        return const HomePage();
    }
    
  }


  
}