import 'dart:io';
import 'package:flutter/material.dart';
import '../services/waste_engine.dart';
import '../utils/theme.dart';
import '../widgets/glass_card.dart';
import '../utils/localization.dart';

class ResultDetailScreen extends StatelessWidget {
  final WasteResponse response;
  final String? imagePath;

  const ResultDetailScreen({super.key, required this.response, this.imagePath});

  @override
  Widget build(BuildContext context) {
    final cat = response.category;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMainInfo(context),
                  const SizedBox(height: 32),
                  _buildSectionTitle('♻️ ${Localization.get('reuse_options')}'),
                  _buildList(cat?.reuseOptions ?? ['No data available']),
                  const SizedBox(height: 32),
                  _buildSectionTitle('🔁 ${Localization.get('recycling_method')}'),
                  _buildList(cat?.recyclingSteps ?? ['No data available'], isNumbered: true),
                  const SizedBox(height: 32),
                  _buildSectionTitle('💰 ${Localization.get('estimated_value')}'),
                  _buildValueEstimation(cat),
                  const SizedBox(height: 32),
                  _buildSectionTitle('🌱 ${Localization.get('env_impact')}'),
                  _buildEnvironmentalImpact(cat),
                  const SizedBox(height: 32),
                  _buildSectionTitle('⚠️ ${Localization.get('precautions')}'),
                  _buildPrecautions(cat),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      backgroundColor: AppColors.background,
      flexibleSpace: FlexibleSpaceBar(
        background: imagePath != null
            ? Image.file(File(imagePath!), fit: BoxFit.cover)
            : Container(
                decoration: const BoxDecoration(gradient: AppColors.greenGradient),
                child: const Icon(Icons.eco, size: 100, color: Colors.white),
              ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildMainInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Localization.get('waste_type'),
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
                ),
                Text(
                  response.rawType,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
            if (response.isImageBased)
              GlassCard(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                borderRadius: 12,
                child: Column(
                  children: [
                    Text(Localization.get('confidence'), style: const TextStyle(fontSize: 10)),
                    Text(
                      response.confidence,
                      style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.accent),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildList(List<String> items, {bool isNumbered = false}) {
    return GlassCard(
      child: Column(
        children: items.asMap().entries.map((entry) {
          int idx = entry.key;
          String text = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isNumbered ? '${idx + 1}. ' : '• ',
                  style: const TextStyle(color: AppColors.accent, fontWeight: FontWeight.bold),
                ),
                Expanded(child: Text(text)),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildValueEstimation(dynamic cat) {
    if (cat == null) return const GlassCard(child: Text('Data not available'));
    return GlassCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildInfoMetric('₹${cat.minPrice} - ₹${cat.maxPrice}', 'Price /kg'),
          const VerticalDivider(color: Colors.white24),
          _buildInfoMetric(cat.recyclability.name.toUpperCase(), Localization.get('recyclability_score')),
        ],
      ),
    );
  }

  Widget _buildEnvironmentalImpact(dynamic cat) {
    if (cat == null) return const GlassCard(child: Text('Data not available'));
    return GlassCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildInfoMetric('${cat.co2Saved} kg', Localization.get('co2_saved'), icon: Icons.cloud_done_outlined),
          _buildInfoMetric('${cat.energySaved} kWh', 'Energy Saved', icon: Icons.bolt),
        ],
      ),
    );
  }

  Widget _buildPrecautions(dynamic cat) {
    if (cat == null) return const GlassCard(child: Text('Data not available'));
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const Icon(Icons.warning_amber_rounded, color: Colors.orangeAccent),
          const SizedBox(width: 12),
          Expanded(child: Text(cat.precautions, style: const TextStyle(fontStyle: FontStyle.italic))),
        ],
      ),
    );
  }

  Widget _buildInfoMetric(String value, String label, {IconData? icon}) {
    return Column(
      children: [
        if (icon != null) Icon(icon, color: AppColors.accent, size: 20),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
      ],
    );
  }
}
