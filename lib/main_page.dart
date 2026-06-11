import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:finly/presentations/pages/category_page.dart';
import 'package:finly/presentations/pages/home_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> pages = [const HomePage(), const CategoryPage()];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CalendarAppBar(
        onDateChanged: (value) => print(value),
        firstDate: DateTime.now().subtract(Duration(days: 140)),
        lastDate: DateTime.now(),
        backButton: false,
        locale: 'id',
        accent: Colors.orange,
      ),
      body: pages[currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: Colors.orange,
        child: Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: [Icons.home, Icons.category],
        activeIndex: currentIndex,
        activeColor: Colors.orange,
        inactiveColor: Colors.black38,
        borderColor: Colors.orange,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.smoothEdge,
        height: MediaQuery.sizeOf(context).height * 0.08,
        onTap: (index) => setState(() {
          currentIndex = index;
        }),
      ),
    );
  }
}
