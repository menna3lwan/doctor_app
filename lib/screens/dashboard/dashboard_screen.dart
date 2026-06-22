import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_ui/shared_ui.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/appointments_controller.dart';
import '../../controllers/earnings_controller.dart';
import '../../config/locale.dart';
import '../../widgets/widgets.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = Get.find<LocaleController>();
    final auth = Get.find<AuthController>();
    final appointments = Get.find<AppointmentsController>();
    final earnings = Get.find<EarningsController>();

    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${locale.get('hello')} 👋', style: const TextStyle(fontSize: 14, color: AppColors.textSecondary)),
            Text(auth.doctor.value?.name ?? '', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        )),
        actions: [
          IconButton(icon: const Icon(Icons.notifications_outlined), onPressed: () {}),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => await Future.delayed(const Duration(seconds: 1)),
        child: Obx(() {
          final doctor = auth.doctor.value;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Stats Cards
              Row(
                children: [
                  Expanded(child: StatCard(icon: Icons.calendar_today, value: '${appointments.todayAppointments.length}', label: locale.get('todayAppointments'), color: AppColors.primary)),
                  const SizedBox(width: 12),
                  Expanded(child: StatCard(icon: Icons.people, value: '${doctor?.patientsCount ?? 0}', label: locale.get('totalPatients'), color: Colors.blue)),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: StatCard(icon: Icons.star, value: '${doctor?.rating ?? 0}', label: locale.get('rating'), color: Colors.amber)),
                  const SizedBox(width: 12),
                  Expanded(child: StatCard(icon: Icons.attach_money, value: '${earnings.monthlyEarnings.toInt()}', label: locale.get('monthlyEarnings'), color: Colors.green)),
                ],
              ),
              const SizedBox(height: 24),

              // Today's Appointments
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(locale.get('todayAppointments'), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  TextButton(onPressed: () {}, child: Text(locale.get('viewAll'))),
                ],
              ),
              const SizedBox(height: 12),

              if (appointments.todayAppointments.isEmpty)
                Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: [
                      const Icon(Icons.calendar_today, size: 48, color: AppColors.divider),
                      const SizedBox(height: 16),
                      Text(locale.get('noPending'), style: const TextStyle(color: AppColors.textSecondary)),
                    ],
                  ),
                )
              else
                ...appointments.todayAppointments.take(3).map((apt) => AppointmentCard(
                  patientName: apt.patient.name,
                  time: apt.time,
                  type: apt.type,
                  status: apt.status,
                  onAccept: apt.status == 'pending' ? () {
                    appointments.acceptAppointment(apt.id);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(locale.get('success')), backgroundColor: AppColors.success));
                  } : null,
                  onReject: apt.status == 'pending' ? () {
                    appointments.rejectAppointment(apt.id);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(locale.get('success')), backgroundColor: AppColors.error));
                  } : null,
                  onStart: apt.status == 'confirmed' ? () => Get.toNamed('/chat/${apt.id}') : null,
                )),

              const SizedBox(height: 24),

              // Quick Actions
              Text(locale.get('quickActions'), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: _QuickActionCard(icon: Icons.location_on, label: locale.get('branches'), onTap: () => Get.toNamed('/branches'))),
                  const SizedBox(width: 12),
                  Expanded(child: _QuickActionCard(icon: Icons.person, label: locale.get('profile'), onTap: () => Get.toNamed('/profile'))),
                  const SizedBox(width: 12),
                  Expanded(child: _QuickActionCard(icon: Icons.attach_money, label: locale.get('earnings'), onTap: () {})),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickActionCard({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(icon, color: AppColors.primary, size: 28),
              const SizedBox(height: 8),
              Text(label, style: const TextStyle(fontSize: 12), textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
