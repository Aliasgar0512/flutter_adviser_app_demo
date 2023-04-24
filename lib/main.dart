import 'package:flutter/material.dart';
import 'package:flutter_adviser/2_application/core/services/theme_service.dart';
import 'package:flutter_adviser/2_application/pages/advise/adviser_page.dart';
import 'package:flutter_adviser/theme.dart';
import 'package:provider/provider.dart';
import 'injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeService(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(
      builder: (context, themeService, child) {
        return MaterialApp(
          themeMode:
              themeService.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          debugShowCheckedModeBanner:
              false, //* for removing the debug tag in app
          home: const AdViserPageWrapperProvider(),
        );
      },
    );
  }
}
