import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:shimmer/shimmer.dart';

import '../../../app/theme/colors.dart';
import 'dropdwon_button.dart';


class ChatTile extends StatelessWidget {
  const ChatTile({
    Key? key,
    required this.artistName,
    required this.artworkName,
    required this.artworkImage,
    required this.artistImage,
  }) : super(key: key);
  final String artistName;
  final String artworkName;
  final String artworkImage;
  final String artistImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        height: 125.h,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 2),
                blurRadius: 2,
                spreadRadius: 2,
                color: Theme.of(context).shadowColor.withOpacity(0.5),
              ),
            ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 60.h,
                  width: 60.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('$artworkImage'),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -10,
                  right: -10,
                  child: Container(
                    height: 25.h,
                    width: 25.h,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: orange,
                        width: 2,
                      ),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('$artistImage'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$artistName',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '$artworkName',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Text(
                  '5 Sept',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const SizedBox(height: 5),
                Container(
                  height: 20.h,
                  width: 20.h,
                  decoration: const BoxDecoration(
                    color: orange,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '3',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ),
                const MyDropDownButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ChatTileSkeleton extends StatelessWidget {
  const ChatTileSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        height: 120.h,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 2),
                blurRadius: 2,
                spreadRadius: 2,
                color: Theme.of(context).shadowColor.withOpacity(0.5),
              ),
            ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Shimmer.fromColors(
              period: const Duration(seconds: 1),
              baseColor: Colors.grey.withOpacity(0.2),
              highlightColor: Colors.white70,
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    period: const Duration(seconds: 2),
                    baseColor: Colors.grey.withOpacity(0.2),
                    highlightColor: Colors.white70,
                    child: Container(
                      height: 15,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Shimmer.fromColors(
                    period: const Duration(seconds: 2),
                    baseColor: Colors.grey.withOpacity(0.2),
                    highlightColor: Colors.white70,
                    child: Container(
                      height: 15.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
