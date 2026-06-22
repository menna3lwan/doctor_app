import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_ui/shared_ui.dart';
import '../../controllers/auth_controller.dart';
import '../../config/locale.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    
    final auth = Get.find<AuthController>();
    final success = await auth.login(
      _emailController.text,
      _passwordController.text,
    );

    if (success) {
      Get.offAllNamed('/dashboard');
    } else if (mounted) {
      final locale = Get.find<LocaleController>();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(locale.get('error')), backgroundColor: AppColors.error),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = Get.find<LocaleController>();
    final auth = Get.find<AuthController>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: AppColors.primaryLight, shape: BoxShape.circle),
                  child: const Icon(Icons.medical_services, size: 60, color: AppColors.primary),
                ),
                const SizedBox(height: 24),
                Text(locale.get('appName'), style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                const SizedBox(height: 8),
                Text(locale.get('login'), style: const TextStyle(color: AppColors.textSecondary), textAlign: TextAlign.center),
                const SizedBox(height: 40),

                // Language Toggle
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () => locale.setArabic(),
                      child: Text('العربية', style: TextStyle(color: locale.isArabic.value ? AppColors.primary : AppColors.textSecondary, fontWeight: locale.isArabic.value ? FontWeight.bold : null)),
                    ),
                    const Text('|'),
                    TextButton(
                      onPressed: () => locale.setEnglish(),
                      child: Text('English', style: TextStyle(color: !locale.isArabic.value ? AppColors.primary : AppColors.textSecondary, fontWeight: !locale.isArabic.value ? FontWeight.bold : null)),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                AppTextField(
                  controller: _emailController,
                  label: locale.get('email'),
                  hint: 'dr.example@email.com',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.email_outlined),
                  validator: (v) => v?.isEmpty ?? true ? locale.get('error') : null,
                ),
                const SizedBox(height: 16),

                AppTextField(
                  controller: _passwordController,
                  label: locale.get('password'),
                  obscureText: _obscurePassword,
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                    onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                  ),
                  validator: (v) => (v?.length ?? 0) < 6 ? locale.get('error') : null,
                ),
                const SizedBox(height: 32),

                AppButton(
                  text: locale.get('login'),
                  isLoading: auth.isLoading.value,
                  onPressed: _login,
                ),
                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(locale.get('dontHaveAccount')),
                    TextButton(
                      onPressed: () => Get.toNamed('/register'),
                      child: Text(locale.get('registerNow')),
                    ),
                  ],
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
