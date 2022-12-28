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

  late Animation<Color?> animationColor;

  double gradientLayersCount = 3;

  List<Color> gradientColors = [];

  List<Color> newGradientColors = [];

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < gradientLayersCount; i++) {
      newGradientColors.add(Colors.transparent);
    }

    animateColor();

  }

  int gradientIndex = 0;

  void animateColor({Color beginColor = ColorsResources.springColor, Color endColor = ColorsResources.winterColor}) {

    Color previousColor = endColor;

    AnimationController animationController = AnimationController(duration: const Duration(seconds: 5), vsync: this);

    Animation<Color?> animationColor = ColorTween(begin: beginColor, end: endColor)
        .animate(animationController);

    animationColor..addListener(() {
      debugPrint("Animation Color: -> ${animationColor.value}");

      for (int index = 0; index < gradientLayersCount; index++) {

        if (gradientIndex == 0) {

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

          // gradientIndex++;
          //
          // if (gradientIndex == gradientLayersCount) {
          //   gradientIndex = 0;
          // }

          // animateColor();

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

    animationController.forward();

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
