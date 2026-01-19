import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/theme.dart';
import '../../config/providers.dart';
import '../../widgets/widgets.dart';

class PatientsScreen extends StatelessWidget {
  const PatientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<LocaleProvider>();
    final provider = context.watch<PatientsProvider>();
    final patients = provider.patients;

    return Scaffold(
      appBar: AppBar(title: Text(locale.get('patients'))),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: locale.get('searchPatient'),
                prefixIcon: const Icon(Icons.search),
              ),
              onChanged: (v) => provider.setSearchQuery(v),
            ),
          ),
          Expanded(
            child: patients.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.people_outline, size: 64, color: AppColors.divider),
                        const SizedBox(height: 16),
                        Text(locale.get('noPatients'), style: const TextStyle(color: AppColors.textSecondary)),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: patients.length,
                    itemBuilder: (context, index) {
                      final patient = patients[index];
                      return PatientCard(
                        name: patient.name,
                        phone: patient.phone,
                        visits: patient.visitsCount,
                        lastVisit: patient.lastVisit,
                        onTap: () => _showPatientDetails(context, patient, locale),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _showPatientDetails(BuildContext context, dynamic patient, LocaleProvider locale) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(radius: 40, backgroundColor: AppColors.primaryLight, child: Text(patient.name[0], style: const TextStyle(fontSize: 32, color: AppColors.primary))),
            const SizedBox(height: 16),
            Text(patient.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(patient.phone, style: const TextStyle(color: AppColors.textSecondary)),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(children: [
                  Text('${patient.visitsCount}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primary)),
                  Text(locale.get('visits'), style: const TextStyle(color: AppColors.textSecondary)),
                ]),
                Column(children: [
                  Text('${patient.lastVisit.day}/${patient.lastVisit.month}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primary)),
                  Text(locale.get('lastVisit'), style: const TextStyle(color: AppColors.textSecondary)),
                ]),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(child: OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.history), label: Text(locale.get('medicalHistory')))),
                const SizedBox(width: 12),
                Expanded(child: ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.chat), label: Text(locale.get('message')))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
