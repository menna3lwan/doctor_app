import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_ui/shared_ui.dart';
import '../../config/locale.dart';

class PendingScreen extends StatelessWidget {
  const PendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = Get.find<LocaleController>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Obx(() => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(color: AppColors.warning.withOpacity(0.1), shape: BoxShape.circle),
                child: const Icon(Icons.hourglass_empty, size: 80, color: AppColors.warning),
              ),
              const SizedBox(height: 32),
              Text(locale.get('pendingApproval'), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Text(locale.get('pendingMessage'), textAlign: TextAlign.center, style: const TextStyle(color: AppColors.textSecondary, height: 1.5)),
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Get.offAllNamed('/login'),
                  child: Text(locale.get('logout')),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
