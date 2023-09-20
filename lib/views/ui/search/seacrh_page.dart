import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:job/constants/app_constants.dart';
import 'package:job/views/common/custom_field.dart';
import 'package:job/views/common/reusable_text.dart';

import '../../common/app_style.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(kOrange.value),
        iconTheme: IconThemeData(color: Color(kLight.value)),
        title: CustomField(
          controller: search,
          hintText: "Seach for a job",
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {});
            },
            child: const Icon(AntDesign.search1),
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.h),
        child: Column(
          children: [
            Image.asset("assets/images/search_cart.png"),
            ReusableText(
                text: "Start Search for jobs",
                style: appstyle(24, Color(kDark.value), FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
