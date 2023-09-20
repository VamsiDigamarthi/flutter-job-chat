import 'package:flutter/material.dart';
import 'package:job/models/response/auth/profile_model.dart';
import 'package:job/services/helpers/auth_helpers.dart';

class ProfileNotifier extends ChangeNotifier {
  late Future<ProfileRes>? profile;

  getProfile() async {
    profile = AuthHelper.getProfile();
  }
}
