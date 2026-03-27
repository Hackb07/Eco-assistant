import '../models/waste_category.dart';

class WasteDatabase {
  static const List<WasteCategory> categories = [
    WasteCategory(
      id: 'plastic',
      name: 'Plastic',
      description: 'Polymers used in bottles, containers, and packaging.',
      reuseOptions: ['Planters', 'Storage containers', 'DIY crafts', 'Bird feeders'],
      recyclingSteps: [
        'Clean & dry the plastic',
        'Remove labels and caps',
        'Segregate by resin code (if visible)',
        'Drop at local plastic collection center'
      ],
      minPrice: 8,
      maxPrice: 20,
      recyclability: Recyclability.high,
      co2Saved: 1.5,
      energySaved: 5.7,
      precautions: 'Avoid burning plastic as it releases toxic fumes.',
    ),
    WasteCategory(
      id: 'metal',
      name: 'Metal',
      description: 'Aluminum cans, iron scrap, and copper wires.',
      reuseOptions: ['Organizers', 'Metal art', 'Garden tools'],
      recyclingSteps: [
        'Rinse beverage cans',
        'Separate ferrous and non-ferrous metals',
        'Crush cans to save space',
        'Sell to authorized scrap dealers'
      ],
      minPrice: 15,
      maxPrice: 450, // Higher for copper
      recyclability: Recyclability.high,
      co2Saved: 2.1,
      energySaved: 14.0,
      precautions: 'Watch out for sharp edges on cut metal.',
    ),
    WasteCategory(
      id: 'organic',
      name: 'Organic',
      description: 'Food scraps, yard waste, and biodegradable matter.',
      reuseOptions: ['Home composting', 'Animal feed'],
      recyclingSteps: [
        'Collect in a separate bin',
        'Chop into small pieces',
        'Add to a compost pit or bin',
        'Use the resulting manure for gardening'
      ],
      minPrice: 0,
      maxPrice: 5,
      recyclability: Recyclability.high,
      co2Saved: 0.8,
      energySaved: 0.2,
      precautions: 'Keep compost moist but not soggy to avoid odors.',
    ),
    WasteCategory(
      id: 'e-waste',
      name: 'E-waste',
      description: 'Broken electronics, batteries, and cables.',
      reuseOptions: ['Repair if possible', 'Salvage components', 'Donation'],
      recyclingSteps: [
        'Wipe personal data from devices',
        'Remove batteries if possible',
        'Keep in a dry place',
        'Hand over to certified E-waste recyclers only'
      ],
      minPrice: 50,
      maxPrice: 5000,
      recyclability: Recyclability.medium,
      co2Saved: 3.5,
      energySaved: 25.0,
      precautions: 'Do not break components like screens or batteries at home.',
    ),
    WasteCategory(
      id: 'glass',
      name: 'Glass',
      description: 'Bottles, jars, and broken glassware.',
      reuseOptions: ['Storage jars', 'Decoration', 'Vases'],
      recyclingSteps: [
        'Wash and dry',
        'Sort by color (clear, green, brown)',
        'Remove metal/plastic caps',
        'Deposit in glass recycling bins'
      ],
      minPrice: 2,
      maxPrice: 10,
      recyclability: Recyclability.high,
      co2Saved: 0.3,
      energySaved: 0.7,
      precautions: 'Handle broken glass with thick gloves.',
    ),
    WasteCategory(
      id: 'paper',
      name: 'Paper',
      description: 'Newspapers, cardboard, and office paper.',
      reuseOptions: ['Packing material', 'Gift wrapping', 'Note pads'],
      recyclingSteps: [
        'Keep dry and clean',
        'Remove plastic tapes and staples',
        'Flatten cardboard boxes',
        'Store in stacks for the paper collector'
      ],
      minPrice: 5,
      maxPrice: 15,
      recyclability: Recyclability.high,
      co2Saved: 1.0,
      energySaved: 4.0,
      precautions: 'Shred sensitive documents before recycling.',
    ),
    WasteCategory(
      id: 'debris',
      name: 'Construction Debris',
      description: 'Bricks, concrete, and tiling waste.',
      reuseOptions: ['Landfilling', 'Pathway paving', 'Garden edging'],
      recyclingSteps: [
        'Separate from general waste',
        'Sort into bricks, concrete, and soil',
        'Contact specialized C&D waste collectors'
      ],
      minPrice: 0,
      maxPrice: 2,
      recyclability: Recyclability.low,
      co2Saved: 0.1,
      energySaved: 0.1,
      precautions: 'Use safety gear when handling heavy or dusty materials.',
    ),
  ];

  static WasteCategory? getById(String id) {
    try {
      return categories.firstWhere((c) => c.id.toLowerCase() == id.toLowerCase());
    } catch (_) {
      return null;
    }
  }

  static WasteCategory? findByName(String query) {
    query = query.toLowerCase();
    for (var category in categories) {
      if (category.name.toLowerCase().contains(query) || 
          category.description.toLowerCase().contains(query)) {
        return category;
      }
    }
    return null;
  }
}
