import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';


import '../../../../app/utils/dynamic_size.dart';
import '../../../../app/widgets/gradient_button.dart';



class PostWidget extends StatefulWidget {
  const PostWidget({Key? key}) : super(key: key);

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  int activeIndex = 0;
  List<String> images = [
    'assets/feed_screen/post_feed1.png',
    'assets/feed_screen/post_feed2.png',
    'assets/feed_screen/post_feed3.png',
    'assets/feed_screen/post_feed4.png',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //height: SizeConfig.screenHeight! * 0.4,
      child: Column(children: [
        //---------Top Bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundImage:
                        const AssetImage('assets/feed_screen/waseek.jpeg'),
                    radius: SizeConfig.blockSizeVertical! * 4,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Waseek Ahmed',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const Text(
                          'Painter',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Row(
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.mapMarkerAlt,
                              size: 10,
                              color: Colors.red,
                            ),
                            Text(
                              ' Lahore , Punjab',
                              style: TextStyle(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .fontSize,
                                  color: Colors.black),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                width: SizeConfig.blockSizeHorizontal! * 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GradientButton(
                      gradient: const LinearGradient(
                          colors: [Colors.red, Colors.orange]),
                      strokeWidth: 1,
                      radius: 25,
                      onPressed: () {},
                      child: Text(
                        'Get it',
                        style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.bodyMedium!.fontSize,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    const FaIcon(
                      FontAwesomeIcons.ellipsisV,
                      color: Colors.red,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),

        //----------Image
        CarouselSlider.builder(
          itemCount: images.length,
          itemBuilder: (context, index, realIndex) {
            final urlImage = images[index];
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Image(image: AssetImage(urlImage)),
            );
          },
          options: CarouselOptions(
              enableInfiniteScroll: false,
              height: 300,
              aspectRatio: 1 / 1,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                setState(() {
                  activeIndex = index;
                });
              }),
        ),

        //---------Bottom Bar
        Column(
          children: [
            buildIndicator(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal! * 25,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.solidHeart,
                          color: Colors.red,
                        ),
                        FaIcon(FontAwesomeIcons.comment,
                            color: Colors.teal.shade300),
                        const FaIcon(FontAwesomeIcons.share,
                            color: Colors.grey),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal! * 13,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.cartPlus,
                          color: Colors.teal.shade300,
                        ),
                        const FaIcon(
                          FontAwesomeIcons.bookmark,
                          color: Colors.red,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ]),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: images.length,
        effect: const ExpandingDotsEffect(
          dotColor: Colors.grey,
          spacing: 3.0,
          dotWidth: 7.0,
          dotHeight: 7.0,
          paintStyle: PaintingStyle.fill,
          activeDotColor: Colors.red,
        ),
      );
}
