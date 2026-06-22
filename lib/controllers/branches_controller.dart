import 'package:get/get.dart';
import '../models/models.dart';

class BranchesController extends GetxController {
  final branches = <BranchModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    branches.assignAll(MockData.branches);
  }

  void addBranch(BranchModel branch) {
    branches.add(branch);
  }

  void updateBranch(String id, BranchModel updated) {
    final index = branches.indexWhere((b) => b.id == id);
    if (index != -1) {
      branches[index] = updated;
      branches.refresh();
    }
  }

  void deleteBranch(String id) {
    branches.removeWhere((b) => b.id == id);
  }

  void toggleBranchActive(String id) {
    final index = branches.indexWhere((b) => b.id == id);
    if (index != -1) {
      final branch = branches[index];
      branches[index] = BranchModel(
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
      branches.refresh();
    }
  }
}
