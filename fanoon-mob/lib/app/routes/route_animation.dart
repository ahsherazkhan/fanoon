import 'package:flutter/material.dart';

class FadeRoute extends PageRouteBuilder {
  FadeRoute({required this.screen})
      : super(
          pageBuilder: (_, __, ___) => screen,
          transitionsBuilder: (_, animation, __, child) => FadeTransition(
            opacity: animation,
            child: child,
          ),
        );

  final Widget screen;
}
