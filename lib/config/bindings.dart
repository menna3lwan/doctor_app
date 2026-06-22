import 'package:get/get.dart';
import 'package:shared_ui/shared_ui.dart';
import '../controllers/auth_controller.dart';
import '../controllers/appointments_controller.dart';
import '../controllers/patients_controller.dart';
import '../controllers/branches_controller.dart';
import '../controllers/earnings_controller.dart';
import 'locale.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController(), permanent: true);
    Get.put(LocaleController(), permanent: true);
    Get.put(AuthController(), permanent: true);
    Get.put(AppointmentsController(), permanent: true);
    Get.put(PatientsController(), permanent: true);
    Get.put(BranchesController(), permanent: true);
    Get.put(EarningsController(), permanent: true);
  }
}
