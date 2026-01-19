import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../config/theme.dart';
import '../../config/providers.dart';

class BranchesScreen extends StatelessWidget {
  const BranchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<LocaleProvider>();
    final provider = context.watch<BranchesProvider>();
    final branches = provider.branches;

    return Scaffold(
      appBar: AppBar(title: Text(locale.get('branches'))),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/add-branch'),
        icon: const Icon(Icons.add),
        label: Text(locale.get('addBranch')),
      ),
      body: branches.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.location_off, size: 64, color: AppColors.divider),
                  const SizedBox(height: 16),
                  Text(locale.get('noBranches'), style: const TextStyle(color: AppColors.textSecondary)),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () => context.push('/add-branch'),
                    icon: const Icon(Icons.add),
                    label: Text(locale.get('addBranch')),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: branches.length,
              itemBuilder: (context, index) {
                final branch = branches[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: branch.isActive ? AppColors.success.withOpacity(0.1) : AppColors.divider,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(Icons.location_on, color: branch.isActive ? AppColors.success : AppColors.textSecondary),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(branch.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                  Text('${branch.governorate} - ${branch.area}', style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                                ],
                              ),
                            ),
                            Switch(
                              value: branch.isActive,
                              activeColor: AppColors.success,
                              onChanged: (v) => provider.toggleBranchActive(branch.id),
                            ),
                          ],
                        ),
                        const Divider(height: 24),
                        Row(
                          children: [
                            _InfoChip(icon: Icons.attach_money, label: '${branch.consultationFee.toInt()} جنيه'),
                            const SizedBox(width: 8),
                            _InfoChip(icon: Icons.access_time, label: '${branch.startTime} - ${branch.endTime}'),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 4,
                          children: branch.workingDays.map((day) => Chip(
                            label: Text(day, style: const TextStyle(fontSize: 10)),
                            padding: EdgeInsets.zero,
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          )).toList(),
                        ),
                        const Divider(height: 24),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () => _showDeleteDialog(context, branch.id, locale, provider),
                                style: OutlinedButton.styleFrom(foregroundColor: AppColors.error),
                                icon: const Icon(Icons.delete, size: 18),
                                label: Text(locale.get('delete')),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.edit, size: 18),
                                label: Text(locale.get('edit')),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  void _showDeleteDialog(BuildContext context, String id, LocaleProvider locale, BranchesProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(locale.get('delete')),
        content: const Text('هل أنت متأكدة من حذف هذا الفرع؟'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(locale.get('cancel'))),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            onPressed: () {
              provider.deleteBranch(id);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(locale.get('success')), backgroundColor: AppColors.success));
            },
            child: Text(locale.get('delete')),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: AppColors.primaryLight.withOpacity(0.3), borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.primary),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(fontSize: 12, color: AppColors.primary)),
        ],
      ),
    );
  }
}
