class Result {
  Result(
      {required this.category,
      required this.timeStamp,
      required this.difficulty,
      required this.trueCount,
      required this.wrongCount});

  final int? timeStamp;
  final String? category;
  final String? difficulty;
  final int? trueCount;
  final int? wrongCount;

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      timeStamp: json['timeStamp'] as int?,
      category: json['category'] as String?,
      difficulty: json['difficulty'] as String?,
      trueCount: json['trueCount'] as int?,
      wrongCount: json['wrongCount'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'timeStamp': timeStamp,
      'category': category,
      'difficulty': difficulty,
      'trueCount': trueCount,
      'wrongCount': wrongCount
    };
  }
}
