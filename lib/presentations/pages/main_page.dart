import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:finly/presentations/pages/category_page.dart';
import 'package:finly/presentations/pages/home_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Widget> _pages = const [HomePage(), CategoryPage()];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      floatingActionButton: MainFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        shadow: Shadow(
          color: Colors.black12,
          blurRadius: 6,
          offset: Offset(0, -6),
        ),
        icons: [Icons.home, Icons.category],
        activeIndex: _currentIndex,
        activeColor: Colors.orange,
        inactiveColor: Colors.black38,
        borderColor: Colors.orange,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.smoothEdge,
        height: MediaQuery.sizeOf(context).height * 0.08,
        onTap: (index) => setState(() {
          _currentIndex = index;
        }),
      ),
    );
  }
}

class MainFloatingActionButton extends StatelessWidget {
  const MainFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      backgroundColor: Colors.orange,
      child: Icon(Icons.add, color: Colors.white),
    );
  }
}
