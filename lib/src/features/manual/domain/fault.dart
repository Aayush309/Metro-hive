/// Domain model for a single fault entry from manual.json.
library;

/// A single troubleshooting fault from the maintenance manual.
class Fault {
  const Fault({
    required this.id,
    required this.category,
    required this.titleEn,
    required this.titleGu,
    required this.safetyEn,
    required this.safetyGu,
    required this.stepsEn,
    required this.stepsGu,
    required this.keywords,
  });

  factory Fault.fromJson(Map<String, dynamic> json) {
    final title = json['title'] as Map<String, dynamic>;
    final safety = json['safety'] as Map<String, dynamic>;
    final stepsRaw = json['steps'] as List<dynamic>;
    final keywordsRaw = json['keywords'] as List<dynamic>;

    return Fault(
      id: json['id'] as String,
      category: json['category'] as String,
      titleEn: title['en'] as String,
      titleGu: title['gu'] as String,
      safetyEn: safety['en'] as String,
      safetyGu: safety['gu'] as String,
      stepsEn: stepsRaw.map((s) => (s as Map<String, dynamic>)['en'] as String).toList(),
      stepsGu: stepsRaw.map((s) => (s as Map<String, dynamic>)['gu'] as String).toList(),
      keywords: keywordsRaw.map((k) => k as String).toList(),
    );
  }

  final String id;
  final String category;
  final String titleEn;
  final String titleGu;
  final String safetyEn;
  final String safetyGu;
  final List<String> stepsEn;
  final List<String> stepsGu;
  final List<String> keywords;

  /// Returns the localised title for the given locale code (e.g. 'en', 'gu').
  String title(String locale) => locale == 'gu' ? titleGu : titleEn;

  /// Returns the localised safety warning.
  String safety(String locale) => locale == 'gu' ? safetyGu : safetyEn;

  /// Returns the localised step list.
  List<String> steps(String locale) => locale == 'gu' ? stepsGu : stepsEn;

  /// Number of troubleshooting steps.
  int get stepCount => stepsEn.length;
}
