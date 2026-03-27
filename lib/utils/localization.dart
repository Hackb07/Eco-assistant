enum AppLanguage { english, tamil }

class Localization {
  static AppLanguage currentLanguage = AppLanguage.english;

  static const Map<String, Map<AppLanguage, String>> translations = {
    'waste_type': {
      AppLanguage.english: 'Waste Type',
      AppLanguage.tamil: 'கழிவு வகை',
    },
    'confidence': {
      AppLanguage.english: 'Confidence',
      AppLanguage.tamil: 'நம்பிக்கை',
    },
    'reuse_options': {
      AppLanguage.english: 'Reuse Options',
      AppLanguage.tamil: 'மீண்டும் பயன்படுத்தும் வழிகள்',
    },
    'recycling_method': {
      AppLanguage.english: 'Recycling Method',
      AppLanguage.tamil: 'மறுசுழற்சி முறை',
    },
    'estimated_value': {
      AppLanguage.english: 'Estimated Value',
      AppLanguage.tamil: 'மதிப்பிடப்பட்ட மதிப்பு',
    },
    'env_impact': {
      AppLanguage.english: 'Environmental Impact',
      AppLanguage.tamil: 'சுற்றுச்சூழல் தாக்கம்',
    },
    'precautions': {
      AppLanguage.english: 'Precautions',
      AppLanguage.tamil: 'முன்னெச்சரிக்கை',
    },
    'recyclability_score': {
      AppLanguage.english: 'Recyclability Score',
      AppLanguage.tamil: 'மறுசுழற்சி திறன்',
    },
    'co2_saved': {
      AppLanguage.english: 'CO₂ Saved',
      AppLanguage.tamil: 'கார்பன் சேமிப்பு',
    },
    'waste_reduction': {
      AppLanguage.english: 'Waste Reduction',
      AppLanguage.tamil: 'கழிவு குறைப்பு',
    },
  };

  static String get(String key) {
    return translations[key]?[currentLanguage] ?? key;
  }

  static void setLanguage(AppLanguage lang) {
    currentLanguage = lang;
  }
}
