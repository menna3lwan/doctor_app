import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  bool _isArabic = true;

  bool get isArabic => _isArabic;
  Locale get locale => _isArabic ? const Locale('ar') : const Locale('en');

  void setArabic() {
    _isArabic = true;
    notifyListeners();
  }

  void setEnglish() {
    _isArabic = false;
    notifyListeners();
  }

  void toggleLocale() {
    _isArabic = !_isArabic;
    notifyListeners();
  }

  String get(String key) {
    return _isArabic ? _ar[key] ?? key : _en[key] ?? key;
  }

  static const Map<String, String> _ar = {
    // General
    'appName': 'هُنَّ لَهُنَّ - الدكتورة',
    'ok': 'حسناً',
    'cancel': 'إلغاء',
    'save': 'حفظ',
    'delete': 'حذف',
    'edit': 'تعديل',
    'add': 'إضافة',
    'search': 'بحث',
    'loading': 'جاري التحميل...',
    'error': 'حدث خطأ',
    'success': 'تم بنجاح',
    'noResults': 'لا توجد نتائج',
    'version': 'الإصدار',

    // Auth
    'login': 'تسجيل الدخول',
    'register': 'إنشاء حساب',
    'logout': 'تسجيل الخروج',
    'logoutConfirm': 'هل أنت متأكدة من تسجيل الخروج؟',
    'email': 'البريد الإلكتروني',
    'password': 'كلمة المرور',
    'name': 'الاسم',
    'phone': 'رقم الهاتف',
    'specialty': 'التخصص',
    'licenseNumber': 'رقم الترخيص',
    'experience': 'سنوات الخبرة',
    'bio': 'نبذة عنك',
    'dontHaveAccount': 'ليس لديك حساب؟',
    'alreadyHaveAccount': 'لديك حساب بالفعل؟',
    'registerNow': 'سجلي الآن',
    'loginNow': 'سجلي دخول',
    'pendingApproval': 'في انتظار الموافقة',
    'pendingMessage': 'تم إرسال طلبك وجاري مراجعته من قبل الإدارة. سيتم إخطارك عند الموافقة.',

    // Dashboard
    'dashboard': 'لوحة التحكم',
    'todayAppointments': 'مواعيد اليوم',
    'totalPatients': 'إجمالي المريضات',
    'rating': 'التقييم',
    'monthlyEarnings': 'أرباح الشهر',
    'quickActions': 'إجراءات سريعة',
    'viewAll': 'عرض الكل',

    // Appointments
    'appointments': 'المواعيد',
    'pending': 'في الانتظار',
    'confirmed': 'مؤكدة',
    'completed': 'مكتملة',
    'cancelled': 'ملغية',
    'noPending': 'لا توجد مواعيد في الانتظار',
    'noConfirmed': 'لا توجد مواعيد مؤكدة',
    'noCompleted': 'لا توجد مواعيد مكتملة',
    'accept': 'قبول',
    'reject': 'رفض',
    'startConsultation': 'بدء الاستشارة',
    'endConsultation': 'إنهاء الاستشارة',
    'acceptConfirm': 'هل أنت متأكدة من قبول هذا الموعد؟',
    'rejectConfirm': 'هل أنت متأكدة من رفض هذا الموعد؟',
    'online': 'أونلاين',
    'clinic': 'عيادة',

    // Patients
    'patients': 'المريضات',
    'searchPatient': 'ابحثي عن مريضة...',
    'noPatients': 'لا توجد مريضات',
    'visits': 'زيارات',
    'lastVisit': 'آخر زيارة',
    'medicalHistory': 'السجل الطبي',
    'message': 'مراسلة',

    // Chat
    'typeMessage': 'اكتبي رسالتك...',
    'endSession': 'إنهاء الجلسة',
    'sessionActive': 'الاستشارة جارية',
    'patientTyping': 'المريضة تكتب...',

    // Branches
    'branches': 'الفروع',
    'addBranch': 'إضافة فرع',
    'branchName': 'اسم الفرع',
    'governorate': 'المحافظة',
    'area': 'المنطقة',
    'address': 'العنوان التفصيلي',
    'consultationFee': 'سعر الكشف',
    'workingDays': 'أيام العمل',
    'workingHours': 'مواعيد العمل',
    'from': 'من',
    'to': 'إلى',
    'noBranches': 'لا توجد فروع',
    'saveBranch': 'حفظ الفرع',
    'branchAdded': 'تم إضافة الفرع بنجاح',

    // Settings
    'settings': 'الإعدادات',
    'account': 'الحساب',
    'profile': 'الملف الشخصي',
    'manageBranches': 'إدارة الفروع',
    'earnings': 'الأرباح والتقارير',
    'notifications': 'الإشعارات',
    'darkMode': 'الوضع الداكن',
    'lightMode': 'الوضع الفاتح',
    'language': 'اللغة',
    'support': 'الدعم',
    'help': 'المساعدة والدعم',
    'privacy': 'سياسة الخصوصية',
    'terms': 'الشروط والأحكام',
    'about': 'عن التطبيق',
  };

  static const Map<String, String> _en = {
    // General
    'appName': 'Hen Lehen - Doctor',
    'ok': 'OK',
    'cancel': 'Cancel',
    'save': 'Save',
    'delete': 'Delete',
    'edit': 'Edit',
    'add': 'Add',
    'search': 'Search',
    'loading': 'Loading...',
    'error': 'An error occurred',
    'success': 'Success',
    'noResults': 'No results found',
    'version': 'Version',

    // Auth
    'login': 'Login',
    'register': 'Register',
    'logout': 'Logout',
    'logoutConfirm': 'Are you sure you want to logout?',
    'email': 'Email',
    'password': 'Password',
    'name': 'Name',
    'phone': 'Phone Number',
    'specialty': 'Specialty',
    'licenseNumber': 'License Number',
    'experience': 'Years of Experience',
    'bio': 'About You',
    'dontHaveAccount': "Don't have an account?",
    'alreadyHaveAccount': 'Already have an account?',
    'registerNow': 'Register Now',
    'loginNow': 'Login Now',
    'pendingApproval': 'Pending Approval',
    'pendingMessage': 'Your application has been submitted and is under review. You will be notified upon approval.',

    // Dashboard
    'dashboard': 'Dashboard',
    'todayAppointments': "Today's Appointments",
    'totalPatients': 'Total Patients',
    'rating': 'Rating',
    'monthlyEarnings': 'Monthly Earnings',
    'quickActions': 'Quick Actions',
    'viewAll': 'View All',

    // Appointments
    'appointments': 'Appointments',
    'pending': 'Pending',
    'confirmed': 'Confirmed',
    'completed': 'Completed',
    'cancelled': 'Cancelled',
    'noPending': 'No pending appointments',
    'noConfirmed': 'No confirmed appointments',
    'noCompleted': 'No completed appointments',
    'accept': 'Accept',
    'reject': 'Reject',
    'startConsultation': 'Start Consultation',
    'endConsultation': 'End Consultation',
    'acceptConfirm': 'Are you sure you want to accept this appointment?',
    'rejectConfirm': 'Are you sure you want to reject this appointment?',
    'online': 'Online',
    'clinic': 'Clinic',

    // Patients
    'patients': 'Patients',
    'searchPatient': 'Search for a patient...',
    'noPatients': 'No patients found',
    'visits': 'Visits',
    'lastVisit': 'Last Visit',
    'medicalHistory': 'Medical History',
    'message': 'Message',

    // Chat
    'typeMessage': 'Type your message...',
    'endSession': 'End Session',
    'sessionActive': 'Session Active',
    'patientTyping': 'Patient is typing...',

    // Branches
    'branches': 'Branches',
    'addBranch': 'Add Branch',
    'branchName': 'Branch Name',
    'governorate': 'Governorate',
    'area': 'Area',
    'address': 'Detailed Address',
    'consultationFee': 'Consultation Fee',
    'workingDays': 'Working Days',
    'workingHours': 'Working Hours',
    'from': 'From',
    'to': 'To',
    'noBranches': 'No branches found',
    'saveBranch': 'Save Branch',
    'branchAdded': 'Branch added successfully',

    // Settings
    'settings': 'Settings',
    'account': 'Account',
    'profile': 'Profile',
    'manageBranches': 'Manage Branches',
    'earnings': 'Earnings & Reports',
    'notifications': 'Notifications',
    'darkMode': 'Dark Mode',
    'lightMode': 'Light Mode',
    'language': 'Language',
    'support': 'Support',
    'help': 'Help & Support',
    'privacy': 'Privacy Policy',
    'terms': 'Terms & Conditions',
    'about': 'About App',
  };
}
