import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../../../app/theme/colors.dart';

import '../../../app/utils/dynamic_size.dart';

class CustomRoundedButton extends StatelessWidget {
  const CustomRoundedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.height,
    required this.width,
    this.radius = 25,
  }) : super(key: key);
  final String text;
  final VoidCallback? onPressed;
  final double height;
  final double width;
  final double radius;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: SizedBox(
        height: height,
        width: width,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius)),
          ),
          child: onPressed == null
              ? Container(
                  alignment: Alignment.center,
                  child: AutoSizeText(
                    maxFontSize: 16,
                    text,
                    style: const TextStyle(
                      color: white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              : Ink(
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [red, orange]),
                      borderRadius: BorderRadius.circular(25)),
                  child: Container(
                    alignment: Alignment.center,
                    child: AutoSizeText(
                      maxFontSize: 16,
                      text,
                      style: const TextStyle(
                        color: white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
