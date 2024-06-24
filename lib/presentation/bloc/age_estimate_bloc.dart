import 'package:age_estimater/domain/repository/age_estimate_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'age_estimate_state.dart';
part 'age_estimate_event.dart';

class AgeEstimateBloc extends Bloc<AgeEstimateEvent, AgeEstimateState> {
  final AgeEstimateRepository ageRepository;

  AgeEstimateBloc(
    this.ageRepository,
  ) : super(AgeInitial()) {
    on<GetAgeEvent>(_onGetAgeEvent);
    on<ResetEvent>(_onResetEvent);
  }

  Future<void> _onGetAgeEvent(GetAgeEvent event, Emitter<AgeEstimateState> emit) async {
    emit(AgeLoading());
    try {
      final response = await ageRepository.getAgeEstimate(event.name);
      emit(AgeLoaded(response.age));
    } catch (e) {
      emit(AgeError(e.toString()));
    }
  }

  void _onResetEvent(ResetEvent event, Emitter<AgeEstimateState> emit) {
    emit(AgeInitial());
  }
}
