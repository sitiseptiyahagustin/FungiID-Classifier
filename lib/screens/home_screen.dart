import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fungid3/widgets/bottom_navbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> ciriJamur = [
    {
      "title": "Warna Mencolok",
      "desc": "Hindari jamur dengan warna merah, kuning, atau jingga terang.",
      "img": "assets/warna_mencolok.jpeg"
    },
    {
      "title": "Tempat Lembap",
      "desc": "Sering ditemukan di area dengan kelembapan ekstrem dan kotor.",
      "img": "assets/tempat_lembap.jpeg"
    },
    {
      "title": "Bau Menyengat",
      "desc": "Memiliki aroma busuk atau tajam seperti amonia.",
      "img": "assets/bau_menyenga.jpeg"
    },
    {
      "title": "Cincin di Batang",
      "desc": "Memiliki struktur seperti cincin atau cawan pada pangkal batang.",
      "img": "assets/licin_berlendir.jpeg"
    },
  ];

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    const Color backgroundColor = Color(0xFFF9F9F9);

    return Scaffold(
      backgroundColor: backgroundColor,
      extendBody: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 HEADER LOGO (Ganti teks dengan gambar langsung)
              Image.asset(
                'assets/logo.png', // Pastikan path logo benar
                height: 40,        // Sesuaikan tinggi logo Anda
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 16),
              Text(
                "Dengan sekali foto, Anda dapat mengenali jamur liar yang aman dan berbahaya dikonsumsi. Ayo coba sekarang!",
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 20),

              // 🔹 BANNER GAMBAR
              Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: AssetImage('assets/scanjamur.png'),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // 🔹 TITLE SECTION
              Text(
                "Ciri Jamur Beracun",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),

              // 🔹 SLIDER BOX
              Container(
                height: 320,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
                        child: PageView.builder(
                          onPageChanged: (index) => setState(() => _currentPage = index),
                          itemCount: ciriJamur.length,
                          itemBuilder: (context, index) {
                            return Image.asset(
                              ciriJamur[index]['img']!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            );
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              ciriJamur[_currentPage]['title']!,
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              ciriJamur[_currentPage]['desc']!,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: Colors.grey[600],
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                ciriJamur.length,
                                    (index) => _buildIndicator(index == _currentPage),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 0),
    );
  }

  Widget _buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: isActive ? 24 : 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.green : Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}