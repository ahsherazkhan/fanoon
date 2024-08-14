import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:funoon/features/feed/presentation/pages/description_page.dart';
import 'package:like_button/like_button.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../app/theme/colors.dart';
import '../../../../app/widgets/gradient_button.dart';
import '../../data/datasources/API/feed_api.dart';
import '../../data/repositories/feed_repository_impl.dart';
import '../../domain/repositories/feed_repository.dart';

class PostWidget extends StatefulWidget {
  const PostWidget({
    Key? key,
    required this.description,
    required this.title,
    required this.likesCount,
    required this.comments,
    required this.shares,
    required this.price,
    required this.images,
    required this.username,
    required this.tags,
    required this.dateCreated,
    required this.likesIds,
    required this.id,
    required this.loggedInUserId,
  }) : super(key: key);
  final String loggedInUserId;
  final String id;
  final String description;
  final String title;
  final int likesCount;
  final int comments;
  final int shares;
  final int price;
  final String username;
  final String dateCreated;
  final List<String> tags;
  final List<String> images;
  final List<String> likesIds;

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  late FToast fToast;
  @override
  void initState() {
    fToast = FToast();
    fToast.init(context);
  }

  _showToast() {
    Widget toast = Container(
      padding: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 12.0.h),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 50.r,
            color: Theme.of(context).shadowColor,
          )
        ],
        borderRadius: BorderRadius.circular(15.0.r),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Please Register',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
           SizedBox(
            width: 12.0.w,
          ),
          Text(
            'To explore the world of Fanoon',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.CENTER,
      toastDuration: const Duration(seconds: 4),
    );
  }

  bool isLiked = false;
  int activeIndex = 0;

  final FeedRepository feedRepository = FeedRepositoryImpl(FeedApiImpl());
  List<Widget> _addedTags(BuildContext buildContext) {
    List<Widget> chipList = [];
    for (var element in widget.tags) {
      chipList.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Chip(
          padding: const EdgeInsets.all(2.0),
          label: Text(
            element,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.white
                    // ),
                    ),
          ),
        ),
      ));
    }
    return chipList;
  }

  @override
  Widget build(BuildContext context) {
    final newTextTheme = Theme.of(context).textTheme;
    int likes = widget.likesCount;
    var parsedDate = DateTime.parse(widget.dateCreated);
    MoneyFormatter fmf = MoneyFormatter(
      amount: widget.price.toDouble(),
      settings: MoneyFormatterSettings(
        thousandSeparator: ',',
        decimalSeparator: '.',
        symbolAndNumberSeparator: ' ',
        fractionDigits: 3,
      ),
    );

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Container(
        //height: 506.h,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          border: Border(
            bottom: BorderSide(
              width: 0.1,
              color: Theme.of(context).dividerColor,
            ),
          ),
        ),
        //====================================Widget Body
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //====================================TopBar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 9.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          //height: 24.w,
                          //width: 24.w,
                          child: ProfilePicture(
                            name: widget.username,
                            radius: 12.w,
                            fontsize: 20,
                          ),
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        //====================================UserInformation
                        SizedBox(
                          height: 48.h,
                          width: 227.w,
                          //padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.username,
                                  style: newTextTheme.labelMedium),
                              Text('Painter', style: newTextTheme.labelSmall),
                            ],
                          ),
                        ),
                      ],
                    ),

                    //const Spacer(),
                    SizedBox(
                      width: 72.w,
                      height: 20.h,
                      child: Text(
                        '1 day ago',
                        //'posted on : ${parsedDate.day} / ${parsedDate.month} / ${parsedDate.year}',
                        style: newTextTheme.labelLarge,
                      ),
                    )
                  ],
                ),
              ),
              //============================================Images
              Column(
                children: [
                  GestureDetector(
                    child: CarouselSlider.builder(
                      itemCount: widget.images.length,
                      itemBuilder: (context, index, realIndex) {
                        final urlImage = widget.images[index];
                        return Hero(
                          tag: widget.images,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DescriptionScreen(
                                    artistName: widget.username,
                                    description: widget.description,
                                    imagesUrls: widget.images,
                                    price:
                                        '\n${fmf.output.withoutFractionDigits} PKR',
                                    title: widget.title,
                                  ),
                                ),
                              );
                            },
                            //TODO: Aspect Ratio Widget Removed put back if needed
                            child: CachedNetworkImage(
                              imageUrl: urlImage,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.r),
                                  image: DecorationImage(
                                    image: imageProvider,
                                    //TODO: can be remove to make art diverse
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: buildIndicator()),
                  ),
                ],
              ),
              //============================================Likes and Comments and Shares
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                      child: SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LikeButton(
                              isLiked: widget.likesIds
                                  .contains(widget.loggedInUserId),
                              //check if user is Authenticated
                              onTap: widget.loggedInUserId.isNotEmpty
                                  //check if post is already liked
                                  ? (liked) {
                                      if (liked) {
                                        likes--;
                                        feedRepository.likePost(id: widget.id);
                                        return Future.value(false);
                                      } else {
                                        likes++;
                                        feedRepository.likePost(id: widget.id);
                                        return Future.value(true);
                                      }
                                    }
                                  : (liked) {
                                      _showToast();
                                      return Future.value(false);
                                    },
                              size: 18,
                              likeCount: likes,
                              countBuilder:
                                  (int? count, bool? isLiked, String? text) {
                                Widget result;
                                if (count == 0) {
                                  result = Text("like",
                                      style: newTextTheme.labelLarge);
                                } else {
                                  result = Text(likes.toString(),
                                      style: newTextTheme.labelLarge);
                                }

                                return result;
                              },
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          isLiked = !isLiked;
                          if (isLiked) {
                            likes++;
                          } else {
                            likes--;
                          }
                        });
                      }),
                  SizedBox(
                    height: 24.h,
                    child: const VerticalDivider(
                      thickness: 1,
                    ),
                  ),
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.comment,
                          size: 18,
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2),
                          child: Text(
                              widget.comments == 0
                                  ? ''
                                  : widget.comments.toString(),
                              style: newTextTheme.labelLarge),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                    child: const VerticalDivider(
                      thickness: 1,
                    ),
                  ),
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.share,
                          size: 18,
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2),
                          child: Text(
                              widget.shares == 0
                                  ? ''
                                  : widget.shares.toString(),
                              style: newTextTheme.labelLarge),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              //-----------------------------------------Post title and Description
              Padding(
                padding: EdgeInsets.only(
                    left: 10.h, right: 10.h, top: 16.h, bottom: 8.h),
                child: Text(widget.title, style: newTextTheme.titleSmall),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Text(widget.description, style: newTextTheme.bodyMedium),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: _addedTags(context),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Divider(
                  thickness: 1,
                ),
              ),
              //Price and button
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 12,
                  bottom: 15,
                ),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 150.w,
                      child: SizedBox(
                        //width: SizeConfig.screenHeight! * 0.1,
                        child: Text('${fmf.output.withoutFractionDigits} PKR',
                            style: newTextTheme.titleSmall!.copyWith(
                              overflow: TextOverflow.ellipsis,
                            )),
                      ),
                    ),
                    const Spacer(),
                    GradientButton(
                      child: Text('Buy', style: newTextTheme.titleSmall),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DescriptionScreen(
                              artistName: widget.username,
                              description: widget.description,
                              imagesUrls:
                                  widget.images, //TODO: change this to an array
                              price: '${fmf.output.withoutFractionDigits} PKR',
                              title: widget.title,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: widget.images.length,
        effect: const ExpandingDotsEffect(
            dotColor: Colors.grey,
            spacing: 3.0,
            dotWidth: 7.0,
            dotHeight: 7.0,
            paintStyle: PaintingStyle.fill,
            activeDotColor: green),
      );
}
