import 'package:flutter/material.dart';

// Fungsi bantu harus ada di file yang sama
Widget textRowCustom(String label, String value, int fontSize, String fontWeight) {
  return Text(
    "$label: $value",
    style: TextStyle(
      fontSize: fontSize.toDouble(),
      fontWeight: fontWeight == "bold" ? FontWeight.bold : FontWeight.normal,
    ),
  );
}

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Mahasiswa"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.all(20),
              width: 300,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.1),
                    blurRadius: 5,
                    spreadRadius: 2,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  ClipOval(
                    child: Image.network(
                    'assets/img/423511255_0.jpg',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 24),
                  textRowCustom("Nama", "Jaki", 18, "bold"),
                  const SizedBox(height: 8),
                  textRowCustom("NIM", "2341760018", 16, "normal"),
                  const SizedBox(height: 8),
                  textRowCustom("Jurusan", "Teknologi Informasi", 16, "normal"),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.email),
                        onPressed: () {},
                      ),
                      const SizedBox(width: 16),
                      IconButton(
                        icon: const Icon(Icons.phone),
                        onPressed: () {},
                      ),
                      const SizedBox(width: 16),
                      IconButton(
                        icon: const Icon(Icons.location_on),
                        onPressed: () {},
                      ),
                    ],
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}