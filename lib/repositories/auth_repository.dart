import '../models/models.dart';
import '../services/api_client.dart';

class AuthRepository {
  final ApiClient _apiClient;

  AuthRepository({ApiClient? apiClient}) : _apiClient = apiClient ?? ApiClient();

  Future<DoctorModel?> login(String email, String password) async {
    // TODO: Replace with actual API call
    await Future.delayed(const Duration(seconds: 1));
    
    if (email == 'doctor@hen.com' && password == '123456') {
      return MockData.currentDoctor;
    }
    return null;
  }

  Future<DoctorModel> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String specialty,
    required String licenseNumber,
    required int experience,
    required String bio,
  }) async {
    // TODO: Replace with actual API call
    await Future.delayed(const Duration(seconds: 1));
    return DoctorModel(
      id: 'doctor_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      email: email,
      phone: phone,
      specialty: specialty,
      specialtyAr: specialty,
      licenseNumber: licenseNumber,
      experienceYears: experience,
      bio: bio,
      rating: 0,
      reviewsCount: 0,
      patientsCount: 0,
      consultationFee: 200,
      isVerified: false,
    );
  }
}
