import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

// Fungsi main() asinkron untuk mengizinkan pengambilan kamera
Future<void> main() async {
  // Pastikan binding Flutter telah diinisialisasi
  // Ini penting untuk memanggil platform code sebelum runApp()
  WidgetsFlutterBinding.ensureInitialized();

  // Dapatkan daftar kamera yang tersedia di perangkat
  final cameras = await availableCameras();

  // Dapatkan kamera pertama dari daftar (biasanya kamera belakang)
  final firstCamera = cameras.first;

  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: CameraApp(
        // Teruskan kamera yang dipilih ke widget CameraApp
        camera: firstCamera,
      ),
    ),
  );
}

// Widget StatefulWidget untuk menampilkan preview kamera
class CameraApp extends StatefulWidget {
  final CameraDescription camera;

  const CameraApp({
    super.key,
    required this.camera,
  });

  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    
    // Buat CameraController
    _controller = CameraController(
      // Dapatkan kamera spesifik dari widget.camera
      widget.camera,
      // Tentukan resolusi (medium sudah cukup untuk preview)
      ResolutionPreset.medium,
    );

    // Inisialisasi controller dan simpan Future-nya untuk digunakan
    // oleh FutureBuilder
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Pastikan untuk dispose controller saat widget di-dispose
    // untuk melepaskan resource kamera.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contoh Preview Kamera')),
      // Gunakan FutureBuilder untuk menampilkan loading indicator
      // saat controller sedang diinisialisasi.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // Jika Future selesai (controller sudah terinisialisasi),
            // tampilkan preview kamera.
            // Gunakan AspectRatio agar preview tidak terdistorsi
            // sesuai rasio aspek kamera.
            return AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: CameraPreview(_controller));
          } else {
            // Jika masih loading, tampilkan CircularProgressIndicator
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}