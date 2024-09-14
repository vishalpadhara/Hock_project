import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:hocky_game/common/color_res.dart';
import 'package:hocky_game/common/image_res.dart';
import 'package:hocky_game/common/string_res.dart';
import 'package:hocky_game/common/utils.dart';
import 'package:hocky_game/screen/play_demo.dart';
import 'package:hocky_game/screen/play_game/play_game_controller.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:lottie/lottie.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../model/consumer_model.dart';
import '../../model/item_model.dart';


class PlayGameScreen extends StatefulWidget {
  const PlayGameScreen({Key? key}) : super(key: key);

  @override
  State<PlayGameScreen> createState() => _PlayGameScreenState();
}

class _PlayGameScreenState extends State<PlayGameScreen> {

  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  PlayGameController playGameController = Get.put(PlayGameController());
  final GlobalKey _draggableKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    playGameController.isPlayerStop = false;
    playGameController.listScroll1 = ScrollController();
    playGameController.listScroll2 = ScrollController();
    playGameController.listScroll3 = ScrollController();
    //scrollerIndexWise();

    playGameController.autoScroller();
    playGameController.redirection = true;

    playGameController.items1.clear();
    playGameController.items2.clear();
    playGameController.items3.clear();


    playGameController.randomArrayGenerate(playGameController.items1,1);
    playGameController.randomArrayGenerate(playGameController.items2,2);
    playGameController.randomArrayGenerate(playGameController.items3,3);

