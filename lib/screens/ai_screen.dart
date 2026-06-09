import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fungid3/widgets/bottom_navbar.dart';
import 'output_screen.dart'; // Sesuaikan path import Anda

class AIScanScreen extends StatefulWidget {
  const AIScanScreen({super.key});

  @override
  State<AIScanScreen> createState() => _AIScanScreenState();
}

class _AIScanScreenState extends State<AIScanScreen> {
  final ImagePicker _picker = ImagePicker();
  final Color primaryColor = const Color(0xFF4CAF50);
  final Color backgroundColor = const Color(0xFFF9F9F9);

  Future<void> _takePhoto() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OutputScreen(imagePath: image.path),
        ),
      );
    }
  }

  Future<void> _pickFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OutputScreen(imagePath: image.path),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Deteksi Jamur",
          style: GoogleFonts.poppins(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.cloud_upload_outlined, size: 100, color: Colors.green),
            const SizedBox(height: 20),
            Text(
              "Ambil atau unggah foto jamur untuk dianalisis AI.",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(color: Colors.black54, fontSize: 16),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildActionButton(
                  onPressed: _takePhoto,
                  icon: Icons.camera_alt,
                  label: "Kamera",
                  isPrimary: true,
                ),
                const SizedBox(width: 20),
                _buildActionButton(
                  onPressed: _pickFromGallery,
                  icon: Icons.photo_library,
                  label: "Galeri",
                  isPrimary: false,
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 1),
    );
  }

  Widget _buildActionButton({required VoidCallback onPressed, required IconData icon, required String label, required bool isPrimary}) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? primaryColor : Colors.white,
        foregroundColor: isPrimary ? Colors.white : primaryColor,
        side: isPrimary ? BorderSide.none : BorderSide(color: primaryColor),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label, style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
    );
  }
}