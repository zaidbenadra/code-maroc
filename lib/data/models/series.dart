class Series {
  final String id;
  final String title;
  final String subtitle;
  final String category;
  final int questionCount;

  const Series({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.questionCount,
  });

  factory Series.fromJson(Map<String, dynamic> j) => Series(
    id:            j['id'],
    title:         j['title'],
    subtitle:      j['subtitle'],
    category:      j['category'],
    questionCount: j['question_count'],
  );
}
