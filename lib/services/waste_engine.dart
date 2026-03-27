import '../models/waste_category.dart';
import '../data/waste_database.dart';

class WasteResponse {
  final WasteCategory? category;
  final String rawType;
  final String confidence;
  final bool isImageBased;

  WasteResponse({
    this.category,
    required this.rawType,
    this.confidence = 'High',
    this.isImageBased = false,
  });
}

class WasteEngine {
  static WasteResponse processInput({
    String? imageLabel,
    double? confidenceScore,
    String? textInput,
  }) {
    // 1. Prioritize ML output if available
    if (imageLabel != null && confidenceScore != null) {
      final category = WasteDatabase.getById(imageLabel);
      String confidenceLevel = 'Low';
      if (confidenceScore > 0.8) {
        confidenceLevel = 'High';
      } else if (confidenceScore > 0.6) {
        confidenceLevel = 'Medium';
      }

      return WasteResponse(
        category: category,
        rawType: category?.name ?? imageLabel,
        confidence: confidenceLevel,
        isImageBased: true,
      );
    }

    // 2. Fallback to NLP-based understanding (Simple string matching for offline)
    if (textInput != null && textInput.isNotEmpty) {
      final category = WasteDatabase.findByName(textInput);
      return WasteResponse(
        category: category,
        rawType: category?.name ?? textInput,
        confidence: 'N/A',
        isImageBased: false,
      );
    }

    return WasteResponse(rawType: 'Unknown');
  }
}
