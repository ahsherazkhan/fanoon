import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../app/theme/colors.dart';
import '../../../app/utils/dynamic_size.dart';
import 'package:shimmer/shimmer.dart';

class ArtworkContainer extends StatelessWidget {
  const ArtworkContainer({
    Key? key,
    required this.image,
    required this.artworkName,
    required this.price,
    this.artistName,
  }) : super(key: key);
  final String image;
  final String artworkName;
  final String? artistName;
  final int price;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 13.w),
      child: Container(
        width: 255.h,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Padding(
          padding:
              EdgeInsets.only(left: 15.h, right: 15.h, top: 12.h, bottom: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 128.h,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    '$image',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Text(
                '$artworkName',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Row(
                children: [
                  Text(
                    '@$artistName',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  Expanded(child: SizedBox(height: 1)),
                  Text('Rs.$price',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: red,
                          )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ArtWorkContainerSkeleton extends StatelessWidget {
  const ArtWorkContainerSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 13.w),
      child: Container(
        width: 255.h,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 3,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Padding(
          padding:
              EdgeInsets.only(left: 15.h, right: 15.h, top: 12.h,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                period: const Duration(seconds: 2),
                baseColor: Theme.of(context).shadowColor.withOpacity(0.5),
                highlightColor: Colors.white70,
                child: Container(
                  height: 128.h,
                  width: 220.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              SizedBox(height: 5.h),
              Shimmer.fromColors(
                period: const Duration(seconds: 2),
                baseColor: Colors.grey.withOpacity(0.2),
                highlightColor: Colors.white70,
                child: Container(
                  height: 15.h,
                  width: 100.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Shimmer.fromColors(
                    period: const Duration(seconds: 2),
                    baseColor: Colors.grey.withOpacity(0.2),
                    highlightColor: Colors.white70,
                    child: Container(
                      height: 10.h,
                      width: 50.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                  Expanded(child: SizedBox(height: 0)),
                  Shimmer.fromColors(
                    period: const Duration(seconds: 2),
                    baseColor: Colors.grey.withOpacity(0.2),
                    highlightColor: Colors.white70,
                    child: Container(
                      height: 14,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
