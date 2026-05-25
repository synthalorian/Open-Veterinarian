import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'services/database_service.dart';
import 'features/dashboard/main_dashboard.dart';
import 'providers/theme_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseService.init();

  runApp(
    const ProviderScope(
      child: OpenVeterinarianApp(),
    ),
  );
}

class OpenVeterinarianApp extends ConsumerWidget {
  const OpenVeterinarianApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeDataProvider);

    return MaterialApp(
      title: 'Open Veterinarian',
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: const MainDashboard(),
    );
  }
}
