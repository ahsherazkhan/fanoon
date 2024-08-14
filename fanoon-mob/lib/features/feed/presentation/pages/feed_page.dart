import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:funoon/app/utils/dynamic_size.dart';
import 'package:funoon/features/feed/presentation/bloc/feed_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../app/theme/colors.dart';
import '../../../Authentication/presentation/bloc/authentication_bloc.dart';
import '../../../profile/presentation/bloc/upload_post__page_state.dart';
import '../../../profile/presentation/bloc/upload_post_page_bloc.dart';
import '../../../../app/theme/themeManager.dart';
import '../widgets/post_widget.dart';

// Post Widget

class FeedScreen extends StatefulWidget {
  static const String route = '/FeedScreen';
  const FeedScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('feed repainted');
    final themeChange = Provider.of<DarkThemeProvider>(context).darkTheme;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        centerTitle: false,
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
                  Text('Feed Screen',
                      style: Theme.of(context).textTheme.titleMedium)
                ],
              ),
            ),
          ),
        ),
      ),
      body: BlocBuilder<FeedBloc, FeedState>(
        builder: (context, state) {
          if (state is FeedLoading) {
            return const Center(
              child: SpinKitChasingDots(
                color: red,
              ),
            );
          } else if (state is FeedLoaded) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  ListView.builder(
                    reverse: true,
                    physics: const NeverScrollableScrollPhysics(),
                    primary: false,
                    shrinkWrap: true,
                    itemBuilder: ((context, index) =>
                        BlocBuilder<AuthenticationBloc, AuthenticationState>(
                          builder: (context, authState) => PostWidget(
                            loggedInUserId: authState.user.id,
                            id: state.posts[index].id,
                            likesIds: state.posts[index].likesIDs,
                            dateCreated: state.posts[index].dateCreated,
                            images: state.posts[index].imagesUrls,
                            title: state.posts[index].title,
                            price: state.posts[index].price,
                            description: state.posts[index].description,
                            username: state.posts[index].createdBy.name,
                            comments: state.posts[index].comments.length,
                            likesCount: state.posts[index].likes,
                            shares: state.posts[index].shares,
                            tags: state.posts[index].tags,
                          ),
                        )),
                    //separatorBuilder: (context, index) => const Divider(),
                    itemCount: state.posts.length,
                  ),
                ],
              ),
            );
          } else {
            //TODO: Will print error message here
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200.w,
                    height: 200.h,
                    child: Image.asset(
                      'assets/feed_screen/error.png',
                    ),
                  ),
                  const Text(
                    'Woops... Something went wrong',
                    style: TextStyle(
                      color: red,
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
