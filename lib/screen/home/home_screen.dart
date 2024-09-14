import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:hocky_game/common/color_res.dart';
import 'package:hocky_game/common/image_res.dart';
import 'package:hocky_game/common/string_res.dart';
import 'package:hocky_game/common/utils.dart';
import 'package:hocky_game/screen/home/home_controller.dart';
import 'package:hocky_game/screen/play_demo.dart';
import 'package:hocky_game/screen/play_game/play_game_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeScreenController = Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    getScoreData();
    super.initState();
  }

  void getScoreData() async{
    homeScreenController.gameScore.value = await Utils.getIntData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Utils.getDeviceHeight(context),
        width: Utils.getDeviceWidth(context),
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage(ImageRes.bfImg), fit: BoxFit.fill)),
        child: SafeArea(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [

              Container (
                  height: 55,
                  width: Utils.getDeviceWidth(context),
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 40),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(ImageRes.buttonBg50), fit: BoxFit.fill
                      )
                  ),
                  child: Obx(()=>

                  homeScreenController.refreshData.value
                      ?Text(StringRes.bestScore + " ${homeScreenController.gameScore.value}", style: const TextStyle(color: ColorRes.white, fontSize: 25, fontWeight: FontWeight.w700))
                      :Text(StringRes.bestScore + " ${homeScreenController.gameScore.value}", style: const TextStyle(color: ColorRes.white, fontSize: 25, fontWeight: FontWeight.w700))
              )),

              Center(
                child: InkWell(
                   highlightColor: ColorRes.transparent,
                    splashColor: ColorRes.transparent,
                  onTap: () {
                    Utils.musicPlayOnClick();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const PlayGameScreen()));
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => const ExampleDragAndDrop()));
                  },
                  child: Image.asset(
                      ImageRes.playImg,
                      height: Utils.getDeviceWidth(context) / 2,
                      width: Utils.getDeviceWidth(context) / 2,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
