import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:funoon/app/theme/colors.dart';
import 'package:funoon/app/widgets/gradient_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:funoon/features/profile/presentation/pages/post_upload_page.dart';
import 'package:funoon/features/profile/presentation/pages/user_page_unauthenticated.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../../../app/theme/themeManager.dart';
import '../../../../app/widgets/rounded_gradient_button.dart';
import '../../../Authentication/presentation/bloc/authentication_bloc.dart';

class UserPage extends StatelessWidget {
  static const String route = '/UserPage';
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    bool isAuthenticated = false;
    //===========================For Switching Between UserPage and Register Button
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        state.status == AuthenticationStatus.authenticated
            ? isAuthenticated = true
            : isAuthenticated = false;
        return isAuthenticated
            ? DefaultTabController(
                length: 2,
                child: SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  primary: true,
                  child: Column(
                    children: [
                      SizedBox(
                        width: 390.w,
                        height: 253.h,
                        child:
                            Stack(clipBehavior: Clip.none, children: <Widget>[
                          //------------------------------Cover Image ----------------
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.7),
                                    BlendMode.dstATop),
                                fit: BoxFit.fill,
                                image: const AssetImage(
                                    'assets/user_screen/bg.jpg'),
                              ),
                            ),
                            //color: Colors.red,
                            height: 200.h,
                            width: 390.w,
                          ),

                          //------------------------------UserBox ----------------
                          Positioned(
                            top: 150.h,
                            left: 0,
                            right: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Theme.of(context).shadowColor,
                                      spreadRadius: 2.r,
                                      blurRadius: 50.r,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(25),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                BlocBuilder<AuthenticationBloc,
                                                    AuthenticationState>(
                                                  builder: (context, state) {
                                                    return Text(state.user.name,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall);
                                                  },
                                                ),
                                                Row(
                                                  children: [
                                                    const FaIcon(
                                                      FontAwesomeIcons
                                                          .locationDot,
                                                      size: 8,
                                                      color: Colors.red,
                                                    ),
                                                    Text('Lahore',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelSmall)
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Padding(
                                                padding: EdgeInsets.all(2),
                                                child: Text(
                                                  'Rising Talent',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: red,
                                                  ),
                                                ),
                                              ),
                                              RatingBar.builder(
                                                initialRating: 3,
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemBuilder: (context, _) =>
                                                    const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                itemSize: 12,
                                                onRatingUpdate: (rating) {},
                                              ),
                                            ],
                                          ),
                                          CustomRoundedButton(
                                            height: 24.h,
                                            width: 80.w,
                                            text: 'Follow',
                                            onPressed: () {},
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text('0',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall),
                                                Text(
                                                  'Shahkars',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily:
                                                        GoogleFonts.montserrat()
                                                            .fontFamily,
                                                    fontWeight: FontWeight.w800,
                                                    color: grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 36,
                                              child: VerticalDivider(
                                                color: red,
                                                thickness: 1.5,
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text('0',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall),
                                                Text(
                                                  'Followers',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily:
                                                        GoogleFonts.montserrat()
                                                            .fontFamily,
                                                    fontWeight: FontWeight.w800,
                                                    color: grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 36,
                                              child: VerticalDivider(
                                                color: red,
                                                thickness: 1.5,
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text('0',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall),
                                                Text(
                                                  'Following',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily:
                                                        GoogleFonts.montserrat()
                                                            .fontFamily,
                                                    fontWeight: FontWeight.w800,
                                                    color: grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          //-----------------------------LogOut Button /Theme Toggle switch ----------------
                          Align(
                            alignment: Alignment.centerRight,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  child: const FaIcon(
                                    color: red,
                                    FontAwesomeIcons.rightFromBracket,
                                  ),
                                  onTap: () {
                                    BlocProvider.of<AuthenticationBloc>(context)
                                        .add(AuthenticationLogoutRequested());
                                  },
                                ),
                                Switch(
                                  value: themeChange.darkTheme,
                                  onChanged: (bool? value) {
                                    themeChange.darkTheme = value!;
                                  },
                                ),
                              ],
                            ),
                          ),

                          //-----------------------------Circular Image----------------
                          Padding(
                            padding: EdgeInsets.only(top: 25.h),
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                height: 100.h,
                                width: 100.w,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 2,
                                      color: red,
                                    ),
                                    shape: BoxShape.circle),
                                child: ClipOval(
                                  child: BlocBuilder<AuthenticationBloc,
                                      AuthenticationState>(
                                    builder: (context, state) {
                                      return ProfilePicture(
                                        name: state.user.name,
                                        radius: 30,
                                        fontsize: 20,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // ),
                        ]),
                      ),
                      SizedBox(
                        height: 76.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('My Shop',
                              style: Theme.of(context).textTheme.titleMedium),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Container(
                          width: 390.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                            border: Border.all(color: red),
                            borderRadius: BorderRadius.circular(
                              25.0.r,
                            ),
                          ),
                          child: TabBar(
                            unselectedLabelColor: themeChange.darkTheme
                                ? Colors.white
                                : Colors.black,
                            //controller: _tabController,
                            // give the indicator a decoration (color and border radius)
                            indicator: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [red, orange],
                              ),
                              borderRadius: BorderRadius.circular(
                                25.0,
                              ),
                            ),

                            tabs: <Widget>[
                              SizedBox(
                                //width: 40,
                                child: Row(
                                  children: [
                                    const ImageIcon(
                                      AssetImage(
                                          'assets/user_screen/handicrafts.png'),
                                      //color: Colors.grey,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      'Handicrafts',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontFamily:
                                            GoogleFonts.montserrat().fontFamily,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                //width: 40,
                                child: Tab(
                                  child: Row(
                                    children: [
                                      const ImageIcon(
                                        AssetImage(
                                            'assets/user_screen/art.png'),
                                        //color: Colors.grey,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        'Original Art',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontFamily: GoogleFonts.montserrat()
                                              .fontFamily,
                                          fontSize: 12,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5.w, vertical: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Theme.of(context).shadowColor,
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  offset: const Offset(0, 3))
                            ],
                            color: Theme.of(context).cardColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(25),
                            ),
                          ),
                          height: 370.h,
                          child: TabBarView(
                            children: <Widget>[
                              myShop(
                                buttonText: 'Add Handicrafts',
                                onpressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const PostUploadScreen()));
                                },
                                child: Center(
                                  child: Text('No Handicrafts to show',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall),
                                ),
                              ),
                              myShop(
                                buttonText: 'Add Orignal Art',
                                onpressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const PostUploadScreen()));
                                },
                                child: const Center(
                                  child: Text(
                                    'No Orignal Arts to show',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : const UserPageUnAuthenticated();
      },
    );
  }

  Widget myShop(
      {required String buttonText,
      required Function() onpressed,
      required Widget child}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        child,
        GradientButton(
          onPressed: onpressed,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  buttonText,
                  style: const TextStyle(
                    color: red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 5),
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: red,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.add_rounded,
                      color: white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
