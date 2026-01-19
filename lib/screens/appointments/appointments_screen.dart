import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../config/theme.dart';
import '../../config/providers.dart';
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
    final locale = context.watch<LocaleProvider>();
    final provider = context.watch<AppointmentsProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(locale.get('appointments')),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: '${locale.get('pending')} (${provider.pendingAppointments.length})'),
            Tab(text: '${locale.get('confirmed')} (${provider.confirmedAppointments.length})'),
            Tab(text: '${locale.get('completed')} (${provider.completedAppointments.length})'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildList(provider.pendingAppointments, 'pending', locale, provider),
          _buildList(provider.confirmedAppointments, 'confirmed', locale, provider),
          _buildList(provider.completedAppointments, 'completed', locale, provider),
        ],
      ),
    );
  }

  Widget _buildList(List list, String type, LocaleProvider locale, AppointmentsProvider provider) {
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
            provider.acceptAppointment(apt.id);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(locale.get('success')), backgroundColor: AppColors.success));
          } : null,
          onReject: type == 'pending' ? () {
            _showRejectDialog(apt.id, locale, provider);
          } : null,
          onStart: type == 'confirmed' ? () => context.push('/chat/${apt.id}') : null,
        );
      },
    );
  }

  void _showRejectDialog(String id, LocaleProvider locale, AppointmentsProvider provider) {
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
              provider.rejectAppointment(id);
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
