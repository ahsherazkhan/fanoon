import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../app/theme/themeManager.dart';
import '../widgets/artist_container.dart';
import '../widgets/artwork_container.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({Key? key}) : super(key: key);
  static const route = 'ExploreScreen';

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context).darkTheme;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
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
                    'Explore',
                    style: Theme.of(context).textTheme.titleMedium,
                  )
                ],
              ),
            ),
          ),
        ),

        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 13.w, top: 34.h),
              child: Text(
                'Discover',
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 13.w),
              child: SizedBox(
                width: 300.h,
                child: Image.asset('assets/incredible_art.png'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
              child: SizedBox(
                height: 220.h,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children:  [
                    Padding(
                      padding:  EdgeInsets.symmetric(vertical: 10.h),
                      child: const ArtworkContainer(
                        image: 'assets/artworks/artwork1.png',
                        artworkName: 'Handmade Baskets',
                        price: 1000,
                        artistName: 'Aslam',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: const ArtworkContainer(
                        image: 'assets/artworks/ajrak.png',
                        artworkName: 'Ajrak',
                        price: 1500,
                        artistName: 'BegumSiraj',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: const ArtWorkContainerSkeleton(),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 20),
                Text(
                  'Top Artists',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Expanded(child: SizedBox(height: 0)),
                InkWell(
                  onTap: () {
                    //TODO: Implement See all Functionality hare.
                  },
                  child: Text(
                    'see all',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                const SizedBox(width: 20),
              ],
            ),
            SizedBox(height: 7.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  ArtistContainer(
                    artistImage: 'assets/user1.png',
                    artistName: 'FATIMA',
                    artworkImage: 'assets/artworks/artwork2.png',
                    numberOfArtworks: 150,
                  ),
                  ArtistContainer(
                    artistImage: 'assets/user2.png',
                    artistName: 'ALI',
                    artworkImage: 'assets/artworks/artwork3.png',
                    numberOfArtworks: 150,
                  ),
                  ArtistContainer(
                    artistImage: 'assets/user3.png',
                    artistName: 'AHSAN',
                    artworkImage: 'assets/artworks/artwork4.png',
                    numberOfArtworks: 150,
                  ),
                  ArtistContainerSkeleton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
