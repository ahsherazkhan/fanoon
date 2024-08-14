import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../app/theme/colors.dart';
import '../../../../app/theme/themeManager.dart';
import '../../../../app/widgets/rounded_gradient_button.dart';

class DescriptionScreen extends StatefulWidget {
  const DescriptionScreen({
    Key? key,
    required this.artistName,
    required this.title,
    required this.description,
    required this.price,
    required this.imagesUrls,
  }) : super(key: key);
  static const route = 'DescriptionScreen';
  final String artistName;
  final String title;
  final String description;
  final String price;
  final List<String> imagesUrls;

  @override
  State<DescriptionScreen> createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context).darkTheme;
    return Scaffold(
      //-------------------------------------Appbar
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                    child: Image.asset(themeChange
                        ? 'assets/appbar_logo_white.png'
                        : 'assets/appbar_logo.png'),
                  ),
                  SizedBox(
                    height: 24,
                    child: VerticalDivider(
                      color: themeChange ? Colors.white : Colors.black,
                      thickness: 2,
                    ),
                  ),
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.titleMedium,
                  )
                ],
              ),
            ),
          ),
        ),
        centerTitle: false,
      ),
      //-------------------------------------Padding for base column
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 23.h),
              //-------------------------------------Images
              AspectRatio(
                aspectRatio: 1.6,
                child: GestureDetector(
                  child: CarouselSlider.builder(
                    itemCount: widget.imagesUrls.length,
                    itemBuilder: (context, index, realIndex) {
                      final urlImage = widget.imagesUrls[index];
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Hero(
                          tag: widget.imagesUrls,
                          child: CachedNetworkImage(
                            imageUrl: urlImage,
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      );
                    },
                    options: CarouselOptions(
                        scrollPhysics: const BouncingScrollPhysics(),
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
                  onTap: () {
                    //TODO: Hero Widget to detail screen
                  },
                ),
              ),
              SizedBox(height: 48.h),
              //------------------------------------- Artist Information
              Container(
                height: 90.h,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).shadowColor,
                      blurRadius: 50,
                      spreadRadius: 1,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      ProfilePicture(
                        name: widget.artistName,
                        radius: 12.w,
                        fontsize: 14.sp,
                      ),
                      const SizedBox(width: 10),
                      RichText(
                        text: TextSpan(
                          text: widget.artistName,
                          style: Theme.of(context).textTheme.titleMedium,
                          children: [
                            TextSpan(
                              text: '\n150 Fanpary',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                    color: red,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      CustomRoundedButton(
                        height: 24.h,
                        width: 80.w,
                        radius: 25,
                        onPressed: () {
                          //TODO: Implement the button functionality
                        },
                        text: 'FOLLOW',
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              //-------------------------------------Title
              Text(
                widget.title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              //-------------------------------------Description
              Text(
                widget.description,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 5.h),
              //-------------------------------------Price and But button
              Row(
                children: [
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 180.w,
                    child: RichText(
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: 'Price',
                        style: GoogleFonts.montserrat(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                        children: [
                          TextSpan(
                            text: widget.price,
                            style: GoogleFonts.montserrat(
                              fontSize: 26,
                              color: red,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  CustomRoundedButton(
                    radius: 25.r,
                    height: 40.h,
                    width: 160.w,
                    onPressed: () {
                      //TODO: Implement the button functionality hare.
                    },
                    text: 'ADD TO CART',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
