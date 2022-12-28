import 'dart:math';

import 'package:experimental/resources/colors_resources.dart';
import 'package:experimental/resources/strings_resources.dart';
import 'package:experimental/utils/operations/numbers.dart';
import 'package:flutter/material.dart';

class HueToHue extends StatefulWidget {

  const HueToHue({super.key});

  @override
  State<HueToHue> createState() => _HueToHueState();
}

class _HueToHueState extends State<HueToHue> with SingleTickerProviderStateMixin  {

  List<Color> allColors = [
    ColorsResources.lightestCyan,
    ColorsResources.gameGeeksEmpire,
    ColorsResources.blue,
    ColorsResources.grayLight,
    ColorsResources.green,
    ColorsResources.applicationGeeksEmpire,
    ColorsResources.black,
    ColorsResources.orange,
    ColorsResources.pink,
    ColorsResources.yellow,
  ];

  double gradientLayersCount = 3;

  List<Color> gradientColors = [];

  List<Color> newGradientColors = [];

  late AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(vsync: this);

    for (int i = 0; i < gradientLayersCount; i++) {
      newGradientColors.add(Colors.transparent);
    }

    animateColor();

  }

  int gradientIndex = 0;

  void animateColor({Color beginColor = ColorsResources.springColor, Color endColor = ColorsResources.winterColor}) {

    animationController.duration = Duration(milliseconds: 3000);
    animationController.reset();

    Color previousColor = endColor;

    ColorTween colorTween = ColorTween(begin: beginColor, end: endColor);

    Animation<Color?> animationColor = colorTween.animate(animationController);

    animationController.forward();

    animationColor..addListener(() {
      debugPrint("Animation Color: -> ${animationColor.value}");

      for (int index = 0; index < gradientLayersCount; index++) {

        if (gradientIndex == 0) {

          previousColor = animationColor.value ?? ColorsResources.black;

        }

        newGradientColors[gradientIndex] = animationColor.value ?? ColorsResources.black;

        if (index < gradientIndex) {

          newGradientColors[index] = previousColor;

        } else if (index > gradientIndex) {

          newGradientColors[index] = beginColor;

        }

      }

      setState(() {

        gradientColors = newGradientColors;

      });

    })..addStatusListener((status) {

      switch (status) {
        case AnimationStatus.completed: {
          debugPrint("Animation Status Completed: ${gradientIndex}");

          gradientIndex++;

          if (gradientIndex == gradientLayersCount) {
            debugPrint("Animation Status Restart");

            gradientIndex = 0;

            animationController.stop();

            animateColor(beginColor: previousColor, endColor: allColors[Random().nextInt(allColors.length)]);

          } else {

            animationController.reset();
            animationController.forward();

          }

          break;
        }
        case AnimationStatus.dismissed:
          break;
        case AnimationStatus.forward:
          break;
        case AnimationStatus.reverse:
          break;
      }

    });

  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: ClipRRect(
            borderRadius: BorderRadius.circular(37),
            child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: StringsResources.applicationName(),
                color: ColorsResources.primaryColor,
                theme: ThemeData(
                  fontFamily: 'Ubuntu',
                  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ColorsResources.primaryColor),
                  backgroundColor: ColorsResources.black,
                  pageTransitionsTheme: const PageTransitionsTheme(builders: {
                    TargetPlatform.android: ZoomPageTransitionsBuilder(),
                    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
                  }),
                ),
                home: Scaffold(
                    resizeToAvoidBottomInset: true,
                    extendBody: true,
                    backgroundColor: ColorsResources.yellow,
                    body: SizedBox(
                        height: double.maxFinite,
                        width: double.maxFinite,
                        child: InkWell(
                          onTap: () {



                          },
                          child: Container(
                            height: double.maxFinite,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: List.generate(gradientColors.length, (index) => gradientColors[index]),
                                    transform: GradientRotation(degreeToRadian(137))
                                )
                            ),
                            child: Stack(
                              children: [

                              ],
                            ),
                          ),
                        )
                    )
                )
            )
        )
    );
  }

}
