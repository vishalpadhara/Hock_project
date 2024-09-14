import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:hocky_game/common/color_res.dart';
import 'package:hocky_game/common/image_res.dart';
import 'package:hocky_game/common/string_res.dart';
import 'package:hocky_game/common/utils.dart';
import 'package:hocky_game/screen/game_over/game_over_controller.dart';
import 'package:hocky_game/screen/home/home_screen.dart';
import 'package:hocky_game/screen/play_game/play_game_screen.dart';

class GameOverScreen extends StatefulWidget {
  GameOverScreen({Key? key,required this.recentScore}) : super(key: key);
  final int recentScore;
  @override
  State<GameOverScreen> createState() => _GameOverScreenState();
}

class _GameOverScreenState extends State<GameOverScreen> {

  GameOverController gameOverController = Get.put(GameOverController());

  @override
  void initState() {
    // TODO: implement initState
    gameOverController.gameScore.value =widget.recentScore;
  super.initState();
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
              Positioned(
                  right: 0,
                  top: 0,
                  child: Image.asset(ImageRes.rightBottle, height: Utils.getDeviceHeight(context) / 3),
              ),
              Align (
                  alignment: Alignment.centerLeft,
                  child: Image.asset(ImageRes.leftWood, height: Utils.getDeviceHeight(context) / 3)
              ),
              Column(
                children: [
                  gameOverTitle(),
                  const SizedBox(height: 40),
                  Obx(()=>
                  gameOverController.refreshData.value
                      ?
                  Text(StringRes.score + gameOverController.gameScore.value.toString(), style: TextStyle(color: ColorRes.primaryColor, fontSize: 35, fontWeight: FontWeight.w700))
                      :Text(StringRes.score + gameOverController.gameScore.value.toString(), style: TextStyle(color: ColorRes.primaryColor, fontSize: 35, fontWeight: FontWeight.w700)),


                  ),
                  Spacer(),
                  playAgainBtn(),
                  mainMenuBtn(),
                  const SizedBox(height: 40)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget playAgainBtn() {
    return InkWell (
      onTap: () {
        Future.delayed(Duration.zero, () {
          Utils.musicPlayOnClick();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const PlayGameScreen()));
        });
      },
      child: Container (
          height: 55,
          width: Utils.getDeviceWidth(context),
          margin: const EdgeInsets.only(left: 20, right: 20, top: 40),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(ImageRes.buttonBg50), fit: BoxFit.fill
              )
          ),
          child: Text(StringRes.playAgain, style: const TextStyle(color: ColorRes.white, fontSize: 25, fontWeight: FontWeight.w700))
      ),
    );
  }

  Widget mainMenuBtn() {
    return InkWell(
      onTap: () {
        Future.delayed(Duration.zero, () {
          Utils.musicPlayOnClick();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
        });
      },
      child: Container (
          height: 55,
          width: Utils.getDeviceWidth(context),
          margin: const EdgeInsets.only(left: 20, right: 20, top: 40),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(ImageRes.buttonBg50), fit: BoxFit.fill
              )
          ),
          child: Text(StringRes.mainMenu, style: const TextStyle(color: ColorRes.white, fontSize: 25, fontWeight: FontWeight.w700))
      ),
    );
  }

  Widget gameOverTitle() {
    return   Container (
        height: 125,
        width: Utils.getDeviceWidth(context),
        margin: const EdgeInsets.only(left: 20, right: 20, top: 40),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImageRes.gameOverBg), fit: BoxFit.fill
            )
        ),
        child: Text(StringRes.gameOver, style: const TextStyle(color: ColorRes.white, fontSize: 25, fontWeight: FontWeight.w700))
    );
  }


}
