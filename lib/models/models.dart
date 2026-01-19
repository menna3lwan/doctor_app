// ==================== DOCTOR MODEL ====================
class DoctorModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String specialty;
  final String specialtyAr;
  final String licenseNumber;
  final int experienceYears;
  final String bio;
  final double rating;
  final int reviewsCount;
  final int patientsCount;
  final double consultationFee;
  final bool isVerified;

  DoctorModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.specialty,
    required this.specialtyAr,
    required this.licenseNumber,
    required this.experienceYears,
    required this.bio,
    required this.rating,
    required this.reviewsCount,
    required this.patientsCount,
    required this.consultationFee,
    this.isVerified = true,
  });
}

// ==================== PATIENT MODEL ====================
class PatientModel {
  final String id;
  final String name;
  final String phone;
  final String email;
  final int visitsCount;
  final DateTime lastVisit;

  PatientModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.visitsCount,
    required this.lastVisit,
  });
}

// ==================== APPOINTMENT MODEL ====================
class AppointmentModel {
  final String id;
  final PatientModel patient;
  final DateTime date;
  final String time;
  final String type;
  final String status;
  final double amount;

  AppointmentModel({
    required this.id,
    required this.patient,
    required this.date,
    required this.time,
    required this.type,
    required this.status,
    required this.amount,
  });

  String get statusAr {
    switch (status) {
      case 'pending':
        return 'في الانتظار';
      case 'confirmed':
        return 'مؤكد';
      case 'completed':
        return 'مكتمل';
      case 'cancelled':
        return 'ملغي';
      default:
        return status;
    }
  }
}

// ==================== BRANCH MODEL ====================
class BranchModel {
  final String id;
  final String name;
  final String governorate;
  final String area;
  final String address;
  final String phone;
  final double consultationFee;
  final List<String> workingDays;
  final String startTime;
  final String endTime;
  final bool isActive;

  BranchModel({
    required this.id,
    required this.name,
    required this.governorate,
    required this.area,
    required this.address,
    required this.phone,
    required this.consultationFee,
    required this.workingDays,
    required this.startTime,
    required this.endTime,
    this.isActive = true,
  });
}

// ==================== MOCK DATA ====================
class MockData {
  static DoctorModel get currentDoctor => DoctorModel(
        id: 'doctor_001',
        name: 'د. منة علوان',
        email: 'dr.sara@email.com',
        phone: '01012345678',
        specialty: 'gynecology',
        specialtyAr: 'نساء وتوليد',
        licenseNumber: 'MED-12345',
        experienceYears: 15,
        bio:
            'استشارية أمراض النساء والتوليد، خبرة 15 عام في المستشفيات الكبرى. متخصصة في متابعة الحمل والولادة وعلاج مشاكل العقم.',
        rating: 4.9,
        reviewsCount: 324,
        patientsCount: 1250,
        consultationFee: 200,
      );

  static List<PatientModel> get patients => [
        PatientModel(
            id: '1',
            name: 'منى أحمد',
            phone: '01111111111',
            email: 'mona@email.com',
            visitsCount: 5,
            lastVisit: DateTime.now().subtract(const Duration(days: 2))),
        PatientModel(
            id: '2',
            name: 'هدى محمد',
            phone: '01222222222',
            email: 'huda@email.com',
            visitsCount: 3,
            lastVisit: DateTime.now().subtract(const Duration(days: 5))),
        PatientModel(
            id: '3',
            name: 'نادية علي',
            phone: '01333333333',
            email: 'nadia@email.com',
            visitsCount: 8,
            lastVisit: DateTime.now().subtract(const Duration(days: 1))),
        PatientModel(
            id: '4',
            name: 'سلمى حسن',
            phone: '01444444444',
            email: 'salma@email.com',
            visitsCount: 2,
            lastVisit: DateTime.now().subtract(const Duration(days: 10))),
        PatientModel(
            id: '5',
            name: 'فاطمة إبراهيم',
            phone: '01555555555',
            email: 'fatma@email.com',
            visitsCount: 6,
            lastVisit: DateTime.now().subtract(const Duration(days: 3))),
      ];

  static List<AppointmentModel> get appointments => [
        AppointmentModel(
            id: '1',
            patient: patients[0],
            date: DateTime.now(),
            time: '10:00 ص',
            type: 'online',
            status: 'pending',
            amount: 200),
        AppointmentModel(
            id: '2',
            patient: patients[1],
            date: DateTime.now(),
            time: '11:00 ص',
            type: 'clinic',
            status: 'confirmed',
            amount: 250),
        AppointmentModel(
            id: '3',
            patient: patients[2],
            date: DateTime.now().add(const Duration(days: 1)),
            time: '02:00 م',
            type: 'online',
            status: 'pending',
            amount: 200),
        AppointmentModel(
            id: '4',
            patient: patients[3],
            date: DateTime.now().subtract(const Duration(days: 1)),
            time: '03:00 م',
            type: 'online',
            status: 'completed',
            amount: 200),
        AppointmentModel(
            id: '5',
            patient: patients[4],
            date: DateTime.now().subtract(const Duration(days: 2)),
            time: '04:00 م',
            type: 'clinic',
            status: 'completed',
            amount: 250),
      ];

  static List<BranchModel> get branches => [
        BranchModel(
          id: '1',
          name: 'فرع مدينة نصر',
          governorate: 'القاهرة',
          area: 'مدينة نصر',
          address: 'شارع عباس العقاد، برج الأطباء، الدور 5',
          phone: '0222222222',
          consultationFee: 250,
          workingDays: ['السبت', 'الأحد', 'الاثنين', 'الثلاثاء'],
          startTime: '10:00 ص',
          endTime: '06:00 م',
        ),
        BranchModel(
          id: '2',
          name: 'فرع المعادي',
          governorate: 'القاهرة',
          area: 'المعادي',
          address: 'شارع 9، المعادي الجديدة',
          phone: '0233333333',
          consultationFee: 300,
          workingDays: ['الأربعاء', 'الخميس'],
          startTime: '02:00 م',
          endTime: '08:00 م',
        ),
      ];
}
