import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/feed/presentation/bloc/feed_bloc.dart';
import '../../presentation/Chat/pages/chat_page.dart';
import '../../presentation/Explore/pages/explore_page.dart';
import '../../features/feed/presentation/pages/feed_page.dart';
import '../../features/profile/presentation/pages/user_page.dart';
import '../theme/colors.dart';

//Screens

class CustomBottomNavigationBar extends StatefulWidget {
  static Page<void> page() =>
      const MaterialPage<void>(child: CustomBottomNavigationBar());
  static const String route = '/NavigationBar';
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  List<Widget> screens = const [
    FeedScreen(),
    ExploreScreen(),
    ChatScreen(),
    //Center(child: Text('Price', style: TextStyle(color: Colors.black))),
    UserPage(),
  ];
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    BlocProvider.of<FeedBloc>(context).add(LoadFeed());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
          
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            activeIcon: LinearGradientMask(
              child: ImageIcon(
                AssetImage('assets/feed_screen/home.png'),
                size: 32,
              ),
            ),
            label: '',
            icon: ImageIcon(
              AssetImage('assets/feed_screen/home.png'),
              size: 32,
            ),
          ),
          BottomNavigationBarItem(
            activeIcon: LinearGradientMask(
              child: ImageIcon(
                AssetImage('assets/feed_screen/search.png'),
                size: 32,
              ),
            ),
            label: '',
            icon: ImageIcon(
              AssetImage('assets/feed_screen/search.png'),
              size: 32,
            ),
          ),
          BottomNavigationBarItem(
            activeIcon: LinearGradientMask(
              child: ImageIcon(
                AssetImage('assets/feed_screen/inbox.png'),
                size: 32,
              ),
            ),
            label: '',
            icon: ImageIcon(
              size: 32,
              AssetImage('assets/feed_screen/inbox.png'),
            ),
          ),
          // BottomNavigationBarItem(
          //   activeIcon: LinearGradientMask(
          //     child: ImageIcon(
          //       size: 32,
          //       AssetImage('assets/feed_screen/price-tag.png'),
          //     ),
          //   ),
          //   label: '',
          //   icon: ImageIcon(
          //     size: 32,
          //     AssetImage('assets/feed_screen/price-tag.png'),
          //   ),
          // ),
          BottomNavigationBarItem(
            activeIcon: LinearGradientMask(
              child: ImageIcon(
                size: 32,
                AssetImage('assets/feed_screen/user.png'),
              ),
            ),
            label: '',
            icon: ImageIcon(
              size: 32,
              AssetImage('assets/feed_screen/user.png'),
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class LinearGradientMask extends StatelessWidget {
  const LinearGradientMask({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [orange, red],
          tileMode: TileMode.mirror,
        ).createShader(bounds);
      },
      child: child,
    );
  }
}
