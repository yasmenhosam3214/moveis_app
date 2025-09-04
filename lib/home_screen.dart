import 'package:flutter/material.dart';
import 'tabs/home/home_tab.dart';
import 'tabs/search/search_tab.dart';
import 'tabs/browse/browse_tab.dart';
import 'tabs/profile/profile_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  final List<Widget> tabs = [HomeTab(), SearchTab(), BrowseTab(), ProfileTab()];

  Widget buildNavIcon(String imagePath, String activePath, bool isActive) {
    return Image.asset(
      isActive ? activePath : imagePath,
      width: 26,
      height: 23,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,

      body: tabs[currentIndex],

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 16, left: 9, right: 9),
        child: Container(
          height: 61,
          decoration: BoxDecoration(
            color: const Color(0xFF282A28),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => setState(() => currentIndex = 0),
                child: buildNavIcon(
                  "assets/icons/Vector (home).png",
                  "assets/icons/vector (home_active).png",
                  currentIndex == 0,
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => currentIndex = 1),
                child: buildNavIcon(
                  "assets/icons/Vector (search).png",
                  "assets/icons/Vector (search_active).png",
                  currentIndex == 1,
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => currentIndex = 2),
                child: buildNavIcon(
                  "assets/icons/Vector(browse).png",
                  "assets/icons/Vector(browse_active).png",
                  currentIndex == 2,
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => currentIndex = 3),
                child: buildNavIcon(
                  "assets/icons/Vector(Profiel).png",
                  "assets/icons/Vector(Profile_active).png",
                  currentIndex == 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
