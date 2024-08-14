import 'package:flutter/widgets.dart';
import 'package:funoon/app/widgets/custom_bottom_navigation_bar.dart';
import 'package:funoon/features/Authentication/presentation/pages/login_page.dart';

import 'package:funoon/features/Authentication/presentation/pages/sign_up_page.dart';

import '../../features/Authentication/presentation/bloc/authentication_bloc.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AuthenticationStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AuthenticationStatus.authenticated:
      return [CustomBottomNavigationBar.page()];
    case AuthenticationStatus.unAuthenticated:
      return [CustomBottomNavigationBar.page()];
    case AuthenticationStatus.signupPage:
      return [SignUpPage.page()];
    case AuthenticationStatus.loginPage:
      return [LoginPage.page()];
    
  }
}
