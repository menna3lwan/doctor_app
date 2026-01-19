import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../config/theme.dart';
import '../../config/providers.dart';

class MainScreen extends StatelessWidget {
  final Widget child;
  const MainScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<LocaleProvider>();
    final currentLocation = GoRouterState.of(context).uri.toString();

    int currentIndex = 0;
    if (currentLocation.startsWith('/dashboard')) currentIndex = 0;
    else if (currentLocation.startsWith('/appointments')) currentIndex = 1;
    else if (currentLocation.startsWith('/patients')) currentIndex = 2;
    else if (currentLocation.startsWith('/settings')) currentIndex = 3;

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          switch (index) {
            case 0: context.go('/dashboard'); break;
            case 1: context.go('/appointments'); break;
            case 2: context.go('/patients'); break;
            case 3: context.go('/settings'); break;
          }
        },
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.dashboard), label: locale.get('dashboard')),
          BottomNavigationBarItem(icon: const Icon(Icons.calendar_today), label: locale.get('appointments')),
          BottomNavigationBarItem(icon: const Icon(Icons.people), label: locale.get('patients')),
          BottomNavigationBarItem(icon: const Icon(Icons.settings), label: locale.get('settings')),
        ],
      ),
    );
  }
}
