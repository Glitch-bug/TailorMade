import 'package:flutter/material.dart';
import 'package:tailor_made/core/theme/theme.dart';
import 'package:tailor_made/features/client/presentation/pages/clients_list_page.dart'; 
import 'package:tailor_made/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode,
      home: const ClientsListPage(),
    );
  }
}