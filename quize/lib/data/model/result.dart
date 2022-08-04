class Result {
  Result(
      {required this.category,
      required this.dateTime,
      required this.difficulty,
      required this.trueCount,
      required this.wrongCount});

  final String? dateTime;
  final String? category;
  final String? difficulty;
  final int? trueCount;
  final int? wrongCount;

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      dateTime: json['dateTime'] as String?,
      category: json['category'] as String?,
      difficulty: json['difficulty'] as String?,
      trueCount: json['trueCount'] as int?,
      wrongCount: json['wrongCount'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'dateTime': dateTime,
      'category': category,
      'difficulty': difficulty,
      'trueCount': trueCount,
      'wrongCount': wrongCount
    };
  }
}
