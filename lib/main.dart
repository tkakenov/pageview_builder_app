import 'package:flutter/material.dart';
import 'package:page_view_builder_app/screens/first_screen.dart';
import 'package:page_view_builder_app/screens/fourth_screen.dart';
import 'package:page_view_builder_app/screens/second_screen.dart';
import 'package:page_view_builder_app/screens/third_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Widget> screens = [
    const FirstScreen(),
    const SecondScreen(),
    const ThirdScreen(),
    const FourthScreen()
  ];

  final controller = PageController(
    initialPage: 0,
    viewportFraction: 1,
    keepPage: false,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Flexible(
              flex: 8,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: PageView.builder(
                  itemCount: screens.length,
                  controller: controller,
                  itemBuilder: (context, index) => AnimatedBuilder(
                    animation: controller,
                    builder: (context, child) {
                      double value = 1.0;
                      if (controller.position.haveDimensions) {
                        value = controller.page! - index;
                        value = (1 - (value.abs() * 0.7)).clamp(0.0, 1.0);
                      }
                      return Center(
                        child: Container(
                          height: Curves.easeOut.transform(value) * 500,
                          width: Curves.easeOut.transform(value) * 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: screens[index],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: SmoothPageIndicator(
                controller: controller,
                count: screens.length,
                effect: const WormEffect(
                  dotColor: Colors.amber,
                  activeDotColor: Colors.green,
                  spacing: 10,
                  offset: 36,
                  dotHeight: 16,
                  dotWidth: 16,
                  type: WormType.thin,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
