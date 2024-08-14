import 'package:flutter/material.dart';
import 'package:funoon/app/routes/route_animation.dart';
import 'package:funoon/features/Authentication/presentation/pages/login_page.dart';
import 'package:funoon/features/profile/presentation/pages/post_upload_page.dart';
import 'package:funoon/presentation/Chat/pages/user_chat_page.dart';
import 'package:funoon/features/feed/presentation/pages/description_page.dart';
import 'package:funoon/presentation/Explore/pages/explore_page.dart';

import 'package:funoon/presentation/Onboarding/pages/onboarding_page.dart';
import 'package:funoon/features/Authentication/presentation/pages/sign_up_page.dart';

import '../widgets/custom_bottom_navigation_bar.dart';

enum Routes {
  navigationBar,
  userScreen,
  dockingScreen,
  descriptionScreen,
  exploreScreen,
  userChatScreen,
  signUpScreen,
  loginScreen,
  postUploadScreen,
}

class _Paths {
  static const String signUpScreen = '/SignUpScreen';
  static const String loginScreen = '/LoginScreen';
  static const String navigationBar = '/NavigationBar';
  static const String uesrScreen = '/UserScreen';
  static const String dockingScreen = '/';
  static const String descriptionScreen = '/DescriptionScreen';
  static const String exploreScreen = '/ExploreScreen';
  static const String userChatScreen = '/UserChatScreen';
  static const String postUploadScreen = '/PostUploadScreen';

  static const Map<Routes, String> _pathMap = {
    Routes.signUpScreen: _Paths.signUpScreen,
    Routes.navigationBar: _Paths.navigationBar,
    Routes.userScreen: _Paths.uesrScreen,
    Routes.dockingScreen: _Paths.dockingScreen,
    Routes.descriptionScreen: _Paths.descriptionScreen,
    Routes.exploreScreen: _Paths.exploreScreen,
    Routes.userChatScreen: _Paths.userChatScreen,
    Routes.postUploadScreen: _Paths.postUploadScreen,
    Routes.loginScreen: _Paths.loginScreen,
  };

  static String of(Routes route) => _pathMap[route] ?? dockingScreen;
}

class AppNavigator {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  AppNavigator(Routes userChatScreen, UserChatScreen userChatScreen2);

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case _Paths.navigationBar:
        return FadeRoute(screen: const CustomBottomNavigationBar());

      case _Paths.uesrScreen:
        return FadeRoute(screen: const UserChatScreen());

      case _Paths.dockingScreen:
        return FadeRoute(screen: const DockingScreen());

      //case _Paths.descriptionScreen:
      //  return FadeRoute(screen: const DescriptionScreen());

      case _Paths.exploreScreen:
        return FadeRoute(screen: const ExploreScreen());

      case _Paths.userChatScreen:
        return FadeRoute(screen: const UserChatScreen());

      case _Paths.signUpScreen:
        return FadeRoute(screen: const SignUpPage());

      case _Paths.postUploadScreen:
        return FadeRoute(screen: const PostUploadScreen());

      case _Paths.loginScreen:
        return FadeRoute(screen: const LoginPage());

      default:
        return FadeRoute(screen: const CustomBottomNavigationBar());
    }
  }

  static Future? push<T>(Routes route, [T? arguments]) =>
      state?.pushNamed(_Paths.of(route), arguments: arguments);

  static Future? replaceWith<T>(Routes route, [T? arguments]) =>
      state?.pushReplacementNamed(_Paths.of(route), arguments: arguments);

  static void pop() => state?.pop();

  static NavigatorState? get state => navigatorKey.currentState;
}
