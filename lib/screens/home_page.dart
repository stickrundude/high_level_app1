import 'package:flutter/material.dart';
import 'settings_page.dart';
import 'map_page.dart';
import 'camera_page.dart';
import 'notes_page.dart';
import '../widgets/custom_navigation_bar.dart';

class TravelMateHomePage extends StatefulWidget {
  const TravelMateHomePage({super.key});

  @override
  State<TravelMateHomePage> createState() => _TravelMateHomePageState();
}

class _TravelMateHomePageState extends State<TravelMateHomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    MapPage(),
    CameraPage(),
    NotesPage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('TravelMate'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(child: _pages[_selectedIndex]),
        ],
      ),
      bottomNavigationBar: CustomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
