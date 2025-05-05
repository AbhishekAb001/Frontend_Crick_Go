import 'dart:developer';

import 'package:cricket_management/service/auth_sharedP_service.dart';
import 'package:get/get.dart';
import 'dart:convert';

class ProfileController extends GetxController {
  final RxMap<String, dynamic> profileData = <String, dynamic>{}.obs;

  @override
  void onInit() {
    super.onInit();
    log("name user ");
    loadProfileData();
  }

  void loadProfileData() async {
    await AuthSharedP().getProfileData().then((value) {
      profileData.addAll(value);
    });
    log("name user $profileData");
  }

  Future<void> updateProfileData(String key, dynamic value) async {
    profileData[key] = value;
  }

  Future<void> setProfileData(Map<String, dynamic> data) async {
    profileData.clear();
    profileData.addAll(data);
  }
}
