import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quize/data/repository/result_repository.dart';
import 'package:quize/presentation/result/result_event.dart';
import 'package:quize/presentation/result/result_state.dart';

class ResultBloc extends Bloc<ResultEvent, ResultState> {
  ResultBloc({required this.resultRepository}) : super(ResultInitialState()) {
    on<GetResults>(_onGetResults);
  }

  final ResultRepository resultRepository;

  Future<void> _onGetResults(
      GetResults event, Emitter<ResultState> emit) async {
    final results = await resultRepository.getResults();
    emit(ResultsLoaded(results: results));
  }
}
