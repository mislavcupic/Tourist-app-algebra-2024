import 'package:flutter/material.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:tourist_project_mc/features/auth/presentation/screen/profile_screen.dart';
import 'package:tourist_project_mc/features/locations/presentation/favorite_list/screen/favorite_list_screen.dart';
import 'package:tourist_project_mc/features/locations/presentation/location_list/screen/location_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  final _screens = [
    const LocationListScreen(),
    const FavoriteListScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _screens,
      ),
      bottomNavigationBar: MotionTabBar(
        initialSelectedTab: "Places",
        useSafeArea: true,
        labels: const ["Places", "Favorites", "Profile"],
        icons: const [
          Icons.place_outlined,
          Icons.favorite_border,
          Icons.person_outline,
        ],
        tabSize: 50,
        tabBarHeight: 65,
        textStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        tabIconColor: Colors.grey,
        tabIconSize: 28.0,
        tabIconSelectedSize: 26.0,
        tabSelectedColor: Colors.grey,
        tabIconSelectedColor: Colors.white,
        tabBarColor: Colors.white,
        onTabItemSelected: (index) {
          setState(() => _selectedIndex = index);
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
