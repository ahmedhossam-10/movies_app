import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/core/resources/ColorManager.dart';
import 'package:movies_app/ui/home/taps/home_tab/HomeTab.dart';
import 'package:movies_app/ui/home/taps/profile_tab/profile_screen/ProfileTab.dart';
import 'package:movies_app/ui/home/taps/search_tab/SearchTab.dart';
import 'package:movies_app/ui/home/taps/sort_tap/SortTab.dart';
import '../../../core/resources/AssetsManager.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int NavigationBarSelectedIndex = 0;

  List<Widget> tabs = [
    HomeTab(),
    SearchTab(),
    SortTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      bottomNavigationBar: NavigationBar(
        backgroundColor: ColorManager.darkGray,
        indicatorColor: Colors.transparent,
        selectedIndex: NavigationBarSelectedIndex,
        onDestinationSelected: (newindex) {
          setState(() {
            NavigationBarSelectedIndex = newindex;
          });
        },
        destinations: [
          NavigationDestination(
            icon: SvgPicture.asset(AssetsManager.home_unselected),
            selectedIcon: SvgPicture.asset(AssetsManager.home_selected),
            label: '',
          ),
          NavigationDestination(
            icon: SvgPicture.asset(AssetsManager.search_unselected),
            selectedIcon: SvgPicture.asset(AssetsManager.search_selected),
            label: '',
          ),
          NavigationDestination(
            icon: SvgPicture.asset(AssetsManager.sort_unselected),
            selectedIcon: SvgPicture.asset(AssetsManager.sort_selected),
            label: '',
          ),
          NavigationDestination(
            icon: SvgPicture.asset(AssetsManager.profile_unselected),
            selectedIcon: SvgPicture.asset(AssetsManager.profile_selected),
            label: '',
          ),
        ],
      ),
      body: tabs[NavigationBarSelectedIndex],
    );
  }
}
