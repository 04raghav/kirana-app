import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/dashboard/dashboard_screen.dart';
import 'theme/kirana_theme.dart';
import 'theme/app_colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: KiranaErpApp()));
}

class KiranaErpApp extends StatelessWidget {
  const KiranaErpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kirana Wholesale ERP',
      debugShowCheckedModeBanner: false,
      theme: kiranaTheme(),
      home: const DashboardScreen(),
    );
  }
}
