import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../config/theme.dart';
import '../../config/providers.dart';
import '../../widgets/widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _licenseController = TextEditingController();
  final _bioController = TextEditingController();
  String _specialty = 'gynecology';
  int _experience = 5;
  bool _obscurePassword = true;

  final _specialties = [
    {'value': 'gynecology', 'label': 'نساء وتوليد'},
    {'value': 'dermatology', 'label': 'جلدية وتجميل'},
    {'value': 'psychology', 'label': 'نفسية'},
  ];

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    
    final success = await context.read<AuthProvider>().register(
      name: _nameController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      password: _passwordController.text,
      specialty: _specialty,
      licenseNumber: _licenseController.text,
      experience: _experience,
      bio: _bioController.text,
    );

    if (success && mounted) {
      context.go('/pending');
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<LocaleProvider>();
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(title: Text(locale.get('register'))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: AppColors.primaryLight, shape: BoxShape.circle),
                child: const Icon(Icons.person_add, size: 40, color: AppColors.primary),
              ),
              const SizedBox(height: 24),

              AppTextField(
                controller: _nameController,
                label: locale.get('name'),
                prefixIcon: const Icon(Icons.person_outline),
                validator: (v) => v?.isEmpty ?? true ? locale.get('error') : null,
              ),
              const SizedBox(height: 16),

              AppTextField(
                controller: _emailController,
                label: locale.get('email'),
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(Icons.email_outlined),
                validator: (v) => v?.isEmpty ?? true ? locale.get('error') : null,
              ),
              const SizedBox(height: 16),

              AppTextField(
                controller: _phoneController,
                label: locale.get('phone'),
                keyboardType: TextInputType.phone,
                prefixIcon: const Icon(Icons.phone_outlined),
                validator: (v) => (v?.length ?? 0) < 11 ? locale.get('error') : null,
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                value: _specialty,
                decoration: InputDecoration(
                  labelText: locale.get('specialty'),
                  prefixIcon: const Icon(Icons.medical_services_outlined),
                ),
                items: _specialties.map((s) => DropdownMenuItem(value: s['value'], child: Text(s['label']!))).toList(),
                onChanged: (v) => setState(() => _specialty = v!),
              ),
              const SizedBox(height: 16),

              AppTextField(
                controller: _licenseController,
                label: locale.get('licenseNumber'),
                prefixIcon: const Icon(Icons.badge_outlined),
                validator: (v) => v?.isEmpty ?? true ? locale.get('error') : null,
              ),
              const SizedBox(height: 16),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${locale.get('experience')}: $_experience', style: const TextStyle(fontWeight: FontWeight.bold)),
                  Slider(
                    value: _experience.toDouble(),
                    min: 1,
                    max: 30,
                    divisions: 29,
                    label: '$_experience',
                    activeColor: AppColors.primary,
                    onChanged: (v) => setState(() => _experience = v.toInt()),
                  ),
                ],
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
              const SizedBox(height: 16),

              AppTextField(
                controller: _bioController,
                label: locale.get('bio'),
                maxLines: 3,
              ),
              const SizedBox(height: 32),

              AppButton(
                text: locale.get('register'),
                isLoading: auth.isLoading,
                onPressed: _register,
              ),
              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(locale.get('alreadyHaveAccount')),
                  TextButton(
                    onPressed: () => context.pop(),
                    child: Text(locale.get('loginNow')),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _licenseController.dispose();
    _bioController.dispose();
    super.dispose();
  }
}
