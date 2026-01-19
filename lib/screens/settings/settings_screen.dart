import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../config/theme.dart';
import '../../config/providers.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<LocaleProvider>();
    final theme = context.watch<ThemeProvider>();
    final auth = context.watch<AuthProvider>();
    final doctor = auth.doctor;

    return Scaffold(
      appBar: AppBar(title: Text(locale.get('settings'))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profile Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: AppColors.primaryLight,
                    child: Text(doctor?.name[0] ?? 'د',
                        style: const TextStyle(
                            fontSize: 24, color: AppColors.primary)),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(doctor?.name ?? '',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        Text(doctor?.specialtyAr ?? '',
                            style: const TextStyle(
                                color: AppColors.textSecondary)),
                      ],
                    ),
                  ),
                  IconButton(
                      icon: const Icon(Icons.edit, color: AppColors.primary),
                      onPressed: () => context.push('/profile')),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Account Section
          _SectionTitle(title: locale.get('account')),
          _MenuItem(
              icon: Icons.person,
              title: locale.get('profile'),
              onTap: () => context.push('/profile')),
          _MenuItem(
              icon: Icons.location_on,
              title: locale.get('manageBranches'),
              onTap: () => context.push('/branches')),
          _MenuItem(
              icon: Icons.attach_money,
              title: locale.get('earnings'),
              onTap: () => _showEarningsSheet(context, locale)),
          _MenuItem(
              icon: Icons.notifications,
              title: locale.get('notifications'),
              onTap: () {}),

          const SizedBox(height: 16),
          _SectionTitle(title: locale.get('settings')),
          _MenuItem(
            icon: theme.isDark ? Icons.light_mode : Icons.dark_mode,
            title:
                theme.isDark ? locale.get('lightMode') : locale.get('darkMode'),
            onTap: () => theme.toggleTheme(),
          ),
          _MenuItem(
            icon: Icons.language,
            title: locale.get('language'),
            subtitle: locale.isArabic ? 'العربية' : 'English',
            onTap: () => _showLanguageDialog(context, locale),
          ),

          const SizedBox(height: 16),
          _SectionTitle(title: locale.get('support')),
          _MenuItem(
              icon: Icons.help,
              title: locale.get('help'),
              onTap: () => _showHelpSheet(context, locale)),
          _MenuItem(
              icon: Icons.privacy_tip,
              title: locale.get('privacy'),
              onTap: () {}),
          _MenuItem(
              icon: Icons.description,
              title: locale.get('terms'),
              onTap: () {}),
          _MenuItem(
              icon: Icons.info,
              title: locale.get('about'),
              onTap: () => _showAboutDialog(context, locale)),

          const SizedBox(height: 16),
          _MenuItem(
            icon: Icons.logout,
            title: locale.get('logout'),
            color: AppColors.error,
            onTap: () => _showLogoutDialog(context, locale),
          ),

          const SizedBox(height: 24),
          Center(
              child: Text('${locale.get('version')} 1.0.0',
                  style: const TextStyle(
                      color: AppColors.textSecondary, fontSize: 12))),
        ],
      ),
    );
  }

  void _showLanguageDialog(BuildContext context, LocaleProvider locale) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(locale.get('language')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Text('🇪🇬', style: TextStyle(fontSize: 24)),
              title: const Text('العربية'),
              trailing: locale.isArabic
                  ? const Icon(Icons.check, color: AppColors.primary)
                  : null,
              onTap: () {
                locale.setArabic();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Text('🇺🇸', style: TextStyle(fontSize: 24)),
              title: const Text('English'),
              trailing: !locale.isArabic
                  ? const Icon(Icons.check, color: AppColors.primary)
                  : null,
              onTap: () {
                locale.setEnglish();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showEarningsSheet(BuildContext context, LocaleProvider locale) {
    final earnings = context.read<EarningsProvider>();
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(locale.get('earnings'),
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _EarningCard(
                    title: locale.get('monthlyEarnings'),
                    value: '${earnings.monthlyEarnings.toInt()} جنيه',
                    color: AppColors.success,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _EarningCard(
                    title: 'إجمالي الأرباح',
                    value: '${earnings.totalEarnings.toInt()} جنيه',
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _EarningCard(
              title: 'مدفوعات معلقة',
              value: '${earnings.pendingPayments.toInt()} جنيه',
              color: AppColors.warning,
            ),
          ],
        ),
      ),
    );
  }

  void _showHelpSheet(BuildContext context, LocaleProvider locale) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.support_agent, size: 64, color: AppColors.primary),
            const SizedBox(height: 16),
            Text(locale.get('help'),
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.email, color: AppColors.primary),
              title: const Text('doctor.support@henlehen.com'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.phone, color: AppColors.primary),
              title: const Text('19998'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  void _showAboutDialog(BuildContext context, LocaleProvider locale) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(locale.get('about')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(16)),
              child: const Icon(Icons.medical_services,
                  size: 48, color: AppColors.primary),
            ),
            const SizedBox(height: 16),
            Text(locale.get('appName'),
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('تطبيق الطبيبة لمنصة هُنَّ لَهُنَّ',
                textAlign: TextAlign.center),
          ],
        ),
        actions: [
          ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text(locale.get('ok')))
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, LocaleProvider locale) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(locale.get('logout')),
        content: Text(locale.get('logoutConfirm')),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(locale.get('cancel'))),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            onPressed: () {
              context.read<AuthProvider>().logout();
              context.go('/login');
            },
            child: Text(locale.get('logout')),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(title,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Color? color;
  final VoidCallback onTap;

  const _MenuItem(
      {required this.icon,
      required this.title,
      this.subtitle,
      this.color,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: color ?? AppColors.primary),
        title: Text(title, style: TextStyle(color: color)),
        subtitle: subtitle != null
            ? Text(subtitle!, style: const TextStyle(fontSize: 12))
            : null,
        trailing:
            const Icon(Icons.chevron_left, color: AppColors.textSecondary),
        onTap: onTap,
      ),
    );
  }
}

class _EarningCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const _EarningCard(
      {required this.title, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(value,
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 4),
          Text(title,
              style: const TextStyle(
                  fontSize: 12, color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}
