import 'package:get/get.dart';
import '../models/models.dart';

class AppointmentsController extends GetxController {
  final appointments = <AppointmentModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    appointments.assignAll(MockData.appointments);
  }

  List<AppointmentModel> get pendingAppointments =>
      appointments.where((a) => a.status == 'pending').toList();

  List<AppointmentModel> get confirmedAppointments =>
      appointments.where((a) => a.status == 'confirmed').toList();

  List<AppointmentModel> get completedAppointments =>
      appointments.where((a) => a.status == 'completed').toList();

  List<AppointmentModel> get todayAppointments {
    final today = DateTime.now();
    return appointments.where((a) =>
      a.date.day == today.day &&
      a.date.month == today.month &&
      a.date.year == today.year &&
      (a.status == 'confirmed' || a.status == 'pending')
    ).toList();
  }

  AppointmentModel? getAppointmentById(String id) {
    try {
      return appointments.firstWhere((a) => a.id == id);
    } catch (_) {
      return null;
    }
  }

  void acceptAppointment(String id) {
    _updateStatus(id, 'confirmed');
  }

  void rejectAppointment(String id) {
    _updateStatus(id, 'cancelled');
  }

  void completeAppointment(String id) {
    _updateStatus(id, 'completed');
  }

  void _updateStatus(String id, String status) {
    final index = appointments.indexWhere((a) => a.id == id);
    if (index != -1) {
      final apt = appointments[index];
      appointments[index] = AppointmentModel(
        id: apt.id,
        patient: apt.patient,
        date: apt.date,
        time: apt.time,
        type: apt.type,
        status: status,
        amount: apt.amount,
      );
      appointments.refresh();
    }
  }
}
