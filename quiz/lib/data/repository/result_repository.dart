import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quize/data/model/result.dart';

abstract class ResultRepository {
  /// Get all results
  Future<List<Result>> getResults();
  Future<void> addResult(Result result);
}

class IResultRepository implements ResultRepository {
  @override
  Future<List<Result>> getResults() async {
    final resultsQuerySnapshot =
        await FirebaseFirestore.instance.collection('result').get();

    final resultsJson = resultsQuerySnapshot.docs;
    var results = <Result>[];
    for (final element in resultsJson) {
      final result = Result.fromJson(element.data());
      results.add(result);
    }
    return results;
  }

  @override
  Future<void> addResult(Result result) async {
    CollectionReference results =
        FirebaseFirestore.instance.collection('result');
    final resultJson = result.toJson();
    await results.add(resultJson).catchError((error) {
      log('Faild to add Category $error');
    });
  }
}
