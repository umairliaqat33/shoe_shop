import 'package:flutter/material.dart';
import 'package:shoe_shop/utils/colors.dart';
import 'package:shoe_shop/views/screens/article_data_adding_screen.dart/data_adding_screen.dart';
import 'package:shoe_shop/views/screens/home_screen/home_screen.dart';
import 'package:shoe_shop/views/screens/profile_screen/profile_screen.dart';

class BottomAppBarScreen extends StatefulWidget {
  const BottomAppBarScreen({
    super.key,
    this.screenIndex = 0,
  });
  final int screenIndex;
  @override
  State<BottomAppBarScreen> createState() => _BottomAppBarScreenState();
}

class _BottomAppBarScreenState extends State<BottomAppBarScreen> {
  final List<Widget> _widgetList = [
    HomeScreen(),
    const DataAddingScreen(),
    const ProfileScreen(),
  ];
  int _selectedIndex = 0;
  Color _fab = whiteColor;
  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.screenIndex;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _selectedIndex = 1;
              _fab = Colors.blue;
            });
          },
          backgroundColor: _fab,
          child: _selectedIndex == 1
              ? const Icon(
                  Icons.add,
                  size: 30,
                  color: Colors.white,
                )
              : const Icon(
                  Icons.add,
                  color: greyColor,
                ),
        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _selectedIndex = 0;
                    _fab = Colors.white;
                  });
                },
                icon: _selectedIndex == 0
                    ? const Icon(
                        Icons.home,
                        size: 30,
                        color: Colors.blue,
                      )
                    : const Icon(
                        Icons.home_outlined,
                        color: greyColor,
                      ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _selectedIndex = 2;
                    _fab = Colors.white;
                  });
                },
                icon: _selectedIndex == 2
                    ? const Icon(
                        Icons.person,
                        size: 30,
                        color: Colors.blue,
                      )
                    : const Icon(
                        Icons.person_outline,
                        color: greyColor,
                      ),
              ),
            ],
          ),
        ),
        body: _widgetList[_selectedIndex],
      ),
    );
  }
}
