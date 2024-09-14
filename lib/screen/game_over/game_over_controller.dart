import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/state_manager.dart';

import '../../common/utils.dart';


class GameOverController extends GetxController {

  BuildContext? context;
  RxInt gameScore = 0.obs;
  RxBool refreshData = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();
  }

}