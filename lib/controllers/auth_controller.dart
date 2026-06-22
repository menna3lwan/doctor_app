import 'package:get/get.dart';
import '../models/models.dart';
import '../repositories/auth_repository.dart';

class AuthController extends GetxController {
  final doctor = Rxn<DoctorModel>();
  final isLoading = false.obs;
  final isLoggedIn = false.obs;
  final isPending = false.obs;

  Future<bool> login(String email, String password) async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    final authRepo = AuthRepository();
    doctor.value = await authRepo.login(email, password);

    if (doctor.value == null) {
      isLoading.value = false;
      return false;
    }

    isLoggedIn.value = true;
    isLoading.value = false;
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
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));

    doctor.value = DoctorModel(
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
    isPending.value = true;
    isLoading.value = false;
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
    if (doctor.value != null) {
      doctor.value = DoctorModel(
        id: doctor.value!.id,
        name: name ?? doctor.value!.name,
        email: doctor.value!.email,
        phone: phone ?? doctor.value!.phone,
        specialty: doctor.value!.specialty,
        specialtyAr: doctor.value!.specialtyAr,
        licenseNumber: doctor.value!.licenseNumber,
        experienceYears: doctor.value!.experienceYears,
        bio: bio ?? doctor.value!.bio,
        rating: doctor.value!.rating,
        reviewsCount: doctor.value!.reviewsCount,
        patientsCount: doctor.value!.patientsCount,
        consultationFee: fee ?? doctor.value!.consultationFee,
        isVerified: doctor.value!.isVerified,
      );
    }
  }

  void logout() {
    doctor.value = null;
    isLoggedIn.value = false;
    isPending.value = false;
  }
}
