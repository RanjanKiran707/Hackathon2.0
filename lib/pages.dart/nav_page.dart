import 'package:flutter/material.dart';
import 'package:todo/pages.dart/food_page.dart';
import 'package:todo/pages.dart/forum_page.dart';
import 'package:todo/pages.dart/home_page.dart';
import 'package:velocity_x/velocity_x.dart';

class NavPage extends StatefulWidget {
  const NavPage({Key? key}) : super(key: key);

  @override
  State<NavPage> createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: index,
        children: [
          HomePage(),
          FoodPage(),
          Container(),
          ForumPage(),
          Container(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Food",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Excersise",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Forum",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
