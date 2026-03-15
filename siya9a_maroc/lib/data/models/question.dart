class Question {
  final String id;
  final String text;          // Darija / Arabic
  final String? textFr;       // optional French
  final String? imagePath;
  final List<String> options;
  final int correctIndex;
  final String explanation;
  final String category;

  const Question({
    required this.id,
    required this.text,
    this.textFr,
    this.imagePath,
    required this.options,
    required this.correctIndex,
    required this.explanation,
    required this.category,
  });

  factory Question.fromJson(Map<String, dynamic> j) => Question(
    id:           j['id'],
    text:         j['text'],
    textFr:       j['text_fr'],
    imagePath:    j['image'],
    options:      List<String>.from(j['options']),
    correctIndex: j['correct'],
    explanation:  j['explanation'],
    category:     j['category'],
  );
}
