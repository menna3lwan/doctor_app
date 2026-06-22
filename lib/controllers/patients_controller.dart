import 'package:get/get.dart';
import '../models/models.dart';

class PatientsController extends GetxController {
  final _allPatients = <PatientModel>[].obs;
  final searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _allPatients.assignAll(MockData.patients);
  }

  List<PatientModel> get allPatients => _allPatients;

  List<PatientModel> get patients {
    if (searchQuery.value.isEmpty) return _allPatients;
    return _allPatients.where((p) =>
      p.name.contains(searchQuery.value) ||
      p.phone.contains(searchQuery.value)
    ).toList();
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
  }

  PatientModel? getPatientById(String id) {
    try {
      return _allPatients.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }
}
