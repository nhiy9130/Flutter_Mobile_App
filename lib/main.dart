import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';
import 'core/config/app_config.dart';
import 'features/notifications/local_notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize EasyLocalization
  await EasyLocalization.ensureInitialized();

  // Initialize Hive for local storage
  await Hive.initFlutter();

  // Initialize Local Notifications
  final notificationService = LocalNotificationService();
  await notificationService.initialize();
  await notificationService.requestPermission();

  const apiBaseUrl = String.fromEnvironment('API_BASE_URL', defaultValue: 'http://localhost:3000/api');
  const socketUrl = String.fromEnvironment('SOCKET_URL', defaultValue: 'http://localhost:3003');
  const demo = bool.fromEnvironment('DEMO_MODE', defaultValue: true);

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('vi')],
      path: 'assets/i18n',
      fallbackLocale: const Locale('vi'),
      startLocale: const Locale('vi'),
      child: ProviderScope(
        child: AppConfig(
          apiBaseUrl: apiBaseUrl,
          socketUrl: socketUrl,
          demoMode: demo,
          child: const LMSApp(),
        ),
      ),
    ),
  );
}
