import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/bottom_navbar.dart'; // Pastikan path ini sesuai dengan project Anda

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  final Color primaryColor = const Color(0xFF2E7D32);
  final Color accentPoison = const Color(0xFFE53935);
  final Color accentSafe = const Color(0xFF43A047);

  // Data Jamur dengan tambahan list images untuk slider
  final List<Map<String, dynamic>> mushrooms = [
    {
      'name': 'Fly Agaric (Amanita Muscaria)',
      'latin': 'Jamur Lalat',
      'status': 'Beracun ⚠️',
      'images': [
        'assets/1.jpg',
        'assets/2.jpeg',
        'assets/3.jpg',
        'assets/4.jpeg',// Ganti dengan variasi gambar jika ada
      ],
      'desc': 'Dikenal sebagai “Fly Agaric”, jamur ini memiliki warna merah cerah dengan bintik putih. Mengandung zat beracun muscimol dan ibotenic acid yang menyebabkan halusinasi dan gangguan saraf.',
    },
    {
      'name': 'Amanita Pantherina',
      'latin': 'Panther Cap',
      'status': 'Beracun ⚠️',
      'images': [
        'assets/5.jpeg',
        'assets/6.jpeg',
        'assets/7.jpg',
        'assets/8.jpg',
      ],
      'desc': 'Jamur beracun berwarna coklat dengan bintik putih, mengandung toksin yang mempengaruhi sistem saraf pusat secara signifikan.',
    },
    {
      'name': 'Auricularia Auricula',
      'latin': 'Jamur Kuping',
      'status': 'Aman Dikonsumsi ✅',
      'images': [
        'assets/9.jpeg',
        'assets/10.jpeg',
        'assets/11.jpg',
        'assets/12.jpg',
      ],
      'desc': 'Sering disebut “jamur kuping”, aman dikonsumsi dan sangat populer dalam masakan Asia karena teksturnya yang kenyal.',
    },
    {
      'name': 'Termitomyces sp.',
      'latin': 'Jamur Rayap',
      'status': 'Aman Dikonsumsi ✅',
      'images': [
        'assets/13.jpeg',
        'assets/14.jpeg',
        'assets/15.jpeg',
        'assets/13.jpeg',
      ],
      'desc': 'Jamur yang tumbuh secara simbiosis di sarang rayap, memiliki rasa yang sangat lezat dan bernilai ekonomi tinggi.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FBF8),
      appBar: AppBar(
        title: Text(
          "Ensiklopedia Jamur",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
        itemCount: mushrooms.length,
        itemBuilder: (context, index) {
          return _buildEnhancedCard(context, mushrooms[index]);
        },
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 2),
    );
  }

  Widget _buildEnhancedCard(BuildContext context, Map<String, dynamic> item) {
    final bool isPoisonous = item['status'].toString().contains("Beracun");

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () => _showDetailModal(context, item),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                  child: Image.asset(
                    item['images'][0], // Ambil gambar pertama untuk cover
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 15,
                  right: 15,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      item['status'],
                      style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['name'],
                              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              item['latin'],
                              style: GoogleFonts.poppins(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.grey[500]),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        isPoisonous ? Icons.warning_amber_rounded : Icons.check_circle_outline,
                        color: isPoisonous ? accentPoison : accentSafe,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    item['desc'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(fontSize: 13, color: Colors.black54, height: 1.5),
                  ),
                  const SizedBox(height: 15),
                  const Divider(),
                  Center(
                    child: Text(
                      "Ketuk untuk detail & galeri",
                      style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w500, color: primaryColor.withOpacity(0.6)),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDetailModal(BuildContext context, Map<String, dynamic> item) {
    final bool isPoisonous = item['status'].toString().contains("Beracun");
    final List<String> imageList = List<String>.from(item['images']);
    int currentSlide = 0; // Index slide lokal untuk modal

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) {
          return DraggableScrollableSheet(
            initialChildSize: 0.85,
            maxChildSize: 0.95,
            minChildSize: 0.5,
            builder: (_, controller) => Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: ListView(
                controller: controller,
                padding: const EdgeInsets.all(24),
                children: [
                  Center(
                    child: Container(
                      width: 40, height: 4,
                      decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(height: 25),

                  // 🔹 IMAGE SLIDER
                  SizedBox(
                    height: 250,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        PageView.builder(
                          itemCount: imageList.length,
                          onPageChanged: (index) {
                            setModalState(() => currentSlide = index);
                          },
                          itemBuilder: (context, index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: Image.asset(imageList[index], fit: BoxFit.cover, width: double.infinity),
                            );
                          },
                        ),
                        // Dot Indicators
                        if (imageList.length > 1)
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                imageList.length,
                                    (index) => AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  margin: const EdgeInsets.symmetric(horizontal: 4),
                                  height: 8,
                                  width: currentSlide == index ? 20 : 8,
                                  decoration: BoxDecoration(
                                    color: currentSlide == index ? Colors.white : Colors.white54,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item['name'], style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold)),
                            Text(item['latin'], style: GoogleFonts.poppins(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.grey)),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isPoisonous ? accentPoison.withOpacity(0.1) : accentSafe.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(isPoisonous ? Icons.warning : Icons.restaurant, color: isPoisonous ? accentPoison : accentSafe),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey[50]!.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Informasi Lengkap", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 15)),
                        const SizedBox(height: 10),
                        Text(
                          item['desc'],
                          style: GoogleFonts.poppins(fontSize: 14, height: 1.6, color: Colors.black87),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      minimumSize: const Size(double.infinity, 55),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 0,
                    ),
                    child: Text("Tutup", style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}