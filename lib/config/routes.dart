import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/auth/pending_screen.dart';
import '../screens/dashboard/main_screen.dart';
import '../screens/chat/chat_screen.dart';
import '../screens/branches/branches_screen.dart';
import '../screens/branches/add_branch_screen.dart';
import '../screens/profile/profile_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String pending = '/pending';
  static const String dashboard = '/dashboard';
  static const String chat = '/chat';
  static const String branches = '/branches';
  static const String addBranch = '/add-branch';
  static const String profile = '/profile';

  static String get initialRoute {
    final auth = Get.find<AuthController>();
    return auth.isLoggedIn.value ? dashboard : login;
  }

  static List<GetPage> get pages => [
        GetPage(
          name: login,
          page: () => const LoginScreen(),
        ),
        GetPage(
          name: register,
          page: () => const RegisterScreen(),
        ),
        GetPage(
          name: pending,
          page: () => const PendingScreen(),
        ),
        GetPage(
          name: dashboard,
          page: () => const MainScreen(),
          middlewares: [AuthMiddleware()],
        ),
        GetPage(
          name: '$chat/:id',
          page: () => ChatScreen(appointmentId: Get.parameters['id']!),
        ),
        GetPage(
          name: branches,
          page: () => const BranchesScreen(),
        ),
        GetPage(
          name: addBranch,
          page: () => const AddBranchScreen(),
        ),
        GetPage(
          name: profile,
          page: () => const ProfileScreen(),
        ),
      ];
}

class AuthMiddleware extends GetMiddleware {
  @override
  int? get priority => 0;

  @override
  RouteSettings? redirect(String? route) {
    final auth = Get.find<AuthController>();
    if (!auth.isLoggedIn.value) {
      return const RouteSettings(name: AppRoutes.login);
    }
    return null;
  }
}
