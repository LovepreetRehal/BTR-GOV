import 'package:btr_gov/screens/assets_screen.dart';
import 'package:btr_gov/screens/farmers_screen.dart';
import 'package:flutter/material.dart';
import 'add_farmer_screen.dart';
import 'home_fragment_screen.dart';
import 'message_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyNavigationBar(),
    );
  }
}

class MyNavigationBar extends StatefulWidget {
  MyNavigationBar({Key? key}) : super(key: key);

  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomeFragmentScreen(),
    AddFarmerScreen(
      edit: false,
    ),
    FarmersScreen(),
    AssetsScreen(),
    MessageScreen(),
  ];

  // static const List<Widget> _widgetOptions = <Widget>[
  //   Text('Home Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
  //   Text('Search Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
  //   Text('Profile Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
  // ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //     title: const Text('Flutter BottomNavigationBar Example'),
      //     backgroundColor: Colors.green
      // ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      backgroundColor:
          Colors.indigo[400], // Set the background color of the Scaffold
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Dashboard',
            backgroundColor:
                Colors.indigo, // Set the background color of the Scaffold
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add_outlined),
            label: 'Add Farmers',
            backgroundColor:
                Colors.indigo, // Set the background color of the Scaffold
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Farmers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message_outlined),
            label: 'Assets',
            backgroundColor:
                Colors.indigo, // Set the background color of the Scaffold
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forward_to_inbox_outlined),
            label: 'Messages',
            backgroundColor:
                Colors.indigo, // Set the background color of the Scaffold
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey, // Set the unselected icon color
        selectedItemColor: Colors.white,
        iconSize: 24,

        onTap: _onItemTapped,
        elevation: 5,
        showSelectedLabels: true, // Show text labels always
        showUnselectedLabels: true, // Show text labels always
        selectedLabelStyle: const TextStyle(
          fontSize: 10, // Smaller text size for selected labels
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 10, // Smaller text size for unselected labels
        ),
      ),
    );
  }
}
