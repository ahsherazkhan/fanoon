import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:funoon/features/Authentication/presentation/pages/sign_up_page.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../app/routes/routes.dart';
import '../../../../app/theme/colors.dart';
import '../../../../app/widgets/custom_bottom_navigation_bar.dart';
import '../../../../app/widgets/rounded_gradient_button.dart';
import '../bloc/log_in_form_bloc.dart';

class LoginPage extends StatefulWidget {
  static Page<void> page() => const MaterialPage<void>(child: LoginPage());

  const LoginPage({Key? key}) : super(key: key);
  static const route = '/LoginPage';
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        context.read<LogInFormBloc>().add(EmailUnfocused());
        //FocusScope.of(context).requestFocus(_passwordFocusNode);
      }
    });
    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        context.read<LogInFormBloc>().add(PasswordUnfocused());
      }
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return WillPopScope(
      onWillPop: () {
        context.read<LogInFormBloc>().add(DisposePage());
        AppNavigator.pop();
        return Future.value(false);
      },
      child: Stack(children: [
        Container(
          color: Colors.white,
          height: 844.h,
          width: 390.w,
        ),
        Positioned(
          top: 0,
          right: 0,
          child: SizedBox(
            width: 150.w,
            height: 150.h,
            child: Image.asset(
              'assets/signup_screen/triangle_pattern.png',
              fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          //alignment: Alignment.bottomLeft,
          child: SizedBox(
            width: 150.w,
            height: 150.h,
            child: Image.asset(
              'assets/signup_screen/triangle_pattern_rotated.png',
              fit: BoxFit.fill,
            ),
          ),
        ),
        BlocListener<LogInFormBloc, LogInFormState>(
          listener: (context, state) {
            const snackBar = SnackBar(
              content: Text('Something went wrong'),
            );
            if (state.status.isSubmissionFailure) {
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else if (state.status.isSubmissionSuccess) {
              AppNavigator.replaceWith(
                  Routes.navigationBar, const CustomBottomNavigationBar());
            }
          },
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: SizedBox(
                  height: 844.h,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fitHeight,
                              image: AssetImage(
                                  'assets/logo_english_urdu_black.png'),
                            ),
                          ),
                          //color: Colors.red,
                          height: 300.h,
                          width: 300.w,
                        ),
                      ),
                      //-----------------------EmailField--------------------------------
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50.w , vertical: 5.h),
                        child: BlocBuilder<LogInFormBloc, LogInFormState>(
                          builder: (context, state) {
                            return SizedBox(
                              height: 80.h,
                              child: TextFormField(
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        fontWeight: FontWeight.bold, height: 1),
                                focusNode: _emailFocusNode,
                                initialValue: state.email.value,
                                textInputAction: TextInputAction.next,
                                onChanged: (value) {
                                  context.read<LogInFormBloc>().add(
                                        EmailChanged(email: value),
                                      );
                                },
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  floatingLabelStyle:
                                      Theme.of(context).textTheme.bodySmall,
                                  errorText: state.email.invalid
                                      ? 'Please ensure the email entered is valid'
                                      : null,
                                  hintText: 'Email',
                                  labelText: 'Email',
                                ),
                                //autofocus: true,
                              ),
                            );
                          },
                        ),
                      ),
                      //-----------------------PasswordField--------------------------------
                      BlocBuilder<LogInFormBloc, LogInFormState>(
                        builder: (context, state) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 50.w, vertical: 5.h),
                            child: SizedBox(
                              height: 80.h,
                              child: TextFormField(
                                textInputAction: TextInputAction.done,
                                initialValue: state.password.value,
                                onChanged: (value) {
                                  context
                                      .read<LogInFormBloc>()
                                      .add(PasswordChanged(password: value));
                                },
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: !state.isVisible,
                                focusNode: _passwordFocusNode,
                                decoration: InputDecoration(
                                  floatingLabelStyle:
                                      Theme.of(context).textTheme.bodySmall,
                                  hintText: 'Password',
                                  errorMaxLines: 2,
                                  errorText: state.password.invalid
                                      ? 'Password should be minimum 8 characters long and must contain numbers and digits'
                                      : null,
                                  suffixIcon: IconButton(
                                      icon: FaIcon(
                                        color: Colors.orange,
                                        size: 14,
                                        !state.isVisible
                                            ? FontAwesomeIcons.eye
                                            : FontAwesomeIcons.eyeSlash,
                                      ),
                                      onPressed: () => context
                                          .read<LogInFormBloc>()
                                          .add(VisibilityChanged(
                                              isVisible: state.isVisible))),
                                  labelText: 'Password',
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),

                      BlocBuilder<LogInFormBloc, LogInFormState>(
                        builder: (context, state) {
                          if (state.status.isSubmissionInProgress) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              child: const SpinKitChasingDots(
                                color: red,
                              ),
                            );
                          } else {
                            return CustomRoundedButton(
                              height: 30.h,
                              width: 250.w,
                              text: 'Login',
                              onPressed: () {
                                context
                                    .read<LogInFormBloc>()
                                    .add(FormSubmitted());
                              },
                            );
                          }
                        },
                      ),
                      RichText(
                        selectionColor: const Color(0xAF6694e8),
                        text: TextSpan(
                          text: 'Don\'t have an account? ',
                          style: Theme.of(context).textTheme.titleSmall,
                          children: <TextSpan>[
                            TextSpan(
                              text: 'SignUp',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(color: red),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  AppNavigator.replaceWith(
                                      Routes.signUpScreen, const SignUpPage());
                                },
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
        ),
      ]),
    );
  }
}
