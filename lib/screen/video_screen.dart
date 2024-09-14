import 'package:flutter/material.dart';
import 'package:hocky_game/common/utils.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';


class VideoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        InViewNotifierList(
          scrollDirection: Axis.vertical,
          initialInViewIds: ['0'],
          isInViewPortCondition: (double deltaTop, double deltaBottom, double viewPortDimension) {
            return deltaTop < (0.9 * viewPortDimension) && deltaBottom > (0.9 * viewPortDimension);
            // return deltaTop < (0.5 * viewPortDimension) && deltaBottom > (0.5 * viewPortDimension);
          },
          itemCount: 50,
          builder: (BuildContext context, int index) {
            return Container(
              width: double.infinity,
              height: 50.0,
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                children: [
                  LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      return InViewNotifierWidget(
                        id: '$index',
                        builder: (BuildContext context, bool isInView, Widget? child) {
                          return Container(
                            height: 50,
                            width: 100,
                            color: isInView ? Colors.red : Colors.blue,
                          );
                        },
                      );
                    },
                  ),
                  LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      return InViewNotifierWidget(
                        id: '$index',
                        builder: (BuildContext context, bool isInView, Widget? child) {
                          return Container(
                            height: 50,
                            width: 100,
                            color: isInView ? Colors.red : Colors.blue,
                          );
                        },
                      );
                    },
                  ),
                  LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      return InViewNotifierWidget(
                        id: '$index',
                        builder: (BuildContext context, bool isInView, Widget? child) {
                          return Container(
                            height: 50,
                            width: 100,
                            color: isInView ? Colors.red : Colors.blue,
                          );
                        },
                      );
                    },
                  )
                ],
              ),
            );
          },
        ),
        /*Align(
          alignment: Alignment.center,
          child: Container(
            height: 1.0,
            color: Colors.redAccent,
          ),
        )*/
      ],
    );
  }
}