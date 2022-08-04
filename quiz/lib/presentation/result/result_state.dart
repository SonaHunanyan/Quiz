import 'package:equatable/equatable.dart';
import 'package:quize/data/model/result.dart';

abstract class ResultState extends Equatable {}

class ResultInitialState extends ResultState {
  @override
  List<Object?> get props => [];
}

class ResultsLoaded extends ResultState {
  ResultsLoaded({required this.results});
  final List<Result> results;
  @override
  List<Object?> get props => [results];
}
