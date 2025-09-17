import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sobre')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Desenvolvedores:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('• Nomes: Tareck Barghouthi, Júlia Laitharth'),
            Text('• Matrículas: 203276, 203751'),
            Text('• Curso: ADS - UPF'),
          ],
        ),
      ),
    );
  }
}
