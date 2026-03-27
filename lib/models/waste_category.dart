enum Recyclability { low, medium, high }

class WasteCategory {
  final String id;
  final String name;
  final String description;
  final List<String> reuseOptions;
  final List<String> recyclingSteps;
  final double minPrice; // ₹ per kg
  final double maxPrice; // ₹ per kg
  final Recyclability recyclability;
  final double co2Saved; // kg CO2 per kg waste
  final double energySaved; // kWh per kg waste
  final String precautions;

  const WasteCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.reuseOptions,
    required this.recyclingSteps,
    required this.minPrice,
    required this.maxPrice,
    required this.recyclability,
    required this.co2Saved,
    required this.energySaved,
    required this.precautions,
  });
}
