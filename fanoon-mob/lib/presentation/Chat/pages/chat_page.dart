import 'package:flutter/material.dart';
import 'package:funoon/app/routes/routes.dart';
import 'package:funoon/presentation/Chat/pages/user_chat_page.dart';
import 'package:provider/provider.dart';

import '../../../app/theme/themeManager.dart';
import '../../../app/widgets/back_button.dart';
import '../Widgets/chat_tile.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  static const String route = 'ChatScreen';

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context).darkTheme;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                      child: Image.asset(themeChange
                        ? 'assets/appbar_logo_white.png'
                        : 'assets/appbar_logo.png'),
                    ),
                    SizedBox(
                      height: 24,
                      child: VerticalDivider(
                        color: themeChange ? Colors.white : Colors.black,
                        thickness: 2,
                      ),
                    ),
                    Text(
                      'Chat',
                     style: Theme.of(context).textTheme.titleMedium,
                    )
                  ],
                ),
              ),
            ),
          ),

          centerTitle: false,
        ),
        body: Column(
          children: [
            //TODO: Add Navigation bar hare.

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: ((context, index) => index == 4
                      ? const ChatTileSkeleton()
                      : InkWell(
                          onTap: () {
                           AppNavigator.push(Routes.userChatScreen, const  UserChatScreen());
                          },
                          child: const ChatTile(
                            artistName: 'FATIMA',
                            artistImage: 'assets/user1.png',
                            artworkImage: 'assets/artworks/artwork1.png',
                            artworkName: 'Handmade Baskets',
                          ),
                        )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
