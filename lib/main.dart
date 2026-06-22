import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:shared_ui/shared_ui.dart';
import 'config/locale.dart';
import 'config/theme.dart' as doctor_theme;
import 'config/bindings.dart';
import 'config/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    debugPrint('Global Error Caught: ${details.exception}');
  };

  runApp(const HenLehenDoctorApp());
}

class HenLehenDoctorApp extends StatelessWidget {
  const HenLehenDoctorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'هُنَّ لَهُنَّ - الدكتورة',
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBinding(),
      theme: doctor_theme.AppTheme.lightTheme,
      darkTheme: doctor_theme.AppTheme.darkTheme,
      getPages: AppRoutes.pages,
      initialRoute: AppRoutes.login,
      supportedLocales: const [Locale('ar'), Locale('en')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: (context, child) {
        final themeCtrl = Get.find<ThemeController>();
        final localeCtrl = Get.find<LocaleController>();
        return Obx(() {
          final _ = themeCtrl.themeMode.value;
          final __ = localeCtrl.isArabic.value;
          return Directionality(
            textDirection: localeCtrl.textDirection,
            child: Theme(
              data: themeCtrl.isDark
                  ? doctor_theme.AppTheme.darkTheme
                  : doctor_theme.AppTheme.lightTheme,
              child: child!,
            ),
          );
        });
      },
    );
  }
}
