import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/auth/pending_screen.dart';
import '../screens/dashboard/main_screen.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/appointments/appointments_screen.dart';
import '../screens/patients/patients_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/chat/chat_screen.dart';
import '../screens/branches/branches_screen.dart';
import '../screens/branches/add_branch_screen.dart';
import '../screens/profile/profile_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
      GoRoute(path: '/register', builder: (_, __) => const RegisterScreen()),
      GoRoute(path: '/pending', builder: (_, __) => const PendingScreen()),
      
      ShellRoute(
        builder: (_, __, child) => MainScreen(child: child),
        routes: [
          GoRoute(path: '/dashboard', builder: (_, __) => const DashboardScreen()),
          GoRoute(path: '/appointments', builder: (_, __) => const AppointmentsScreen()),
          GoRoute(path: '/patients', builder: (_, __) => const PatientsScreen()),
          GoRoute(path: '/settings', builder: (_, __) => const SettingsScreen()),
        ],
      ),
      
      GoRoute(path: '/chat/:id', builder: (_, state) => ChatScreen(appointmentId: state.pathParameters['id']!)),
      GoRoute(path: '/branches', builder: (_, __) => const BranchesScreen()),
      GoRoute(path: '/add-branch', builder: (_, __) => const AddBranchScreen()),
      GoRoute(path: '/profile', builder: (_, __) => const ProfileScreen()),
    ],
  );
}