    playGameController.playerBg.play(AssetSource(ImageRes.gameBgS));
    playGameController.playerBg.onPlayerComplete.listen((event) {
      if(!playGameController.isPlayerStop) {
        playGameController.playerBg.play(AssetSource(ImageRes.gameBgS));
      }
    });

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    playGameController.indexPlush!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        playGameController.playerBg.stop();
        playGameController.playerBg.dispose();
        return true;
      },
      child: Scaffold (
        body: Container(
          height: Utils.getDeviceHeight(context),
          width: Utils.getDeviceWidth(context),
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage(ImageRes.bfImg), fit: BoxFit.fill)),
          child: SafeArea(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [

                Container (
                  width: Utils.getDeviceWidth(context),
                  // color: Colors.red,
                  margin: const EdgeInsets.only(top: 80, bottom: 10),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      listView1(),
                      listView2(),
                      listView3(),

                    ],
                  ),
                ),

                Container (
                    height: 50,
                    width: Utils.getDeviceWidth(context),
                    padding: EdgeInsets.only(left: 10, right: 10),
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 40),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(ImageRes.buttonBg50), fit: BoxFit.fill
                        )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(StringRes.score + " ${playGameController.scroreShow.value}", style: const TextStyle(color: ColorRes.white, fontSize: 18, fontWeight: FontWeight.w700)),
                        Row(
                          children: [
                            likeImageShow(ImageRes.desLikeImg),
                            SizedBox(width: 10),
                            likeImageShow(ImageRes.like),
                            SizedBox(width: 10),
                            likeImageShow(ImageRes.like),
                            SizedBox(width: 10),
                          ],
                        )
                      ],
                    )
                ),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 70,
                    width: Utils.getDeviceWidth(context),
                    // color: Colors.lightGreen,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // SizedBox(width: 15),
                        _buildPersonWithDropZone(playGameController.people[0]),
                        // SizedBox(width: 15),
                        _buildPersonWithDropZone(playGameController.people[1]),
                        // SizedBox(width: 15),
                        _buildPersonWithDropZone(playGameController.people[2]),
                        // SizedBox(width: 15),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  listView1(){
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: InViewNotifierList (
          scrollDirection: Axis.vertical,
          initialInViewIds: ['0'],
          reverse: true,
          physics: NeverScrollableScrollPhysics(),
          controller: playGameController.listScroll1,
          isInViewPortCondition: (double deltaTop, double deltaBottom, double viewPortDimension) {
            return deltaTop < (0.1 * viewPortDimension) && deltaBottom > (0.1 * viewPortDimension);

          },
          itemCount: playGameController.items1.length,
          builder: (BuildContext context, int index) {
            return Container(
              width: double.infinity,
              height: 120.0,
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(vertical: 1.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      return InViewNotifierWidget(
                        id: '$index',
                        builder: (BuildContext context, bool isInView, Widget? child) {

                          if(isInView) {
                            if(playGameController.items1[index].boxId == "2" || playGameController.items1[index].boxId == "3"){
                              print("Game Over 1");
                              Future.delayed(Duration(seconds: 1), () {
                                playGameController.gameOverTimeCall(context);
                              });
                            }
                          }
                          return _buildMenuItem(
                            item: playGameController.items1[index],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  listView2(){
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: InViewNotifierList (
          scrollDirection: Axis.vertical,
          initialInViewIds: ['0'],
          reverse: true,
          physics: NeverScrollableScrollPhysics(),
          controller: playGameController.listScroll2,
          isInViewPortCondition: (double deltaTop, double deltaBottom, double viewPortDimension) {
            return deltaTop < (0.1 * viewPortDimension) && deltaBottom > (0.1 * viewPortDimension);

          },
          itemCount: playGameController.items2.length,
          builder: (BuildContext context, int index) {
            return Container(
              width: double.infinity,
              height: 120.0,
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(vertical: 1.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      return InViewNotifierWidget(
                        id: '$index',
                        builder: (BuildContext context, bool isInView, Widget? child) {

                          if(isInView){
                            if(playGameController.items2[index].boxId == "1" || playGameController.items2[index].boxId == "3"){
                              print("Game Over 2");
                              Future.delayed(Duration(seconds: 1), () {
                                playGameController.gameOverTimeCall(context);
                              });
                            }
                          }
                          return _buildMenuItem(
                            item: playGameController.items2[index],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  listView3(){
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: InViewNotifierList (
          scrollDirection: Axis.vertical,
          initialInViewIds: ['0'],
          reverse: true,
          physics: NeverScrollableScrollPhysics(),
          controller: playGameController.listScroll3,
          isInViewPortCondition: (double deltaTop, double deltaBottom, double viewPortDimension) {
            return deltaTop < (0.1 * viewPortDimension) && deltaBottom > (0.1 * viewPortDimension);

          },
          itemCount: playGameController.items3.length,
          builder: (BuildContext context, int index) {
            return Container(
              width: double.infinity,
              height: 120.0,
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(vertical: 1.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      return InViewNotifierWidget(
                        id: '$index',
                        builder: (BuildContext context, bool isInView, Widget? child) {

                          if(isInView){
                            if(playGameController.items3[index].boxId == "2" || playGameController.items3[index].boxId == "1"){
                              print("Game Over 3");
                              Future.delayed(Duration(seconds: 1), () {
                                playGameController.gameOverTimeCall(context);
                              });
                            }
                          }
                          return _buildMenuItem(
                            item: playGameController.items3[index],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }


  Widget _buildPersonWithDropZone(Customer customer) {
    return Container(
      // flex: 1,
      // width: ,
      // color: Colors.deepPurple,
      alignment: Alignment.center,
      child: DragTarget<Item>(
        builder: (context, candidateItems, rejectedItems) {

          if(customer.bucketIndex == "1") {
            return imageShow(ImageRes.bucket1);
          } else if(customer.bucketIndex == "2") {
            return imageShow(ImageRes.bucket2);
          } else if(customer.bucketIndex == "3"){
            return imageShow(ImageRes.bucket3);
          } else {
            return SizedBox();
          }
        },
        onAccept: (item) {
          _itemDroppedOnCustomerCart(
            item: item,
            customer: customer,
          );
        },
      ),
    );
  }



  Widget imageShow(String imageName) {
    return Container(
      height: 70,
      child: Stack(
        children: [
          Image.asset(imageName),
          //BlastPage(),
        ],
      ),
    );
  }

  void _itemDroppedOnCustomerCart({
    required Item item,
    required Customer customer,
  }) {

    if(item.boxId == customer.bucketIndex) {
      setState(() {
        customer.items.add(item);
      });
      print("Success Match");

      playGameController.scroreShow.value += 1;

      if(item.listNumber == 1){
        int tempIndex = playGameController.items1.indexWhere((element) => element.uid == item.uid.toString());
        if(tempIndex != -1){

          playGameController.items1.removeAt(tempIndex);
          playGameController.items1.insert(tempIndex, Item(
            name: 'transparentImg',
            totalPriceCents: 1299,
            uid: "1",
            boxId: '5',
            listNumber:1,
            imageProvider: AssetImage(ImageRes.transparentImg),
          ),);
        }
      }else if(item.listNumber == 2){
        int tempIndex = playGameController.items2.indexWhere((element) => element.uid == item.uid.toString());
        if(tempIndex != -1){
          playGameController.items2.removeAt(tempIndex);

          playGameController.items2.insert(tempIndex, Item(
            name: 'transparentImg',
            totalPriceCents: 1299,
            uid: "1",
            boxId: '5',
            listNumber:2,
            imageProvider: AssetImage(ImageRes.transparentImg),
          ),);


        }
      }else if(item.listNumber == 3){
        int tempIndex = playGameController.items3.indexWhere((element) => element.uid == item.uid.toString());
        if(tempIndex != -1){
          playGameController.items3.removeAt(tempIndex);
          playGameController.items3.insert(tempIndex, Item(
            name: 'transparentImg',
            totalPriceCents: 1299,
            uid: "1",
            boxId: '5',
            listNumber:3,
            imageProvider: AssetImage(ImageRes.transparentImg),
          ),);
        }
      }
    } else {
      print("Game over 123");

      Future.delayed(Duration(seconds: 1), () {
        playGameController.redirection=true;;
        playGameController.gameOverTimeCall(context);
      });


    }
  }

  Widget likeImageShow(String title) {
    return Image.asset(title, height: 20);
  }


  Widget _buildMenuItem({
    required Item item,
  }) {
    return Draggable<Item>(
      data: item,
      dragAnchorStrategy: pointerDragAnchorStrategy,
      feedback: DraggingListItem(
        dragKey: _draggableKey,
        photoProvider: item.imageProvider,
      ),
      childWhenDragging: SizedBox(),
      // item.imageProvider.assetName
      child:
      MenuListItem(
        name: item.name,
        price: item.formattedTotalItemPrice,
        photoProvider: item.imageProvider,
      ),
    );
  }
}




class TopToBottomImage extends StatefulWidget {
final String imageUrl;
final double height;
final double width;

TopToBottomImage({
  required this.imageUrl,
  required this.height,
  required this.width,
});

@override
_TopToBottomImageState createState() => _TopToBottomImageState();
}

class _TopToBottomImageState extends State<TopToBottomImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);
    _animation = Tween<Offset>(begin: Offset.zero, end: Offset(0, 1))
        .animate(_animationController);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: Image.network(
        widget.imageUrl,
        height: widget.height,
        width: widget.width,
      ),
    );
  }
}


class BucketCatchAnimation extends StatefulWidget {
  final String imageUrl;
  final double imageSize;

  BucketCatchAnimation({required this.imageUrl, required this.imageSize});

  @override
  _BucketCatchAnimationState createState() => _BucketCatchAnimationState();
}

class _BucketCatchAnimationState extends State<BucketCatchAnimation> {
  late double _bucketTop;
  late double _bucketLeft;

  bool _isImageCaught = false;

  @override
  void initState() {
    super.initState();
    // Set initial position of bucket
    _bucketTop = 300;
    _bucketLeft = 200;
  }

  void _onImageCaught() {
    setState(() {
      _isImageCaught = true;
    });
  }

  void _onImageReleased() {
    setState(() {
      _isImageCaught = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: _bucketTop,
          left: _bucketLeft,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.blueGrey,
            ),
            child: Icon(Icons.delete, color: Colors.white, size: 50),
          ),
        ),
        AnimatedPositioned(
          duration: Duration(milliseconds: 500),
          top: _isImageCaught ? 250 : 0,
          left: _isImageCaught ? 50 : 0,
          child: GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                _bucketLeft += details.delta.dx;
                _bucketTop += details.delta.dy;
              });
            },
            onPanEnd: (_) {
              if (_bucketLeft < 100 && _bucketTop > 250) {
                _onImageCaught();
              } else {
                _onImageReleased();
              }
            },
            child: Image.network(
              widget.imageUrl,
              width: widget.imageSize,
              height: widget.imageSize,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}


class MenuListItem extends StatelessWidget {
  const MenuListItem({
    super.key,
    this.name = '',
    this.price = '',
    required this.photoProvider,
    this.isDepressed = false,
  });

  final String name;
  final String price;
  final ImageProvider photoProvider;
  final bool isDepressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeInOut,
          height: isDepressed ? 100 : 100,
          width: isDepressed ? 100 : 100,
          child: Image(
            image: photoProvider,
            fit: BoxFit.contain,
            height: 100,
            width: 100,
          ),
        ),
      ),
    );
  }
}

class DraggingListItem extends StatelessWidget {
  const DraggingListItem({
    super.key,
    required this.dragKey,
    required this.photoProvider,
  });

  final GlobalKey dragKey;
  final ImageProvider photoProvider;

  @override
  Widget build(BuildContext context) {
    return FractionalTranslation(
      translation: const Offset(-0.5, -0.5),
      child: ClipRRect(
        key: dragKey,
        borderRadius: BorderRadius.circular(12.0),
        child: SizedBox(
          height: 100,
          width: 100,
          child: Opacity(
            opacity: 0.85,
            child: Image(
              image: photoProvider,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}