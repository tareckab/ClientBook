import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  // Coordenadas da UPF (Campus Passo Fundo)
  static const LatLng _upf = LatLng(-28.23246017567184, -52.38030751921312);

  static const CameraPosition _kUPF = CameraPosition(
    target: _upf,
    zoom: 16.0,
  );

  static const CameraPosition _kUPFCloser = CameraPosition(
    target: _upf,
    tilt: 50.0,
    bearing: 30.0,
    zoom: 18.0,
  );

  //  Coleção de marcadores sem 'const'
  final Set<Marker> _markers = {
    Marker(
      markerId: const MarkerId('upf'),
      position: _upf,
      infoWindow: const InfoWindow(
        title: 'UPF - Universidade de Passo',
        snippet: 'Campus Passo Fundo',
      ),
    ),
  };


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Maps')),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kUPF,
        markers: _markers, 
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        
        // ponteiro (pontinho de localizacao)
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled:false
      ),
      
    );
  }

  Future<void> _goCloser() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(_kUPFCloser),
    );
  }
}
