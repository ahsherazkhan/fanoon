import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:funoon/features/Authentication/presentation/pages/login_page.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../app/routes/routes.dart';
import '../../../../app/theme/colors.dart';
import '../../../../app/widgets/rounded_gradient_button.dart';
import '../bloc/signupform_bloc.dart';

class SignUpPage extends StatefulWidget {
  static Page<void> page() => const MaterialPage<void>(child: SignUpPage());

  const SignUpPage({Key? key}) : super(key: key);
  static const route = '/SignUpPage';
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _usernameFocusNode = FocusNode();

  @override
  void initState() {
    print('initState');
    super.initState();
    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        context.read<SignupFormBloc>().add(EmailUnfocused());
        //FocusScope.of(context).requestFocus(_passwordFocusNode);
      }
    });
    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        context.read<SignupFormBloc>().add(PasswordUnfocused());
      }
    });

    _usernameFocusNode.addListener(() {
      if (!_usernameFocusNode.hasFocus) {
        context.read<SignupFormBloc>().add(UsernameUnfocused());
      }
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _usernameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context.read<SignupFormBloc>().add(DisposePage());
        AppNavigator.pop();
        return Future.value(false);
      },
      child: BlocListener<SignupFormBloc, SignupFormState>(
        listener: (context, state) {
          const snackBar = SnackBar(
            content: Text('Something went wrong'),
          );
          if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        child: Stack(
          children: [
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
            BlocListener<SignupFormBloc, SignupFormState>(
              listener: (context, state) {
                const snackBar = SnackBar(
                  content: Text('Something went wrong'),
                );
                if (state.status.isSubmissionFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else if (state.status.isSubmissionSuccess) {
                  AppNavigator.pop();
                }
              },
              child: Scaffold(
                backgroundColor: Colors.transparent,
                resizeToAvoidBottomInset: true,
                body: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      //mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            //color: Colors.red,
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
                        //-----------------------UsernameField--------------------------------
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 50.w, vertical: 5.h),
                          child: BlocBuilder<SignupFormBloc, SignupFormState>(
                            builder: (context, state) {
                              return SizedBox(
                                height: 80.h,
                                child: TextFormField(
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                  focusNode: _usernameFocusNode,
                                  initialValue: state.username.value,
                                  textInputAction: TextInputAction.next,
                                  onChanged: (value) {
                                    context
                                        .read<SignupFormBloc>()
                                        .add(UsernameChanged(username: value));
                                  },

                                  decoration: InputDecoration(
                                    floatingLabelStyle:
                                        Theme.of(context).textTheme.bodySmall,
                                    hintText:
                                        'A username that will represent you',
                                    errorText: state.username.invalid
                                        ? 'username must be 4 to 20 characters without special characters'
                                        : null,
                                    labelText: 'Username',
                                  ),
                                  //autofocus: true,
                                ),
                              );
                            },
                          ),
                        ),

                        //-----------------------EmailField--------------------------------
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 50.w, vertical: 5.h),
                          child: BlocBuilder<SignupFormBloc, SignupFormState>(
                            builder: (context, state) {
                              return SizedBox(
                                height: 80.h,
                                child: TextFormField(
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                  focusNode: _emailFocusNode,
                                  initialValue: state.email.value,
                                  textInputAction: TextInputAction.next,
                                  onChanged: (value) {
                                    context.read<SignupFormBloc>().add(
                                          EmailChanged(email: value),
                                        );
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    errorText: state.email.invalid
                                        ? 'Please ensure the email entered is valid'
                                        : null,
                                    hintText:
                                        'a valid email like fatima@gmail.com',
                                    labelText: 'Email',
                                  ),
                                  //autofocus: true,
                                ),
                              );
                            },
                          ),
                        ),
                        //-----------------------PasswordField--------------------------------
                        BlocBuilder<SignupFormBloc, SignupFormState>(
                          builder: (context, state) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 50.w, vertical: 5.h),
                              child: SizedBox(
                                height: 80.h,
                                child: TextFormField(
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(fontWeight: FontWeight.bold),
                                  textInputAction: TextInputAction.done,
                                  initialValue: state.password.value,
                                  onChanged: (value) {
                                    context
                                        .read<SignupFormBloc>()
                                        .add(PasswordChanged(password: value));
                                  },
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: state.isVisible,
                                  focusNode: _passwordFocusNode,
                                  decoration: InputDecoration(
                                    hintText: 'Use a strong password',
                                    errorMaxLines: 2,
                                    errorText: state.password.invalid
                                        ? 'Password should be minimum 8 characters long and must contain numbers and digits'
                                        : null,
                                    suffixIcon: IconButton(
                                        icon: FaIcon(
                                          color: orange,
                                          size: 14,
                                          state.isVisible
                                              ? FontAwesomeIcons.eye
                                              : FontAwesomeIcons.eyeSlash,
                                        ),
                                        onPressed: () => context
                                            .read<SignupFormBloc>()
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

                        BlocBuilder<SignupFormBloc, SignupFormState>(
                          builder: (context, state) {
                            return state.status.isSubmissionInProgress
                                ? const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 12),
                                    child: SpinKitChasingDots(
                                      color: red,
                                    ),
                                  )
                                : CustomRoundedButton(
                                    height: 30.h,
                                    width: 250.w,
                                    text: 'Sign Up',
                                    onPressed: () {
                                      context
                                          .read<SignupFormBloc>()
                                          .add(FormSubmitted());
                                    },
                                  );
                          },
                        ),

                        RichText(
                          selectionColor: const Color(0xAF6694e8),
                          text: TextSpan(
                            text: 'Already an artist at Fanoon? ',
                            style: Theme.of(context).textTheme.titleSmall,
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Login',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(color: red),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    AppNavigator.push(
                                        Routes.loginScreen, const LoginPage());
                                  },
                              ),
                            ],
                          ),
                        ),

                        //----------------------Socials Buttons

                        // Padding(
                        //   padding: const EdgeInsets.symmetric(vertical: 12),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       Container(
                        //         width: 75,
                        //         margin: const EdgeInsets.only(right: 15.0),
                        //         child: const Divider(
                        //           thickness: 1,
                        //           color: Colors.white,
                        //         ),
                        //       ),
                        //       const AutoSizeText('OR CONNECT WITH'),
                        //       Container(
                        //         width: 75,
                        //         margin: const EdgeInsets.only(left: 15),
                        //         child: const Divider(
                        //           thickness: 1,
                        //           color: Colors.white,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // Padding(
                        //   padding: EdgeInsets.symmetric(
                        //       horizontal: SizeConfig.screenWidth! * 0.20),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //     children: [
                        //       GestureDetector(
                        //         onTap: () {},
                        //         child: Container(
                        //           height: SizeConfig.blockSizeVertical! * 10,
                        //           width: SizeConfig.blockSizeHorizontal! * 10,
                        //           decoration: const BoxDecoration(
                        //             image: DecorationImage(
                        //               image: AssetImage(
                        //                   'assets/signup_screen/google.png'),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //       GestureDetector(
                        //         onTap: () {
                        //           //socialsSignUp(social: 'facebook');
                        //         },
                        //         child: Container(
                        //           height: SizeConfig.blockSizeVertical! * 10,
                        //           width: SizeConfig.blockSizeHorizontal! * 10,
                        //           decoration: const BoxDecoration(
                        //             image: DecorationImage(
                        //               image: AssetImage(
                        //                   'assets/signup_screen/facebook.png'),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //       GestureDetector(
                        //         onTap: () {
                        //           //socialsSignUp(social: 'twitter');
                        //         },
                        //         child: Container(
                        //           height: SizeConfig.blockSizeVertical! * 10,
                        //           width: SizeConfig.blockSizeHorizontal! * 10,
                        //           decoration: const BoxDecoration(
                        //             image: DecorationImage(
                        //               image: AssetImage(
                        //                   'assets/signup_screen/twitter.png'),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
