import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/theme.dart';
import '../widgets/glass_card.dart';
import '../utils/localization.dart';
import 'scanner_screen.dart';
import 'chat_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _toggleLanguage() {
    setState(() {
      Localization.setLanguage(
        Localization.currentLanguage == AppLanguage.english
            ? AppLanguage.tamil
            : AppLanguage.english,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(-0.8, -0.8),
            radius: 1.5,
            colors: [
              Color(0xFF1B3A1B),
              AppColors.background,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 32),
                _buildImpactSummary(),
                const SizedBox(height: 40),
                Text(
                  Localization.currentLanguage == AppLanguage.english
                      ? 'Quick Actions'
                      : 'விரைவான செயல்கள்',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 20),
                _buildActionButtons(),
                const SizedBox(height: 40),
                _buildRecentActivity(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Localization.currentLanguage == AppLanguage.english
                  ? 'EcoAssistant'
                  : 'சுற்றுச்சூழல் உதவியாளர்',
              style: GoogleFonts.outfit(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.accent,
              ),
            ),
            Text(
              Localization.currentLanguage == AppLanguage.english
                  ? 'Offline Circular Economy'
                  : 'ஆஃப்லைன் சுழற்சி பொருளாதாரம்',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
            ),
          ],
        ),
        GestureDetector(
          onTap: _toggleLanguage,
          child: GlassCard(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            borderRadius: 12,
            child: Text(
              Localization.currentLanguage == AppLanguage.english ? 'தமிழ்' : 'EN',
              style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.accent),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImpactSummary() {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.eco_outlined, color: AppColors.accent),
              const SizedBox(width: 8),
              Text(
                Localization.get('env_impact'),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildImpactItem('12.5 kg', Localization.get('co2_saved'), Icons.cloud_done_outlined),
              _buildImpactItem('45 kWh', 'Energy', Icons.bolt),
              _buildImpactItem('22 kg', 'Waste Red.', Icons.delete_outline),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImpactItem(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: AppColors.secondary, size: 24),
        const SizedBox(height: 8),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: _buildActionCard(
            Localization.currentLanguage == AppLanguage.english ? 'Scan Waste' : 'கழிவை ஸ்கேன் செய்',
            Icons.camera_alt_rounded,
            AppColors.accent,
            () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ScannerScreen())),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildActionCard(
            Localization.currentLanguage == AppLanguage.english ? 'Ask Assistant' : 'உதவியாளரிடம் கேளுங்கள்',
            Icons.chat_bubble_outline_rounded,
            Colors.blueAccent,
            () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatScreen())),
          ),
        ),
      ],
    );
  }

  Widget _buildActionCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: GlassCard(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Localization.currentLanguage == AppLanguage.english ? 'Recent Insights' : 'சமீபத்திய தகவல்கள்',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        _buildActivityTile('Plastic Bottle', 'Recyclable • ₹12/kg', '2h ago'),
        _buildActivityTile('Old Battery', 'Hazardous • Dispose Safe', 'Yesterday'),
      ],
    );
  }

  Widget _buildActivityTile(String title, String subtitle, String time) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassCard(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        borderRadius: 16,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.secondary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.history, color: AppColors.secondary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(subtitle, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                ],
              ),
            ),
            Text(time, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
          ],
        ),
      ),
    );
  }
}
