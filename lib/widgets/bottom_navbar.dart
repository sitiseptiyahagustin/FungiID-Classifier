import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/ai_screen.dart'; // Pastikan nama file sesuai, di kode awal Anda memakai ai_screen.dart
import '../screens/info_screen.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;

  const BottomNavBar({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    const Color activeColor = Color(0xFF4CAF50);
    const Color inactiveColor = Colors.grey;

    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none, // Agar label di bawah FAB tidak terpotong
      children: [
        // 1. Navbar Background (Container Putih)
        Container(
          height: 70,
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.95),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _BottomNavItem(
                  icon: Icons.home_rounded,
                  label: "Beranda",
                  isActive: selectedIndex == 0,
                  onTap: () {
                    if (selectedIndex != 0) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const HomeScreen()),
                      );
                    }
                  },
                ),
                const SizedBox(width: 60), // Space untuk area tombol tengah
                _BottomNavItem(
                  icon: Icons.info_outline_rounded,
                  label: "Info",
                  isActive: selectedIndex == 2,
                  onTap: () {
                    if (selectedIndex != 2) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const InfoScreen()),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),

        // 2. Tombol Utama: Klasifikasi AI
        Positioned(
          bottom: 35, // Ditinggikan sedikit agar pas
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FloatingActionButton(
                backgroundColor: activeColor,
                elevation: 6,
                shape: const CircleBorder(),
                onPressed: () {
                  if (selectedIndex != 1) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const AIScanScreen()),
                    );
                  }
                },
                // MENGGUNAKAN IKON PSIKOLOGI/AI
                child: const Icon(
                    Icons.psychology_rounded,
                    size: 32,
                    color: Colors.white
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "AI Scan",
                style: TextStyle(
                  color: selectedIndex == 1 ? activeColor : inactiveColor,
                  fontSize: 12,
                  fontWeight: selectedIndex == 1 ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _BottomNavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
              icon,
              color: isActive ? const Color(0xFF4CAF50) : Colors.grey
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive ? const Color(0xFF4CAF50) : Colors.grey,
              fontSize: 12,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}