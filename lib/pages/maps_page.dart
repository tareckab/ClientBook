import 'package:flutter/material.dart';

class MapsPage extends StatelessWidget {
  const MapsPage({super.key});

  // TODO: Para implementar Google Maps:
  // 1) Adicione no pubspec.yaml: google_maps_flutter
  // 2) Siga as instruções de configuração do Android/iOS
  // 3) Substitua o Container abaixo por GoogleMap, centralizando em:
  //    LatLng(-28.232667, -52.381083)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mapa - UPF')),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'TODO: Adicionar GoogleMap aqui. Centro: -28.232667, -52.381083',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
