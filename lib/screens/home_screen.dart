import 'package:btr_gov/screens/assets_screen.dart';
import 'package:btr_gov/screens/farmers_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
    AddFarmerScreen(edit: false,),
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
      body: Center(child: _widgetOptions.elementAt(_selectedIndex),),
      backgroundColor:
          Colors.indigo[400], // Set the background color of the Scaffold
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/dashoard.svg',
              height: 24,
              color: _selectedIndex == 0 ? Colors.white : Colors.grey,
            ),
            label: 'Dashboard',
            backgroundColor: Colors.indigo,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/add_famer.svg',
              height: 24,
              color: _selectedIndex == 1 ? Colors.white : Colors.grey,
            ),
            label: 'Add Farmers',
            backgroundColor: Colors.indigo,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/farmer.svg',
              height: 24,
              color: _selectedIndex == 2 ? Colors.white : Colors.grey,
            ),
            label: 'Farmers',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/assets.svg',
              height: 24,
              color: _selectedIndex == 3 ? Colors.white : Colors.grey,
            ),
            label: 'Assets',
            backgroundColor: Colors.indigo,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/message.svg',
              height: 24,
              color: _selectedIndex == 4 ? Colors.white : Colors.grey,
            ),
            label: 'Messages',
            backgroundColor: Colors.indigo,
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.white,
        iconSize: 24,
        onTap: _onItemTapped,
        elevation: 5,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(fontSize: 10),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
      ),
    );
  }
}
