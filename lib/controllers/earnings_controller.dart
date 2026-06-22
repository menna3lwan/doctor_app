import 'package:get/get.dart';

class EarningsController extends GetxController {
  final double totalEarnings = 45000;
  final double monthlyEarnings = 12500;
  final double pendingPayments = 3200;

  List<Map<String, dynamic>> get earningsHistory => [
    {'month': 'يناير', 'amount': 11200},
    {'month': 'فبراير', 'amount': 9800},
    {'month': 'مارس', 'amount': 12500},
    {'month': 'أبريل', 'amount': 11500},
  ];
}
