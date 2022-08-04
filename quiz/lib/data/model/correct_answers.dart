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
        answerA: (json['answer_a_correct'] as String).toBoolType,
        answerB: (json['answer_b_correct'] as String).toBoolType,
        answerC: (json['answer_c_correct'] as String).toBoolType,
        answerD: (json['answer_d_correct'] as String).toBoolType,
        answerE: (json['answer_e_correct'] as String).toBoolType,
        answerF: (json['answer_f_correct'] as String).toBoolType);
  }
}

extension StringAddition on String{
  bool get toBoolType=> this == 'true'?true:false;
}