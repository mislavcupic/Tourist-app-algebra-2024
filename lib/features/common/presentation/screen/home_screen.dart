import 'package:flutter/material.dart';
import 'package:practical_class_01/features/locations/presentation/favorite_list/screen/favorite_list_screen.dart';
import 'package:practical_class_01/features/locations/presentation/location_list/screen/location_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  final _screens = [
    LocationListScreen(),
    FavoriteListScreen(),
    Text('Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _screens[index],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (newIndex) => setState(() => index = newIndex),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.explore_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_outline_rounded), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded), label: 'Profile'),
        ],
      ),
    );
  }
}
