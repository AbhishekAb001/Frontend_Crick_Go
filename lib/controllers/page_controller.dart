import 'dart:developer';

import 'package:get/get.dart';

class PageNavigationController extends GetxController {
  final RxInt index = 0.obs;
  final RxInt subIndex = (-1).obs;
  final RxMap<String, dynamic> data = <String, dynamic>{}.obs;

  void navigateToMain(int mainIndex) {
    index.value = mainIndex;
    subIndex.value = -1;
  }

  void navigateToSubWithData(
      int mainIndex, int subPageIndex, Map<String, dynamic> data) {
    index.value = mainIndex;
    subIndex.value = subPageIndex;
    this.data.clear();
    this.data.addAll(data);
  }

  void navigateToSub(int mainIndex, int subPageIndex) {
    index.value = mainIndex;
    subIndex.value = subPageIndex;
  }
}
