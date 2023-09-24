class FQA {
  final int id;
  final String question;
  final String answer;
  bool isExpanded;

   FQA({
    required this.id,
    required this.question,
    required this.answer,
    this.isExpanded = false,
  });
}
