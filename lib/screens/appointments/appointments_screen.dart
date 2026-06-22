import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_ui/shared_ui.dart';
import '../../controllers/appointments_controller.dart';
import '../../config/locale.dart';
import '../../widgets/widgets.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final locale = Get.find<LocaleController>();
    final controller = Get.find<AppointmentsController>();

    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(locale.get('appointments'))),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Obx(() => TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: '${locale.get('pending')} (${controller.pendingAppointments.length})'),
              Tab(text: '${locale.get('confirmed')} (${controller.confirmedAppointments.length})'),
              Tab(text: '${locale.get('completed')} (${controller.completedAppointments.length})'),
            ],
          )),
        ),
      ),
      body: Obx(() => TabBarView(
        controller: _tabController,
        children: [
          _buildList(controller.pendingAppointments, 'pending', locale, controller),
          _buildList(controller.confirmedAppointments, 'confirmed', locale, controller),
          _buildList(controller.completedAppointments, 'completed', locale, controller),
        ],
      )),
    );
  }

  Widget _buildList(List list, String type, LocaleController locale, AppointmentsController controller) {
    if (list.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.calendar_today, size: 64, color: AppColors.divider),
            const SizedBox(height: 16),
            Text(
              type == 'pending' ? locale.get('noPending') : type == 'confirmed' ? locale.get('noConfirmed') : locale.get('noCompleted'),
              style: const TextStyle(color: AppColors.textSecondary),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final apt = list[index];
        return AppointmentCard(
          patientName: apt.patient.name,
          time: '${apt.date.day}/${apt.date.month} - ${apt.time}',
          type: apt.type,
          status: apt.status,
          onAccept: type == 'pending' ? () {
            controller.acceptAppointment(apt.id);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(locale.get('success')), backgroundColor: AppColors.success));
          } : null,
          onReject: type == 'pending' ? () {
            _showRejectDialog(apt.id, locale, controller);
          } : null,
          onStart: type == 'confirmed' ? () => Get.toNamed('/chat/${apt.id}') : null,
        );
      },
    );
  }

  void _showRejectDialog(String id, LocaleController locale, AppointmentsController controller) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(locale.get('reject')),
        content: Text(locale.get('rejectConfirm')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(locale.get('cancel'))),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            onPressed: () {
              controller.rejectAppointment(id);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(locale.get('success')), backgroundColor: AppColors.error));
            },
            child: Text(locale.get('reject')),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
