import 'package:flutter/material.dart';
import 'Counter.dart'; 
import 'Profile.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  final List<Widget> _pages = <Widget>[
    const Profile(),
    const Counter(), 
    
  ];

  
  void _onItemTapped(int index) {
    
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // appBar: AppBar(
        //   title: const Text("My Profile & Counter App"),
        //   backgroundColor: Colors.blue,
        //   foregroundColor: Colors.white,
        // ),
        
        body: _pages[_selectedIndex],

        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
            BottomNavigationBarItem(icon: Icon(Icons.numbers), label: "Counter"),
          ],
          
          currentIndex: _selectedIndex, 
          onTap: _onItemTapped, 
          selectedItemColor: Colors.blue, 
        ),
      ),
    );
  }
}