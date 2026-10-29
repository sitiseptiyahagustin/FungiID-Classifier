import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/ai_screen.dart';
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
      children: [
        // Navbar background
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
                const SizedBox(width: 60), // jarak untuk FAB di tengah
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

        // Floating button kamera di tengah
        Positioned(
          bottom: 30,
          child: FloatingActionButton(
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
            child: const Icon(Icons.camera_alt_rounded, size: 30, color: Colors.white),
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
          Icon(icon, color: isActive ? const Color(0xFF4CAF50) : Colors.grey),
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
