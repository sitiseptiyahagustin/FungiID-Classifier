import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tflite_v2/tflite_v2.dart';
import 'package:google_fonts/google_fonts.dart';

class OutputScreen extends StatefulWidget {
  final String imagePath;

  const OutputScreen({super.key, required this.imagePath});

  @override
  State<OutputScreen> createState() => _OutputScreenState();
}

// Database Mapping Hasil Prediksi
final Map<String, Map<String, String>> dataJamur = {

  "Auricularia auricula judae": {
    "kategori": "Aman Dikonsumsi ✅",
    "habitat":
    "Tumbuh di daerah tropis dan subtropis pada kayu mati, batang pohon lapuk, atau ranting lembap. "
        "Sering muncul setelah hujan di lingkungan dengan kelembapan tinggi seperti hutan tropis, kebun, "
        "dan area teduh serta biasanya tumbuh berkelompok sepanjang tahun.",
    "karakteristik":
    "Bentuk menyerupai telinga manusia dengan warna cokelat kemerahan hingga kehitaman. "
        "Permukaan luar sedikit berbulu halus, bagian dalam licin mengilap, bertekstur kenyal seperti gel, "
        "tidak memiliki batang jelas, dan berukuran sekitar 3–10 cm."
  },

  "Fly Agaric": {
    "kategori": "Beracun ⚠️",
    "habitat":
    "Tumbuh di wilayah beriklim dingin hingga sedang di hutan konifer dan campuran. "
        "Sering ditemukan di bawah pohon pinus, spruce, fir, dan birch pada tanah berlumut "
        "atau lembap di akhir musim panas hingga musim gugur.",
    "karakteristik":
    "Tudung merah cerah berdiameter 8–20 cm dengan bintik putih. Insang putih rapat, "
        "batang putih kokoh dengan cincin serta pangkal batang memiliki volva berbentuk kantung."
  },

  "amanita_patherina": {
    "kategori": "Beracun ⚠️",
    "habitat":
    "Ditemukan di hutan gugur dan konifer pada daerah beriklim sedang. "
        "Biasanya tumbuh di tanah kaya bahan organik di sekitar pohon oak, beech, pinus, dan cemara.",
    "karakteristik":
    "Tudung cokelat kekuningan 5–12 cm dengan bintik putih kecil rapi. "
        "Memiliki insang putih, batang ramping bercincin, dan pangkal batang "
        "membulat dengan volva berbentuk cincin konsentris."
  },

  "Termitomyces": {
    "kategori": "Aman Dikonsumsi ✅",
    "habitat":
    "Tumbuh di daerah tropis di sekitar sarang rayap tanah dan muncul setelah hujan lebat "
        "di padang rumput, ladang, atau pinggir hutan yang memiliki koloni rayap aktif.",
    "karakteristik":
    "Tudung berbentuk payung dengan puncak meruncing berwarna putih krem hingga cokelat muda. "
        "Batang panjang terhubung ke akar semu (pseudorhiza) menuju sarang rayap, insang putih rapat "
        "dan daging jamur tebal beraroma gurih."
  },
};
class _OutputScreenState extends State<OutputScreen> {
  bool _modelLoaded = false;
  String label = "Mengidentifikasi...";
  String kategori = "-";
  String deskripsi = "Sedang menganalisis data...";
  double confidence = 0.0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _runModel();
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  Color _getAccuracyColor(double conf) {
    double percent = conf * 100;
    if (percent < 60) return Colors.red;
    if (percent < 80) return Colors.orange;
    return Colors.green;
  }

  String _getAccuracyLabel(double conf) {
    double percent = conf * 100;
    if (percent < 60) return "Akurasi Rendah (Objek tidak dikenali)";
    if (percent < 80) return "Akurasi Cukup";
    return "Akurasi Sangat Tinggi";
  }

  Future<void> _runModel() async {
    try {
      if (!_modelLoaded) {
        await Tflite.loadModel(
          model: "assets/model_cnn.tflite",
          labels: "assets/labels.txt",
        );
        _modelLoaded = true;
      }

      var recognitions = await Tflite.runModelOnImage(
        path: widget.imagePath,
        imageMean: 0,
        imageStd: 255,
        numResults: 1,
        threshold: 0.1,
      );

      if (recognitions != null && recognitions.isNotEmpty) {
        final result = recognitions[0];
        String resultLabel = result['label']?.toString() ?? "-";

        setState(() {
          confidence = (result['confidence'] as double);

          // ===== CONFIDENCE THRESHOLD =====
          if (confidence < 0.6) {
            label = "Tidak Dikenali";
            kategori = "Bukan Jamur";
            deskripsi =
            "Gambar tidak dapat diidentifikasi sebagai jamur. "
                "Silakan ambil gambar jamur dengan jelas.";
          } else {
            label = resultLabel;
            var info = dataJamur[resultLabel];
            if (info != null) {
              kategori = info["kategori"]!;

              String habitat = info["habitat"]!;
              String karakteristik = info["karakteristik"]!;

              deskripsi =
              "Habitat:\n$habitat\n\n"
                  "Karakteristik:\n$karakteristik";
            } else {
              kategori = "Tidak Diketahui";
              deskripsi = "Data penjelasan untuk jenis ini belum tersedia.";
            }
          }
          // ===============================

          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isPoisonous = kategori.contains("Beracun");
    Color accuracyColor = _getAccuracyColor(confidence);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'HASIL IDENTIFIKASI',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(
          child: CircularProgressIndicator(color: Color(0xFF2E7D32)))
          : SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 320,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: Image.file(
                  File(widget.imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 25),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                  )
                ],
              ),
              child: Column(
                children: [
                  _buildResultRow(
                      Icons.eco_outlined, "Nama Jamur", label, Colors.blue),
                  const Divider(height: 30),
                  _buildResultRow(
                    isPoisonous
                        ? Icons.warning_amber_rounded
                        : Icons.check_circle_outline,
                    "Kategori",
                    kategori,
                    isPoisonous ? Colors.red : Colors.green,
                  ),
                  const Divider(height: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Akurasi Prediksi",
                              style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  color: Colors.grey[600])),
                          Text(
                            "${(confidence * 100).toStringAsFixed(1)}%",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                color: accuracyColor),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: confidence,
                          backgroundColor: Colors.grey[200],
                          valueColor:
                          AlwaysStoppedAnimation<Color>(
                              accuracyColor),
                          minHeight: 10,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _getAccuracyLabel(confidence),
                        style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: accuracyColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isPoisonous
                    ? const Color(0xFFFFEBEE)
                    : const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                    color: isPoisonous
                        ? Colors.red.shade100
                        : Colors.green.shade100),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline,
                          color:
                          isPoisonous ? Colors.red : Colors.green,
                          size: 20),
                      const SizedBox(width: 8),
                      Text("Penjelasan Detail",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              color: isPoisonous
                                  ? Colors.red[900]
                                  : Colors.green[900])),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    deskripsi,
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.black87,
                        height: 1.6),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultRow(
      IconData icon, String title, String value, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12)),
          child: Icon(icon, color: color, size: 26),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: GoogleFonts.poppins(
                      fontSize: 12, color: Colors.grey[600])),
              Text(value,
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }

}
