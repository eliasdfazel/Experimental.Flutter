import 'package:experimental/resources/colors_resources.dart';
import 'package:experimental/resources/strings_resources.dart';
import 'package:flutter/material.dart';

class HueToHue extends StatefulWidget {
  const HueToHue({super.key});


  @override
  State<HueToHue> createState() => _HueToHueState();
}

class _HueToHueState extends State<HueToHue> with SingleTickerProviderStateMixin  {

  late Animation<Color?> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: const Duration(seconds: 7), vsync: this);
    animation = ColorTween(begin: ColorsResources.pink, end: ColorsResources.cyan)
        .animate(controller)
        ..addListener(() {

          setState(() { });
        })..addStatusListener((status) {

          switch (status) {
            case AnimationStatus.completed: {



            }
          }

        });

  }

  bool buttonToggle = true;

  void animateColor() {

    if (buttonToggle) {

      controller.forward();

    } else {

      controller.reverse();

    }

    buttonToggle = !buttonToggle;

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

                        animateColor();

                      },
                      child: Container(
                          height: double.maxFinite,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    ColorsResources.pink,
                                    ColorsResources.pink,
                                    animation.value!,
                                  ],
                                  transform: GradientRotation(-45)
                              )
                          )
                      ),
                    )
                )
            )
        )
      )
    );
  }
}
