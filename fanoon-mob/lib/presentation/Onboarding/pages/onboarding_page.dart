import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../app/routes/routes.dart';
import '../../../app/theme/colors.dart';
import '../../../app/widgets/custom_bottom_navigation_bar.dart';

class DockingScreen extends StatefulWidget {
  static const String route = '/DockingScreen';
  const DockingScreen({Key? key}) : super(key: key);

  @override
  State<DockingScreen> createState() => _DockingScreenState();
}

class _DockingScreenState extends State<DockingScreen> {
  final controller =
      PageController(initialPage: 0, keepPage: true, viewportFraction: 1);

  bool isLastPage = false;

  final colors = [red, orange, darkGreen, green];
  var activePageIndex = 0;

  final assets = [
    'red_minar_bold.png',
    'orange_mizar.png',
    'green_mosque.png',
    'blue_khyber.png',
  ];
  final texts = [
    'Discover the diversity of art in Punjab on Fanoon. From rural to urban, find a range of styles and mediums to explore.',
    'Explore the rich cultural heritage of Sindh through its art on Fanoon. Immerse yourself in traditional and contemporary pieces from this region.',
    'Discover the raw elegance of Balochistan\'s art scene on Fanoon. From deserts to mountains, take a journey through the inspiration behind the art of this region.',
    'Be captivated by the rugged beauty of Khyber Pakhtunkhwa\'s art on Fanoon. From landscapes to abstract pieces, see the inspiration drawn from this region\'s landscapes.',
  ];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: 4,
        onPageChanged: (index) {
          setState(() {
            isLastPage = index == 3;
            activePageIndex = index;
          });
        },
        itemBuilder: ((context, index) => Page(
            text: texts[index],
            image: 'assets/onboarding_screen/${assets[index]}',
            color: colors[index])),
        controller: controller,
      ),
      bottomSheet: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        color: colors[activePageIndex],
        height: 80.h,
        child: Row(
            mainAxisAlignment: isLastPage
                ? MainAxisAlignment.center
                : MainAxisAlignment.spaceBetween,
            children: isLastPage
                ? [
                    SizedBox(
                      width: 390.w,
                      child: TextButton(
                        onPressed: () async {
                          AppNavigator.push(Routes.navigationBar,
                              const CustomBottomNavigationBar());
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setBool('showHome', false);
                        },
                        child: Center(
                          child: Text(
                            'Get Started',
                            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Colors.white,
                        )
                          ),
                        ),
                      ),
                    )
                  ]
                : [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Skip',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Colors.white,
                        )
                      ),
                    ),
                    Center(
                      child: SmoothPageIndicator(
                        effect: const WormEffect(
                          activeDotColor: white,
                          dotColor: Colors.black26,
                        ),
                        controller: controller,
                        count: 4,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          controller.nextPage(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeOut,
                          );
                        },
                        child: Text(
                          'Next',
                          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Colors.white,
                        )
                        ))
                  ]),
      ),
    );
  }
}

class Page extends StatelessWidget {
  final String image;
  final Color color;
  final String text;

  const Page({
    Key? key,
    required this.image,
    required this.color,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          colors: [
            color.withOpacity(0.20),
            white.withOpacity(0.20),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 207.h,
            width: 207.w,
            child: Image.asset(image),
          ),
          SizedBox(
            height: 8.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Text(
              textAlign: TextAlign.center,
              text,
              style:
                  Theme.of(context).textTheme.bodyLarge!.copyWith(color: color),
              maxLines: 3,
            ),
          )
        ],
      ),
    );
  }
}
