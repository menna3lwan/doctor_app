import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../config/theme.dart';
import '../../config/providers.dart';
import '../../models/models.dart';
import '../../widgets/widgets.dart';

class AddBranchScreen extends StatefulWidget {
  const AddBranchScreen({super.key});

  @override
  State<AddBranchScreen> createState() => _AddBranchScreenState();
}

class _AddBranchScreenState extends State<AddBranchScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _areaController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _feeController = TextEditingController(text: '200');
  
  String _governorate = 'القاهرة';
  String _startTime = '10:00 ص';
  String _endTime = '06:00 م';
  List<String> _selectedDays = ['السبت', 'الأحد', 'الاثنين'];

  final _governorates = ['القاهرة', 'الجيزة', 'الإسكندرية', 'المنصورة', 'طنطا', 'أسيوط'];
  final _times = ['08:00 ص', '09:00 ص', '10:00 ص', '11:00 ص', '12:00 م', '01:00 م', '02:00 م', '03:00 م', '04:00 م', '05:00 م', '06:00 م', '07:00 م', '08:00 م', '09:00 م', '10:00 م'];
  final _days = ['السبت', 'الأحد', 'الاثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة'];

  void _saveBranch() {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedDays.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('اختاري يوم عمل واحد على الأقل'), backgroundColor: AppColors.error));
      return;
    }

    final branch = BranchModel(
      id: 'branch_${DateTime.now().millisecondsSinceEpoch}',
      name: _nameController.text,
      governorate: _governorate,
      area: _areaController.text,
      address: _addressController.text,
      phone: _phoneController.text,
      consultationFee: double.parse(_feeController.text),
      workingDays: _selectedDays,
      startTime: _startTime,
      endTime: _endTime,
    );

    context.read<BranchesProvider>().addBranch(branch);
    final locale = context.read<LocaleProvider>();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(locale.get('branchAdded')), backgroundColor: AppColors.success));
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<LocaleProvider>();

    return Scaffold(
      appBar: AppBar(title: Text(locale.get('addBranch'))),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            AppTextField(
              controller: _nameController,
              label: locale.get('branchName'),
              prefixIcon: const Icon(Icons.business),
              validator: (v) => v?.isEmpty ?? true ? locale.get('error') : null,
            ),
            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              value: _governorate,
              decoration: InputDecoration(labelText: locale.get('governorate'), prefixIcon: const Icon(Icons.map)),
              items: _governorates.map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
              onChanged: (v) => setState(() => _governorate = v!),
            ),
            const SizedBox(height: 16),

            AppTextField(
              controller: _areaController,
              label: locale.get('area'),
              prefixIcon: const Icon(Icons.location_city),
              validator: (v) => v?.isEmpty ?? true ? locale.get('error') : null,
            ),
            const SizedBox(height: 16),

            AppTextField(
              controller: _addressController,
              label: locale.get('address'),
              prefixIcon: const Icon(Icons.location_on),
              maxLines: 2,
              validator: (v) => v?.isEmpty ?? true ? locale.get('error') : null,
            ),
            const SizedBox(height: 16),

            AppTextField(
              controller: _phoneController,
              label: locale.get('phone'),
              prefixIcon: const Icon(Icons.phone),
              keyboardType: TextInputType.phone,
              validator: (v) => (v?.length ?? 0) < 8 ? locale.get('error') : null,
            ),
            const SizedBox(height: 16),

            AppTextField(
              controller: _feeController,
              label: locale.get('consultationFee'),
              prefixIcon: const Icon(Icons.attach_money),
              keyboardType: TextInputType.number,
              validator: (v) => v?.isEmpty ?? true ? locale.get('error') : null,
            ),
            const SizedBox(height: 24),

            // Working Days
            Text(locale.get('workingDays'), style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _days.map((day) {
                final isSelected = _selectedDays.contains(day);
                return FilterChip(
                  label: Text(day),
                  selected: isSelected,
                  selectedColor: AppColors.primaryLight,
                  checkmarkColor: AppColors.primary,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedDays.add(day);
                      } else {
                        _selectedDays.remove(day);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Working Hours
            Text(locale.get('workingHours'), style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _startTime,
                    decoration: InputDecoration(labelText: locale.get('from')),
                    items: _times.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                    onChanged: (v) => setState(() => _startTime = v!),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _endTime,
                    decoration: InputDecoration(labelText: locale.get('to')),
                    items: _times.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                    onChanged: (v) => setState(() => _endTime = v!),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            AppButton(text: locale.get('saveBranch'), onPressed: _saveBranch),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _areaController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _feeController.dispose();
    super.dispose();
  }
}
