import 'package:flutter/material.dart';

import 'package:shoe_shop/utils/colors.dart';
import 'package:shoe_shop/views/screens/article_data_adding_screen.dart/article_data_adding_screen.dart';
import 'package:shoe_shop/views/screens/daily_sale/daily_sale_screen.dart';
import 'package:shoe_shop/views/screens/home_screen/home_screen.dart';
import 'package:shoe_shop/views/screens/profile_screen/profile_screen.dart';
import 'package:shoe_shop/views/screens/search_screen/search_screen.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({
    super.key,
    this.screenIndex = 0,
  });
  final int screenIndex;
  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  final List<Widget> _widgetList = [
    HomeScreen(),
    const DailySaleScreen(),
    const ArticleDataAddingScreen(),
    const SearchScreen(),
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
        floatingActionButton: MediaQuery.of(context).viewInsets.bottom == 0
            ? _selectedIndex == 1
                ? null
                : FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 2;
                        _fab = primaryColor;
                      });
                    },
                    backgroundColor: _fab,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: _selectedIndex == 2
                        ? const Icon(
                            Icons.add,
                            size: 30,
                            color: Colors.white,
                          )
                        : const Icon(
                            Icons.add,
                            color: greyColor,
                          ),
                  )
            : null,
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
                        color: primaryColor,
                      )
                    : const Icon(
                        Icons.home_outlined,
                        color: greyColor,
                      ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _selectedIndex = 1;
                    _fab = Colors.white;
                  });
                },
                icon: _selectedIndex == 1
                    ? const Icon(
                        Icons.list_alt,
                        size: 30,
                        color: primaryColor,
                      )
                    : const Icon(
                        Icons.list_alt_outlined,
                        color: greyColor,
                      ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _selectedIndex = 3;
                    _fab = Colors.white;
                  });
                },
                icon: _selectedIndex == 3
                    ? const Icon(
                        Icons.search,
                        size: 30,
                        color: primaryColor,
                      )
                    : const Icon(
                        Icons.search_outlined,
                        color: greyColor,
                      ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _selectedIndex = 4;
                    _fab = Colors.white;
                  });
                },
                icon: _selectedIndex == 4
                    ? const Icon(
                        Icons.person,
                        size: 30,
                        color: primaryColor,
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
