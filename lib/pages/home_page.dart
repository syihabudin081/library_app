import 'package:flutter/material.dart';
import 'package:stock_app/pages/best_seller_books.dart';
import 'package:stock_app/pages/book_categories.dart';
import 'package:stock_app/pages/book_search.dart';
import 'package:stock_app/common/styles.dart';
import 'package:stock_app/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const routeName = '/home_page';
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottonNavIndex = 0;

  final List<BottomNavigationBarItem> _bottomNavBarItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: 'Search',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.list),
      label: 'Categories',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.star),
      label: 'Top Seller',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
    ),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottonNavIndex = index;
    });
  }

  final List<Widget> _listWidget = [
    const BookSearchPage(),
    const BookCategories(),
    const BestSellerBooks(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottonNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryColor,
        currentIndex: _bottonNavIndex,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
      ),
    );
  }
}