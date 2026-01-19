import 'package:flutter/material.dart';
import '../config/theme.dart';

// ==================== APP BUTTON ====================
class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isOutlined;
  final Color? color;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (isOutlined) {
      return OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(foregroundColor: color),
        child: isLoading
            ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
            : Text(text),
      );
    }
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(backgroundColor: color),
      child: isLoading
          ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
          : Text(text),
    );
  }
}

// ==================== APP TEXT FIELD ====================
class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final int maxLines;

  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.obscureText = false,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      validator: validator,
    );
  }
}

// ==================== STAT CARD ====================
class StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const StatCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 12),
            Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }
}

// ==================== APPOINTMENT CARD ====================
class AppointmentCard extends StatelessWidget {
  final String patientName;
  final String time;
  final String type;
  final String status;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;
  final VoidCallback? onStart;

  const AppointmentCard({
    super.key,
    required this.patientName,
    required this.time,
    required this.type,
    required this.status,
    this.onAccept,
    this.onReject,
    this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.primaryLight,
                  child: Text(patientName[0], style: const TextStyle(color: AppColors.primary)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(patientName, style: const TextStyle(fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          Icon(Icons.access_time, size: 14, color: AppColors.textSecondary),
                          const SizedBox(width: 4),
                          Text(time, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: type == 'online' ? Colors.blue.withOpacity(0.1) : Colors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              type == 'online' ? 'أونلاين' : 'عيادة',
                              style: TextStyle(fontSize: 10, color: type == 'online' ? Colors.blue : Colors.green),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                _StatusBadge(status: status),
              ],
            ),
            if (status == 'pending' && onAccept != null && onReject != null) ...[
              const Divider(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: onReject,
                      style: OutlinedButton.styleFrom(foregroundColor: AppColors.error),
                      icon: const Icon(Icons.close, size: 18),
                      label: const Text('رفض'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: onAccept,
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.success),
                      icon: const Icon(Icons.check, size: 18),
                      label: const Text('قبول'),
                    ),
                  ),
                ],
              ),
            ],
            if (status == 'confirmed' && onStart != null) ...[
              const Divider(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onStart,
                  icon: const Icon(Icons.video_call),
                  label: const Text('بدء الاستشارة'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    String text;
    switch (status) {
      case 'pending':
        color = AppColors.warning;
        text = 'في الانتظار';
        break;
      case 'confirmed':
        color = AppColors.success;
        text = 'مؤكد';
        break;
      case 'completed':
        color = AppColors.info;
        text = 'مكتمل';
        break;
      case 'cancelled':
        color = AppColors.error;
        text = 'ملغي';
        break;
      default:
        color = AppColors.textSecondary;
        text = status;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
      child: Text(text, style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.bold)),
    );
  }
}

// ==================== PATIENT CARD ====================
class PatientCard extends StatelessWidget {
  final String name;
  final String phone;
  final int visits;
  final DateTime lastVisit;
  final VoidCallback onTap;

  const PatientCard({
    super.key,
    required this.name,
    required this.phone,
    required this.visits,
    required this.lastVisit,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.primaryLight,
          child: Text(name[0], style: const TextStyle(color: AppColors.primary)),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('آخر زيارة: ${lastVisit.day}/${lastVisit.month}/${lastVisit.year}', style: const TextStyle(fontSize: 12)),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$visits', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary, fontSize: 18)),
            const Text('زيارات', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
