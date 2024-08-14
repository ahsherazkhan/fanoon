import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/theme/colors.dart';
import '../../../app/utils/dynamic_size.dart';

import '../../../app/widgets/back_button.dart';
import '../Widgets/chat_container.dart';
import '../Widgets/dropdwon_button.dart';

class UserChatScreen extends StatelessWidget {
  const UserChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70.h,
        elevation: 1,
        leading: backButton(context),
        title: Row(
          children: [
            Container(
              height: 50.h,
              width: 50.h,
              decoration: BoxDecoration(
                border: Border.all(
                  color: orange,
                  width: 2,
                ),
                shape: BoxShape.circle,
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/user1.png'),
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'FATIMA',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Row(
                  children: [
                    Container(
                      height: 10,
                      width: 10,
                      decoration: const BoxDecoration(
                        color: Colors.greenAccent,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'Allways Active',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        actions: const [
          MyDropDownButton(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          children: const [
            ChatContainer(
              isMe: true,
              messageBody: 'Asalam o Alaikum',
            ),
            ChatContainer(
              isMe: false,
              messageBody: 'Wa’Alaikum Asalam',
            ),
            ChatContainer(
              isMe: true,
              messageBody: 'I wanna buy the raw material from you.',
            ),
          ],
        ),
      ),
    );
  }
}
