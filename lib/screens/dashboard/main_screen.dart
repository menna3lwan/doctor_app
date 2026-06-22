import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/locale.dart';
import '../dashboard/dashboard_screen.dart';
import '../appointments/appointments_screen.dart';
import '../patients/patients_screen.dart';
import '../settings/settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final _screens = const [
    DashboardScreen(),
    AppointmentsScreen(),
    PatientsScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final locale = Get.find<LocaleController>();

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.dashboard), label: locale.get('dashboard')),
          BottomNavigationBarItem(icon: const Icon(Icons.calendar_today), label: locale.get('appointments')),
          BottomNavigationBarItem(icon: const Icon(Icons.people), label: locale.get('patients')),
          BottomNavigationBarItem(icon: const Icon(Icons.settings), label: locale.get('settings')),
        ],
      )),
    );
  }
}
