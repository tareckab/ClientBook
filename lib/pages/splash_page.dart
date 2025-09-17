import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    await Future.delayed(const Duration(milliseconds: 800));
    final auth = await AuthService.init();
    if (!mounted) return;
    if (auth.isLogged) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/splash.png', width: 120, height: 120, fit: BoxFit.contain, errorBuilder: (_, __, ___) {
              return const FlutterLogo(size: 96);
            }),
            const SizedBox(height: 16),
            const Text('Carregando ... ', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
