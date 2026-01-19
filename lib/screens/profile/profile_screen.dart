import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/theme.dart';
import '../../config/providers.dart';
import '../../widgets/widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _bioController;
  late TextEditingController _feeController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    final doctor = context.read<AuthProvider>().doctor;
    _nameController = TextEditingController(text: doctor?.name ?? '');
    _phoneController = TextEditingController(text: doctor?.phone ?? '');
    _bioController = TextEditingController(text: doctor?.bio ?? '');
    _feeController = TextEditingController(text: '${doctor?.consultationFee.toInt() ?? 200}');
  }

  void _saveProfile() {
    context.read<AuthProvider>().updateProfile(
      name: _nameController.text,
      phone: _phoneController.text,
      bio: _bioController.text,
      fee: double.parse(_feeController.text),
    );
    setState(() => _isEditing = false);
    final locale = context.read<LocaleProvider>();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(locale.get('success')), backgroundColor: AppColors.success));
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<LocaleProvider>();
    final doctor = context.watch<AuthProvider>().doctor;

    return Scaffold(
      appBar: AppBar(
        title: Text(locale.get('profile')),
        actions: [
          if (!_isEditing)
            IconButton(icon: const Icon(Icons.edit), onPressed: () => setState(() => _isEditing = true))
          else
            IconButton(icon: const Icon(Icons.close), onPressed: () => setState(() => _isEditing = false)),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Avatar
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: AppColors.primaryLight,
                  child: Text(doctor?.name[0] ?? 'د', style: const TextStyle(fontSize: 48, color: AppColors.primary)),
                ),
                if (_isEditing)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      backgroundColor: AppColors.primary,
                      radius: 18,
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt, size: 18, color: Colors.white),
                        onPressed: () {},
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Center(child: Text(doctor?.specialtyAr ?? '', style: const TextStyle(color: AppColors.textSecondary))),
          const SizedBox(height: 24),

          // Stats
          Row(
            children: [
              Expanded(child: _StatCard(icon: Icons.star, value: '${doctor?.rating ?? 0}', label: locale.get('rating'), color: Colors.amber)),
              const SizedBox(width: 8),
              Expanded(child: _StatCard(icon: Icons.people, value: '${doctor?.patientsCount ?? 0}', label: locale.get('patients'), color: Colors.blue)),
              const SizedBox(width: 8),
              Expanded(child: _StatCard(icon: Icons.reviews, value: '${doctor?.reviewsCount ?? 0}', label: locale.get('reviews'), color: Colors.green)),
            ],
          ),
          const SizedBox(height: 24),

          // Form
          if (_isEditing) ...[
            AppTextField(controller: _nameController, label: locale.get('name'), prefixIcon: const Icon(Icons.person)),
            const SizedBox(height: 16),
            AppTextField(controller: _phoneController, label: locale.get('phone'), prefixIcon: const Icon(Icons.phone), keyboardType: TextInputType.phone),
            const SizedBox(height: 16),
            AppTextField(controller: _feeController, label: locale.get('consultationFee'), prefixIcon: const Icon(Icons.attach_money), keyboardType: TextInputType.number),
            const SizedBox(height: 16),
            AppTextField(controller: _bioController, label: locale.get('bio'), maxLines: 4),
            const SizedBox(height: 24),
            AppButton(text: locale.get('save'), onPressed: _saveProfile),
          ] else ...[
            _InfoCard(icon: Icons.person, label: locale.get('name'), value: doctor?.name ?? ''),
            _InfoCard(icon: Icons.email, label: locale.get('email'), value: doctor?.email ?? ''),
            _InfoCard(icon: Icons.phone, label: locale.get('phone'), value: doctor?.phone ?? ''),
            _InfoCard(icon: Icons.badge, label: locale.get('licenseNumber'), value: doctor?.licenseNumber ?? ''),
            _InfoCard(icon: Icons.work, label: locale.get('experience'), value: '${doctor?.experienceYears ?? 0} سنة'),
            _InfoCard(icon: Icons.attach_money, label: locale.get('consultationFee'), value: '${doctor?.consultationFee.toInt() ?? 0} جنيه'),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.info, color: AppColors.primary, size: 20),
                        const SizedBox(width: 8),
                        Text(locale.get('bio'), style: const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(doctor?.bio ?? '', style: const TextStyle(height: 1.5)),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    _feeController.dispose();
    super.dispose();
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _StatCard({required this.icon, required this.value, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
          Text(label, style: const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoCard({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
        subtitle: Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
