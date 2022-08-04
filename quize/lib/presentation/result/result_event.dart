import 'package:equatable/equatable.dart';

abstract class ResultEvent extends Equatable {}

class GetResults extends ResultEvent {
  @override
  List<Object?> get props => [];
}
