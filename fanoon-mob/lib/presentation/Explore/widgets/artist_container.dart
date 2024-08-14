import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class ArtistContainer extends StatelessWidget {
  const ArtistContainer({
    Key? key,
    required this.artworkImage,
    required this.artistName,
    required this.numberOfArtworks,
    required this.artistImage,
  }) : super(key: key);
  final String artworkImage;
  final String artistName;
  final int numberOfArtworks;
  final String artistImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Container(
        height: 125,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 3,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 11.w, top: 37.h, bottom: 37.h),
                child: SizedBox(
                  height: 50.h,
                  width: 50.h,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        '$artistImage',
                        fit: BoxFit.cover,
                      )),
                ),
              ),
              const SizedBox(width: 15),
              RichText(
                text: TextSpan(
                  text: artistName,
                  style: Theme.of(context).textTheme.titleSmall,
                  children: [
                    TextSpan(
                      text: '\n$numberOfArtworks Fanpary',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 13.h, bottom: 13.h, right: 10.w, left: 23.w),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      artworkImage,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ArtistContainerSkeleton extends StatelessWidget {
  const ArtistContainerSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        height: 125,
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
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Shimmer.fromColors(
                period: const Duration(seconds: 1),
                baseColor: Theme.of(context).shadowColor.withOpacity(0.2),
                highlightColor: Colors.white70,
                child: Container(
                  height: 50.h,
                  width: 50.h,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    period: const Duration(seconds: 2),
                    baseColor: Colors.grey.withOpacity(0.2),
                    highlightColor: Colors.white70,
                    child: Container(
                      height: 18,
                      width: 90,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Shimmer.fromColors(
                    period: const Duration(seconds: 2),
                    baseColor: Colors.grey.withOpacity(0.2),
                    highlightColor: Colors.white70,
                    child: Container(
                      height: 11,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Shimmer.fromColors(
                    period: const Duration(seconds: 2),
                    baseColor: Colors.grey.withOpacity(0.2),
                    highlightColor: Colors.white70,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
