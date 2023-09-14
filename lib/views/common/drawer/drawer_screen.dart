import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:job/constants/app_constants.dart';
import 'package:job/controllers/exports.dart';
import 'package:job/views/common/app_style.dart';
import 'package:job/views/common/reusable_text.dart';
import 'package:job/views/common/width_spacer.dart';
import 'package:provider/provider.dart';

class DrawerScreen extends StatefulWidget {
  final ValueSetter indexSetter;
  const DrawerScreen({super.key, required this.indexSetter});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ZoomNotifire>(builder: (context, zoomNotifire, child){
      return GestureDetector(
         onDoubleTap: (){
          ZoomDrawer.of(context)!.toggle();
         },
         child: Scaffold(
          backgroundColor: Color(kLightBlue.value),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              drawerItem(
                 Icons.import_contacts_sharp,
                "Home",
                0,
                zoomNotifire.currentIndex == 0 ? Color(kLight.value) : Color(kLightGrey.value)
              ),

              drawerItem(
                // const Icon(Icons.home),
                Icons.import_contacts_sharp,
                "chat",
                1,
                zoomNotifire.currentIndex == 1 ? Color(kLight.value) : Color(kLightGrey.value)
              ),
              drawerItem(
                 Icons.import_contacts_sharp,
                "Jobs",
                2,
                zoomNotifire.currentIndex == 2 ? Color(kLight.value) : Color(kLightGrey.value)
              ),
              drawerItem(
                Icons.import_contacts_sharp,
                "Home",
                3,
                zoomNotifire.currentIndex == 3 ? Color(kLight.value) : Color(kLightGrey.value)
              ),
            ],
          ),
         )
      );
    }
    );
  }

   Widget drawerItem(IconData icon, String text, int index, Color color){
    return GestureDetector(
        onTap: (){
          widget.indexSetter(index);
        },
        child: Container(
          margin: EdgeInsets.only(left: 20.w, bottom: 20.h),
          child: Row(
            children: [
              Icon(
                icon,
                color: color,
              ),
              const WidthSpacer(width : 12),
              ReusableText(text: text, style: appstyle(12, color, FontWeight.bold))
            ],
          ),
        ),
    );
   }

}