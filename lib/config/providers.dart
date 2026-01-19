import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'theme.dart';
import 'locale.dart';
import '../models/models.dart';

export 'locale.dart';

class AppProviders {
  static List<SingleChildWidget> get providers => [
    ChangeNotifierProvider(create: (_) => ThemeProvider()),
    ChangeNotifierProvider(create: (_) => AuthProvider()),
    ChangeNotifierProvider(create: (_) => LocaleProvider()),
    ChangeNotifierProvider(create: (_) => AppointmentsProvider()),
    ChangeNotifierProvider(create: (_) => PatientsProvider()),
    ChangeNotifierProvider(create: (_) => BranchesProvider()),
    ChangeNotifierProvider(create: (_) => EarningsProvider()),
  ];
}

// ==================== AUTH PROVIDER ====================
class AuthProvider extends ChangeNotifier {
  DoctorModel? _doctor;
  bool _isLoading = false;
  bool _isLoggedIn = false;
  bool _isPending = false;

  DoctorModel? get doctor => _doctor;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _isLoggedIn;
  bool get isPending => _isPending;

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    
    if (email.isEmpty || password.length < 6) {
      _isLoading = false;
      notifyListeners();
      return false;
    }

    _doctor = MockData.currentDoctor;
    _isLoggedIn = true;
    _isLoading = false;
    notifyListeners();
    return true;
  }

  Future<bool> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String specialty,
    required String licenseNumber,
    required int experience,
    required String bio,
  }) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));

    _doctor = DoctorModel(
      id: 'doctor_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      email: email,
      phone: phone,
      specialty: specialty,
      specialtyAr: _getSpecialtyAr(specialty),
      licenseNumber: licenseNumber,
      experienceYears: experience,
      bio: bio,
      rating: 0,
      reviewsCount: 0,
      patientsCount: 0,
      consultationFee: 200,
      isVerified: false,
    );
    _isPending = true;
    _isLoading = false;
    notifyListeners();
    return true;
  }

  String _getSpecialtyAr(String specialty) {
    switch (specialty) {
      case 'gynecology': return 'نساء وتوليد';
      case 'dermatology': return 'جلدية وتجميل';
      case 'psychology': return 'نفسية';
      default: return specialty;
    }
  }

  void updateProfile({String? name, String? phone, String? bio, double? fee}) {
    if (_doctor != null) {
      _doctor = DoctorModel(
        id: _doctor!.id,
        name: name ?? _doctor!.name,
        email: _doctor!.email,
        phone: phone ?? _doctor!.phone,
        specialty: _doctor!.specialty,
        specialtyAr: _doctor!.specialtyAr,
        licenseNumber: _doctor!.licenseNumber,
        experienceYears: _doctor!.experienceYears,
        bio: bio ?? _doctor!.bio,
        rating: _doctor!.rating,
        reviewsCount: _doctor!.reviewsCount,
        patientsCount: _doctor!.patientsCount,
        consultationFee: fee ?? _doctor!.consultationFee,
        isVerified: _doctor!.isVerified,
      );
      notifyListeners();
    }
  }

  void logout() {
    _doctor = null;
    _isLoggedIn = false;
    _isPending = false;
    notifyListeners();
  }
}

// ==================== APPOINTMENTS PROVIDER ====================
class AppointmentsProvider extends ChangeNotifier {
  final List<AppointmentModel> _appointments = List.from(MockData.appointments);

  List<AppointmentModel> get appointments => _appointments;
  List<AppointmentModel> get pendingAppointments => _appointments.where((a) => a.status == 'pending').toList();
  List<AppointmentModel> get confirmedAppointments => _appointments.where((a) => a.status == 'confirmed').toList();
  List<AppointmentModel> get completedAppointments => _appointments.where((a) => a.status == 'completed').toList();
  List<AppointmentModel> get todayAppointments {
    final today = DateTime.now();
    return _appointments.where((a) => 
      a.date.day == today.day && 
      a.date.month == today.month && 
      a.date.year == today.year &&
      (a.status == 'confirmed' || a.status == 'pending')
    ).toList();
  }

  AppointmentModel? getAppointmentById(String id) {
    try {
      return _appointments.firstWhere((a) => a.id == id);
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
    final index = _appointments.indexWhere((a) => a.id == id);
    if (index != -1) {
      final apt = _appointments[index];
      _appointments[index] = AppointmentModel(
        id: apt.id,
        patient: apt.patient,
        date: apt.date,
        time: apt.time,
        type: apt.type,
        status: status,
        amount: apt.amount,
      );
      notifyListeners();
    }
  }
}

// ==================== PATIENTS PROVIDER ====================
class PatientsProvider extends ChangeNotifier {
  List<PatientModel> _patients = List.from(MockData.patients);
  String _searchQuery = '';

  List<PatientModel> get patients => _filteredPatients;
  List<PatientModel> get allPatients => _patients;

  List<PatientModel> get _filteredPatients {
    if (_searchQuery.isEmpty) return _patients;
    return _patients.where((p) => p.name.contains(_searchQuery) || p.phone.contains(_searchQuery)).toList();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  PatientModel? getPatientById(String id) {
    try {
      return _patients.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }
}

// ==================== BRANCHES PROVIDER ====================
class BranchesProvider extends ChangeNotifier {
  final List<BranchModel> _branches = List.from(MockData.branches);

  List<BranchModel> get branches => _branches;

  void addBranch(BranchModel branch) {
    _branches.add(branch);
    notifyListeners();
  }

  void updateBranch(String id, BranchModel updated) {
    final index = _branches.indexWhere((b) => b.id == id);
    if (index != -1) {
      _branches[index] = updated;
      notifyListeners();
    }
  }

  void deleteBranch(String id) {
    _branches.removeWhere((b) => b.id == id);
    notifyListeners();
  }

  void toggleBranchActive(String id) {
    final index = _branches.indexWhere((b) => b.id == id);
    if (index != -1) {
      final branch = _branches[index];
      _branches[index] = BranchModel(
        id: branch.id,
        name: branch.name,
        governorate: branch.governorate,
        area: branch.area,
        address: branch.address,
        phone: branch.phone,
        consultationFee: branch.consultationFee,
        workingDays: branch.workingDays,
        startTime: branch.startTime,
        endTime: branch.endTime,
        isActive: !branch.isActive,
      );
      notifyListeners();
    }
  }
}

// ==================== EARNINGS PROVIDER ====================
class EarningsProvider extends ChangeNotifier {
  double _totalEarnings = 45000;
  double _monthlyEarnings = 12500;
  double _pendingPayments = 3200;

  double get totalEarnings => _totalEarnings;
  double get monthlyEarnings => _monthlyEarnings;
  double get pendingPayments => _pendingPayments;

  List<Map<String, dynamic>> get earningsHistory => [
    {'month': 'يناير', 'amount': 11200},
    {'month': 'فبراير', 'amount': 9800},
    {'month': 'مارس', 'amount': 12500},
    {'month': 'أبريل', 'amount': 11500},
  ];
}
