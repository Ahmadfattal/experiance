import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../widget/indicators_widget.dart';
import '../widget/pie_chart_sections.dart';

class PieChartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PieChartPageState();
}

class PieChartPageState extends State {
  late int? touchedIndex = -1;
  late int? bigTouchedIndex = -1;
  Color? partColor = Colors.grey;
  late Offset centerLocation;
  late Offset? currentLocation;

  double posx = 0.0;
  double posy = 0.0;
  final _key = GlobalKey();
  double yLocationButton = 80;
   double xLocationButton=80 ;

  double ySwapDownButton = 30;
  double xSwapDownButton = 20;
 Color buttonColor=Colors.grey;
  late Offset buttonOffset=Offset(xLocationButton, yLocationButton);

  void onTapDown(BuildContext context, var details) {
    print('${details.globalPosition}');
    RenderBox? box = context.findRenderObject() as RenderBox?;
    final Offset localOffset = box!.globalToLocal(details.globalPosition);
    setState(() {
      centerLocation = localOffset;
      posx = localOffset.dx;
      posy = localOffset.dy;
    });
  }

  @override
  Widget build(BuildContext context) {

    return

      Scaffold(
        body: Stack(
          children: [
            Center(
              child: Container(
                color: Colors.blue,
                width: 500,
                height: 500,
                child: GestureDetector(
                    onForcePressEnd: (ForcePressDetails details) => onTapDown(context, details),
                    onTapDown: (TapDownDetails details) => onTapDown(context, details),
                    onSecondaryLongPressMoveUpdate: (LongPressMoveUpdateDetails details) => onTapDown(context, details),
                    onLongPressMoveUpdate: (LongPressMoveUpdateDetails details) => onTapDown(context, details),
                    child: PieChart(
                      PieChartData(
                        startDegreeOffset: 0,
                        pieTouchData: PieTouchData(
                          touchCallback: (FlTouchEvent pieTouchResponse, PieTouchResponse v) {
                            print(v?.touchedSection!.touchedSection?.titlePositionPercentageOffset.toString());
                            print(pieTouchResponse.localPosition?.distance);
                            setState(() {
                              if (pieTouchResponse is FlLongPressEnd || pieTouchResponse is FlLongPressMoveUpdate || pieTouchResponse is FlLongPressStart || pieTouchResponse is FlPanDownEvent) {
                                bigTouchedIndex = v?.touchedSection!.touchedSectionIndex;
                                partColor = Colors.yellowAccent;
                                //   touchedIndex = -1;
                              } else if (pieTouchResponse is FlPanCancelEvent || pieTouchResponse is FlTapCancelEvent) {
                                partColor = null;
                                bigTouchedIndex = -1;
                                // touchedIndex = v?.touchedSection!.touchedSectionIndex;
                              }
                            });
                          },
                        ),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 100,
                        sections: getMaxSections(bigTouchedIndex!, partColor),
                      ),
                    )),
              ),
            ),
            Center(
              child: Container(
                color: Colors.transparent,
                width: 100,
                height: 100,
                child: GestureDetector(
                    onTapDown: (TapDownDetails details) => onTapDown(context, details),
                    onSecondaryLongPressMoveUpdate: (LongPressMoveUpdateDetails details) => onTapDown(context, details),
                    onLongPressMoveUpdate: (LongPressMoveUpdateDetails details) => onTapDown(context, details),
                    child: PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(
                          touchCallback: (FlTouchEvent pieTouchResponse, PieTouchResponse? v) {
                            currentLocation = pieTouchResponse.localPosition;
                            print(currentLocation);
                            double? direction = pieTouchResponse.localPosition?.direction;
                            double? distance = pieTouchResponse.localPosition?.distance;
                            touchedIndex = v?.touchedSection!.touchedSectionIndex;
                            print(v?.touchedSection!.touchedSection);
                            print('distance is $distance');
                            setState(() {
                              if (pieTouchResponse is FlPointerHoverEvent) {
                                touchedIndex = v?.touchedSection!.touchedSectionIndex;
                              }
                              if (pieTouchResponse is FlLongPressEnd) {
                                bigTouchedIndex = colorBigCircle(currentLocation!, distance!);

                                if(bigTouchedIndex ==-1) {
                                  partColor = Colors.yellowAccent;
                                  String intPart = direction!.toString().substring(0, 2);

                                  switch (intPart) {
                                    case "0.":
                                      touchedIndex = 0;
                                      break;
                                    case "1.":
                                      touchedIndex = 1;
                                      break;
                                    case "-2":
                                      touchedIndex = 2;
                                      break;
                                    case "-0":
                                      touchedIndex = 3;
                                      break;
                                  }

                                }else{
                                  partColor = Colors.yellowAccent;
                                }
                                var cc = (centerLocation - currentLocation!).distance;
                                print('cc$direction');
                              } else if (pieTouchResponse is FlLongPressEnd) {
                                //  || pieTouchResponse is FlLongPressMoveUpdate || pieTouchResponse is FlLongPressStart || pieTouchResponse is FlPanDownEvent) {
                                touchedIndex = v?.touchedSection!.touchedSectionIndex;
                              } else if (pieTouchResponse is FlPanCancelEvent || pieTouchResponse is FlTapCancelEvent) {
                                partColor = null;
                                touchedIndex = -1;
                              }
                            });
                          },
                        ),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 30,
                        sections: getSections(touchedIndex ?? -1, partColor),
                      ),
                    )),
              ),
            ),


            Positioned(
              top: yLocationButton,
              left: xLocationButton,
              child: GestureDetector(
                  onVerticalDragUpdate: (details) {
                    int sensitivity = 8;
                    if (details.delta.dy > 0) {

                      setState(() {
                        bigTouchedIndex=2;
                        partColor = Colors.yellowAccent;
                        buttonColor=Colors.grey;
                        print('Down Swipe');
                      });


                    } else if (details.delta.dy < -0) {

                      setState(() {
                        buttonColor=Colors.yellowAccent;
                        print('Up Swipe');
                      });

                      // Up Swipe
                    }
                  },

                  onPanUpdate: (details) {
                    setState(() {
                      xLocationButton = xLocationButton + details.delta.dx;
                      yLocationButton = yLocationButton + details.delta.dy;
                    });
                  },
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom( primary:buttonColor  ),
                    child: Center(
                      child: Text('long press and swap up or down '),
                    ),

                    onPressed: () {},
                  )),
            ),
          ],
        ),
      );
  }
  int colorBigCircle(Offset offset, double distance) {
    if (offset.dx > 0 && offset.dy > 0 && distance > 220) {
      return 0;
    } else if (offset.dx < 0 && offset.dy > 0 && distance > 220)
      return 1;
    else if (offset.dx < 0 && offset.dy < 0 && distance > 220) {
      //   >100
      return 2;
    } else if (offset.dx > 0 && offset.dy < 0 && distance > 220)
      return 3;
    else
      return -1;
  }
}
