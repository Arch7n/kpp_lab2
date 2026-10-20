import 'package:flutter/material.dart';

import '../../core/models/parcel.dart';
import '../archive/archive_screen.dart';
import '../home/home_screen.dart';
import '../parcels/add_parcel_screen.dart';
import '../parcels/parcel_details_screen.dart';
import '../parcels/parcels_screen.dart';
import '../profile/profile_screen.dart';

/// Main screen with the bottom navigation bar
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  void _selectTab(int index) => setState(() => _index = index);

  void _openParcel(Parcel parcel) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ParcelDetailsScreen(parcel: parcel),
      ),
    );
  }

  void _addParcel() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const AddParcelScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: [
          HomeScreen(
            onSeeAll: () => _selectTab(1),
            onAddParcel: _addParcel,
            onOpenParcel: _openParcel,
          ),
          ParcelsScreen(onOpenParcel: _openParcel),
          const ArchiveScreen(),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: _selectTab,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Головна',
          ),
          NavigationDestination(
            icon: Icon(Icons.inventory_2_outlined),
            selectedIcon: Icon(Icons.inventory_2),
            label: 'Посилки',
          ),
          NavigationDestination(
            icon: Icon(Icons.archive_outlined),
            selectedIcon: Icon(Icons.archive),
            label: 'Архів',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Профіль',
          ),
        ],
      ),
    );
  }
}
