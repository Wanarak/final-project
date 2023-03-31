import 'package:flutter/material.dart';
import './add_delivery.dart';
import './list_delivery.dart';
import './edit_delivery.dart';
import './homepage.dart';
import './list_restaurant.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var app = MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  );
  runApp(app);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  final List<Widget> _pageWidget = [HomePage(), ListDelivery(), ListRestaurant()];

  changeIndex(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pageWidget.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        color: Color.fromRGBO(85, 15, 197, 1),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 20),
          child: GNav(
            backgroundColor: Color.fromRGBO(85, 15, 197, 1),
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Color.fromARGB(248, 223, 76, 161),
            gap: 8,
            padding: EdgeInsets.all(16),
            tabs: const [ 
              GButton(icon: Icons.home,text: 'Home',iconSize: 20),
              GButton(icon: Icons.person,text: 'Delivery',iconSize: 20), 
              GButton(icon: Icons.store,text: 'Restaurant',iconSize: 20),
            ],
            selectedIndex: _selectedIndex,
        
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}

