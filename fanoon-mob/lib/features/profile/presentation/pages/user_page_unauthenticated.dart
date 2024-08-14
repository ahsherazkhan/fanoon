import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funoon/app/routes/routes.dart';
import 'package:funoon/app/widgets/rounded_gradient_button.dart';
import 'package:funoon/features/Authentication/presentation/pages/sign_up_page.dart';

import '../../../Authentication/presentation/bloc/authentication_bloc.dart';

class UserPageUnAuthenticated extends StatelessWidget {
  const UserPageUnAuthenticated({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 256,
              width: 256,
              child: Image.asset('assets/user_screen/unauth_vector.png'),
            ),
             Text(
              'SignUp or LogIn and start selling your art',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            CustomRoundedButton(
              text: 'Start',
              onPressed: () {
                print("test");
                AppNavigator.push(Routes.signUpScreen, const SignUpPage());
              },
              height: 40,
              width: 120,
            )
          ],
        ),
      ),
    );
  }
}
