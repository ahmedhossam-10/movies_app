import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/core/resources/ColorManager.dart';
import 'package:movies_app/core/resources/AssetsManager.dart';
import 'package:movies_app/ui/home/taps/home_tab/HomeTab.dart';
import 'package:movies_app/ui/home/taps/profile_tab/ProfileTab.dart';
import 'package:movies_app/ui/home/taps/search_tab/SearchTab.dart';
import 'package:movies_app/ui/home/taps/sort_tap/SortTab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int navigationBarSelectedIndex = 0;

  late List<Widget> tabs;

  @override
  void initState() {
    super.initState();
    tabs = [
      HomeTab(
        onSeeMoreTap: () {
          setState(() {
            navigationBarSelectedIndex = 2;
          });
        },
      ),
      const SearchTab(),
      const SortTab(),
      const ProfileTab(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // Screen size for responsive scaling
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final horizontalPadding = screenWidth * 0.04; // ~16 on standard 400px width
    final bottomPadding = screenHeight * 0.02; // ~16 on standard 800px height
    final iconSize = screenWidth * 0.07; // ~28px standard

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Main content
          tabs[navigationBarSelectedIndex],
          // Floating bottom nav bar
          Positioned(
            left: horizontalPadding,
            right: horizontalPadding,
            bottom: bottomPadding,
            child: Container(
              decoration: BoxDecoration(
                color: ColorManager.darkGray,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: EdgeInsets.symmetric(vertical: bottomPadding / 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _NavItem(
                    icon: AssetsManager.home_unselected,
                    selectedIcon: AssetsManager.home_selected,
                    isActive: navigationBarSelectedIndex == 0,
                    iconSize: iconSize,
                    onTap: () => setState(() => navigationBarSelectedIndex = 0),
                  ),
                  _NavItem(
                    icon: AssetsManager.search_unselected,
                    selectedIcon: AssetsManager.search_selected,
                    isActive: navigationBarSelectedIndex == 1,
                    iconSize: iconSize,
                    onTap: () => setState(() => navigationBarSelectedIndex = 1),
                  ),
                  _NavItem(
                    icon: AssetsManager.sort_unselected,
                    selectedIcon: AssetsManager.sort_selected,
                    isActive: navigationBarSelectedIndex == 2,
                    iconSize: iconSize,
                    onTap: () => setState(() => navigationBarSelectedIndex = 2),
                  ),
                  _NavItem(
                    icon: AssetsManager.profile_unselected,
                    selectedIcon: AssetsManager.profile_selected,
                    isActive: navigationBarSelectedIndex == 3,
                    iconSize: iconSize,
                    onTap: () => setState(() => navigationBarSelectedIndex = 3),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Nav Item
class _NavItem extends StatelessWidget {
  final String icon;
  final String selectedIcon;
  final bool isActive;
  final double iconSize;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.selectedIcon,
    required this.isActive,
    required this.iconSize,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SvgPicture.asset(
        isActive ? selectedIcon : icon,
        height: iconSize,
        width: iconSize,
      ),
    );
  }
}
