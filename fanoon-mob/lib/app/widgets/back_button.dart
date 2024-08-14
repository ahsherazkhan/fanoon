import 'package:flutter/material.dart';
import 'package:funoon/app/routes/routes.dart';

Widget backButton(BuildContext context) {
  return FloatingActionButton(
    onPressed: () {
      AppNavigator.pop();
    },
    mini: true,
    elevation: 0,
    backgroundColor: Colors.transparent,
    child: Center(
      child: SizedBox(
        height: 20,
        width: 20,
        child: Image.asset('assets/back_button.png'),
      ),
    ),
  );
}
