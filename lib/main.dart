import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/theme_notifier.dart';
import 'services/auth_service.dart';
import 'pages/splash_page.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/home_page.dart';
import 'pages/resource_list_page.dart';
import 'pages/resource_form_page.dart';
import 'pages/about_page.dart';
import 'pages/settings_page.dart';
import 'pages/maps_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final auth = await AuthService.init();
  runApp(MyApp(auth: auth));
}

class MyApp extends StatelessWidget {
  final AuthService auth;
  const MyApp({super.key, required this.auth});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
        Provider<AuthService>.value(value: auth),
      ],
      child: Consumer<ThemeNotifier>(
        builder: (context, theme, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'ClientBook',
            theme: ThemeData(
              colorSchemeSeed: theme.primaryColor,
              brightness: Brightness.light,
              useMaterial3: true,
            ),
            initialRoute: '/splash',
            routes: {
              '/splash': (_) => const SplashPage(),
              '/login': (_) => const LoginPage(),
              '/register': (_) => const RegisterPage(),
              '/home': (_) => const HomePage(),
              '/items': (_) => const ResourceListPage(),
              '/item_form': (_) => const UserFormPage(), // <- AQUI
              '/about': (_) => const AboutPage(),
              '/settings': (_) => const SettingsPage(),
              '/maps': (_) => const MapsPage(),
            },
          );
        },
      ),
    );
  }
}
