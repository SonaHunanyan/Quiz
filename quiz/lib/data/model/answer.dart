class Answer {
  Answer(
      {this.answerA,
      this.answerB,
      this.answerC,
      this.answerD,
      this.answerE,
      this.answerF});

  final String? answerA;
  final String? answerB;
  final String? answerC;
  final String? answerD;
  final String? answerE;
  final String? answerF;

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      answerA: json['answer_a'] as String?,
      answerB: json['answer_b'] as String?,
      answerC: json['answer_c'] as String?,
      answerD: json['answer_d'] as String?,
      answerE: json['answer_e'] as String?,
      answerF: json['answer_f'] as String?,
    );
  }
}
