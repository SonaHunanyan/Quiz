class CorrectAnswer {
  CorrectAnswer(
      {this.answerA,
      this.answerB,
      this.answerC,
      this.answerD,
      this.answerE,
      this.answerF});

  final bool? answerA;
  final bool? answerB;
  final bool? answerC;
  final bool? answerD;
  final bool? answerE;
  final bool? answerF;

  factory CorrectAnswer.fromJson(Map<String, dynamic> json) {
    return CorrectAnswer(
        answerA: json['answer_a'] as bool?,
        answerB: json['answer_b'] as bool?,
        answerC: json['answer_c'] as bool?,
        answerD: json['answer_d'] as bool?,
        answerE: json['answer_e'] as bool?,
        answerF: json['answer_f'] as bool?);
  }
}
