import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/themeManager.dart';
import '../../../app/utils/dynamic_size.dart';

class ChatContainer extends StatelessWidget {
  const ChatContainer({
    Key? key,
    required this.isMe,
    required this.messageBody,
  }) : super(key: key);
  final bool isMe;
  final String messageBody;

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: SizeConfig.screenWidth! * 0.80,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(2, 3),
                    blurRadius: 2,
                    spreadRadius: 2,
                    color: Theme.of(context).shadowColor.withOpacity(0.5),
                  ),
                ],
                borderRadius: isMe
                    ? BorderRadius.only(
                        topLeft: Radius.circular(0.r),
                        topRight: Radius.circular(20.r),
                        bottomLeft: Radius.circular(20.r),
                        bottomRight: Radius.circular(20.r))
                    : BorderRadius.only(
                        topLeft: Radius.circular(20.r),
                        topRight: Radius.circular(20.r),
                        bottomLeft: Radius.circular(20.r),
                        bottomRight: Radius.circular(0.r)),
                color:
                    isMe ? Theme.of(context).colorScheme.primaryContainer : red,
              ),
              child: AutoSizeText(
                messageBody,
                style: TextStyle(
                    color: isMe
                        ? themeChange.darkTheme
                            ? Colors.white
                            : Colors.black
                        : Colors.white),
              ),
            ),
          ),
        )
      ],
    );
  }
}
