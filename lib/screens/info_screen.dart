import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/bottom_navbar.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  final Color primaryColor = const Color(0xFF2E7D32);
  final Color accentPoison = const Color(0xFFE53935);
  final Color accentSafe = const Color(0xFF43A047);

  // Data Jamur yang diperluas
  final List<Map<String, dynamic>> mushrooms = [
    {
      'name': 'Fly Agaric',
      'latin': 'Amanita Muscaria',
      'status': 'Beracun ⚠️',
      'images': ['assets/1.jpg', 'assets/2.jpeg', 'assets/3.jpg', 'assets/4.jpeg'],
      'summary': 'Ikon jamur beracun dengan tudung merah bintik putih yang sangat mencolok.',
      'habitat': 'Tumbuh di wilayah beriklim dingin hingga sedang di Eropa, Asia Utara, dan Amerika Utara. Umumnya ditemukan di hutan konifer dan hutan campuran yang didominasi pohon pinus, spruce, fir, dan birch. Jamur ini bersimbiosis mikoriza dengan akar pohon dan biasanya muncul di tanah berlumut, tanah berpasir, atau area hutan lembap pada akhir musim panas hingga musim gugur.',
      'characteristics': 'Tudung berdiameter 8–20 cm berwarna merah cerah hingga merah-oranye dengan bintik putih sisa selubung universal. Insang putih krem dan rapat, batang putih kokoh setinggi 10–20 cm dengan cincin jelas serta pangkal batang memiliki volva berbentuk kantung. Warna tudung dapat memudar saat jamur menua.',
      'danger': 'Mengandung Muscimol. Gejala berupa mual, kejang, hingga halusinasi berat yang tidak menyenangkan.',
    },
    {
      'name': 'Panther Cap',
      'latin': 'Amanita Pantherina',
      'status': 'Beracun ⚠️',
      'images': ['assets/5.jpeg', 'assets/6.jpeg', 'assets/7.jpg', 'assets/8.jpg'],
      'summary': 'Kerabat dekat Fly Agaric namun dengan konsentrasi toksin yang jauh lebih kuat.',
      'habitat': 'Ditemukan di hutan gugur dan konifer pada daerah beriklim sedang. Biasanya tumbuh di tanah hutan kaya bahan organik di sekitar pohon oak, beech, pinus, dan cemara. Muncul pada akhir musim panas hingga musim gugur, sering tersembunyi di antara daun kering atau rumput hutan.',
      'characteristics': 'Tudung berdiameter 5–12 cm berwarna cokelat kekuningan hingga cokelat zaitun dengan bintik putih kecil tersusun rapi. Pinggiran tudung beralur halus, insang putih rapat, batang ramping dengan cincin tipis, serta pangkal batang membulat dengan volva berbentuk cincin konsentris.',
      'danger': 'Sangat berbahaya. Toksinnya menyerang sistem saraf pusat, menyebabkan kebingungan dan koma.',
    },
    {
      'name': 'Jamur Kuping',
      'latin': 'Auricularia Auricula',
      'status': 'Aman Dikonsumsi ✅',
      'images': ['assets/9.jpeg', 'assets/10.jpeg', 'assets/11.jpg', 'assets/12.jpg'],
      'summary': 'Jamur konsumsi populer yang kaya akan serat dan baik untuk sirkulasi darah.',
      'habitat': 'Tumbuh di daerah tropis dan subtropis pada kayu mati, batang pohon lapuk, atau ranting lembap. Sering muncul setelah hujan di lingkungan dengan kelembapan tinggi seperti hutan tropis, kebun, dan area teduh. Biasanya tumbuh berkelompok sepanjang tahun di daerah lembap.',
      'characteristics': 'Bentuk menyerupai telinga manusia dengan warna cokelat kemerahan hingga cokelat kehitaman. Permukaan luar sedikit berbulu halus, bagian dalam licin mengilap, bertekstur kenyal seperti gel, tidak memiliki batang jelas, dan berukuran sekitar 3–10 cm.',
      'benefits': 'Rendah kalori, tinggi serat, dan mengandung antioksidan yang baik untuk kesehatan jantung.',
    },
    {
      'name': 'Jamur Rayap',
      'latin': 'Termitomyces sp.',
      'status': 'Aman Dikonsumsi ✅',
      'images': ['assets/13.jpeg', 'assets/14.jpeg', 'assets/15.jpeg', 'assets/13.jpeg'],
      'summary': 'Jamur liar musiman yang memiliki cita rasa paling gurih di antara jamur lainnya.',
      'habitat': 'Tumbuh di daerah tropis di sekitar sarang rayap tanah. Muncul secara musiman setelah hujan lebat pada tanah lembap di padang rumput, ladang, atau pinggir hutan yang memiliki koloni rayap aktif.',
      'characteristics': 'Memiliki tudung berbentuk payung dengan puncak meruncing (umbo) berwarna putih krem hingga cokelat muda. Batang panjang ramping terhubung ke akar semu (pseudorhiza) yang menembus tanah menuju sarang rayap. Insang putih rapat, ukuran tudung dapat mencapai 5–20 cm dengan daging tebal dan aroma gurih khas.',
      'benefits': 'Sumber protein yang sangat tinggi dan sering dianggap sebagai pengganti rasa daging alami.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FBF8),
      appBar: AppBar(
        title: Text("Ensiklopedia Jamur", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
        itemCount: mushrooms.length,
        itemBuilder: (context, index) => _buildEnhancedCard(context, mushrooms[index]),
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
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () => _showDetailModal(context, item),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              child: Image.asset(item['images'][0], height: 180, width: double.infinity, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item['name'], style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
                      Icon(isPoisonous ? Icons.report_problem : Icons.check_circle, color: isPoisonous ? accentPoison : accentSafe),
                    ],
                  ),
                  Text(item['summary'], style: GoogleFonts.poppins(fontSize: 13, color: Colors.black54)),
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
    int currentSlide = 0;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => DraggableScrollableSheet(
          initialChildSize: 0.9,
          builder: (_, controller) => Container(
            decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
            child: ListView(
              controller: controller,
              padding: const EdgeInsets.all(24),
              children: [
                _buildModalHeader(),
                _buildImageSlider(item['images'], (index) => setModalState(() => currentSlide = index), currentSlide),
                const SizedBox(height: 20),

                // Judul & Nama Latin
                Text(item['name'], style: GoogleFonts.poppins(fontSize: 26, fontWeight: FontWeight.bold)),
                Text(item['latin'], style: GoogleFonts.poppins(fontSize: 16, fontStyle: FontStyle.italic, color: primaryColor)),
                const Divider(height: 30),

                // Section Detail
                _infoSection("📍 Habitat", item['habitat']),
                _infoSection("🔍 Karakteristik", item['characteristics']),
                isPoisonous
                    ? _infoSection("⚠️ Bahaya Toksin", item['danger'], color: accentPoison)
                    : _infoSection("🥗 Manfaat", item['benefits'], color: accentSafe),

                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 16)
                  ),
                  child: const Text("Tutup Informasi", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModalHeader() {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        width: 50, height: 5,
        decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _buildImageSlider(List<String> images, Function(int) onPageChanged, int currentSlide) {
    return SizedBox(
      height: 250,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
            itemCount: images.length,
            onPageChanged: onPageChanged,
            itemBuilder: (context, index) => ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(images[index], fit: BoxFit.cover),
            ),
          ),
          Positioned(
            bottom: 10,
            child: Row(
              children: List.generate(images.length, (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 8, width: currentSlide == index ? 24 : 8,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
              )),
            ),
          )
        ],
      ),
    );
  }

  Widget _infoSection(String title, String content, {Color color = Colors.black87}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16, color: primaryColor)),
          const SizedBox(height: 6),
          Text(content, style: GoogleFonts.poppins(fontSize: 14, color: color, height: 1.5), textAlign: TextAlign.justify),
        ],
      ),
    );
  }
}