import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/state_manager.dart';
import 'package:hocky_game/common/image_res.dart';
import 'package:hocky_game/screen/play_demo.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../common/utils.dart';
import '../../model/consumer_model.dart';
import '../../model/item_model.dart';
import '../game_over/game_over_screen.dart';


class PlayGameController extends GetxController {

  BuildContext? context;
  ItemScrollController scrollController = ItemScrollController();
  ScrollController listScroll1 = ScrollController();
  ScrollController listScroll2 = ScrollController();
  ScrollController listScroll3 = ScrollController();
  double jumpValue = 0;
  Timer? indexPlush;
  bool redirection = true;
  RxInt scroreShow = 0.obs;
  AudioPlayer playerBg = AudioPlayer();
  AudioPlayer gameOverMusic = AudioPlayer();
  bool isPlayerStop = false;


  final List<Customer> people = [
    Customer(
      name: 'Makayla',
      bucketIndex: "1",
      imageProvider: const NetworkImage('https://flutter'
          '.dev/docs/cookbook/img-files/effects/split-check/Avatar1.jpg'),
    ),
    Customer(
      name: 'Nathan',
      bucketIndex: "2",
      imageProvider: const NetworkImage('https://flutter'
          '.dev/docs/cookbook/img-files/effects/split-check/Avatar2.jpg'),
    ),
    Customer(
      name: 'Emilio',
      bucketIndex: "3",
      imageProvider: const NetworkImage('https://flutter'
          '.dev/docs/cookbook/img-files/effects/split-check/Avatar3.jpg'),
    ),
  ];

  List<Item> items1 = [];
  List<Item> items2 = [];
  List<Item> items3 = [];



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  autoScroller() {
    indexPlush = Timer.periodic(const Duration(seconds: 1), (timer) {
      jumpValue += 40;
      listScroll1.jumpTo(jumpValue);
      listScroll2.jumpTo(jumpValue);
      listScroll3.jumpTo(jumpValue);

    });
  }

  randomArrayGenerate(List<Item> itemsArray,int arrayIndex) {

    for(int i = 0; i<=200; i++) {
      int random = Random().nextInt(12 - 1);
      if(random == 1 || random == 6 || random == 7 || random == 8 || random == 9 || random == 10 || random == 11 || random == 12) {
        //print("Empty");
        itemsArray.add( Item(
              name: 'transparentImg',
              totalPriceCents: 1299,
              uid: i.toString(),
              boxId: '5',
              listNumber:arrayIndex,
              imageProvider: AssetImage(ImageRes.transparentImg),
            ),);
      } else if(random == 2) {
        //print("bottle");
        itemsArray.add( Item(
          name: 'bottleF',
          totalPriceCents: 1299,
          uid: i.toString(),
          boxId: '1',
          listNumber:arrayIndex,
          imageProvider: AssetImage(ImageRes.bottleF),
        ),);
      } else if(random == 3) {
        //print("wood");
        itemsArray.add( Item(
          name: 'wood',
          totalPriceCents: 1299,
          uid: i.toString(),
          boxId: '2',
          listNumber:arrayIndex,
          imageProvider: AssetImage(ImageRes.wood),
        ),);
      } else if(random == 4) {
        //print("bottle1");
        itemsArray.add( Item(
          name: 'bottle',
          totalPriceCents: 1299,
          uid: i.toString(),
          boxId: '3',
          listNumber:arrayIndex,
          imageProvider: AssetImage(ImageRes.bottle),
        ),);
      } else if(random == 5) {
        //print("crack");
        itemsArray.add( Item(
          name: 'crack',
          totalPriceCents: 1299,
          uid: i.toString(),
          boxId: '4',
          listNumber:arrayIndex,
          imageProvider: AssetImage(ImageRes.crack),
        ),);
      } else {
        //print("empty 123");
        itemsArray.add( Item(
          name: 'transparentImg',
          totalPriceCents: 1299,
          uid: i.toString(),
          boxId: '5',
          listNumber:arrayIndex,
          imageProvider: AssetImage(ImageRes.transparentImg),
        ),);
      }


    }

    for(int a = 0; a < 3; a++){
      itemsArray.insert(0,Item(
        name: 'transparentImg',
        totalPriceCents: 1299,
        uid: "250${a}",
        boxId: '5',
          listNumber: arrayIndex,
        imageProvider: AssetImage(ImageRes.transparentImg),
      ));
    }

  }

  gameOverTimeCall(BuildContext context){
    if(redirection){
      Future.delayed(Duration.zero, () async {

        isPlayerStop = true;
        playerBg.stop();
        playerBg.dispose();

        gameOverMusic.play(AssetSource(ImageRes.gameOverS));

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>GameOverScreen(recentScore: scroreShow.value,)));
        redirection = false;
        jumpValue=0;

        int tempScore =await Utils.getIntData();
        if(scroreShow.value > tempScore){
          Utils.setIntData(scroreShow.value);
        }
      });
    }

  }

  @override
  void dispose() {
    // TODO: implement dispose
    isPlayerStop = true;
    playerBg.stop();
    playerBg.dispose();
    gameOverMusic.stop();
    gameOverMusic.dispose();
    super.dispose();
  }
}