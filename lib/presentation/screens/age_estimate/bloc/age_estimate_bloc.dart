import 'package:age_estimater/domain/repository/age_estimate_repository/age_estimate_repository.dart';
import 'package:age_estimater/utils/validation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'age_estimate_event.dart';
part 'age_estimate_state.dart';

class AgeEstimateBloc extends Bloc<AgeEstimateEvent, AgeEstimateState> {
  final AgeEstimateRepository ageRepository;

  AgeEstimateBloc({required this.ageRepository}) : super(AgeInitial()) {
    on<GetAgeEvent>(_onGetAgeEvent);
    on<ResetEvent>(_onResetEvent);
  }

  Future<void> _onGetAgeEvent(
      GetAgeEvent event, Emitter<AgeEstimateState> emit) async {
    emit(AgeLoading());
    try {
      final response = await ageRepository.getAgeEstimate(event.name);
      emit(AgeLoaded(response.age, event.name));
    } catch (e) {
      emit(AgeError(e.toString()));
    }
  }

  void _onResetEvent(ResetEvent event, Emitter<AgeEstimateState> emit) {
    emit(AgeInitial());
  }

  String? validateName(name) {
    return UtilValidator.validate(
      name,
      type: ValidateType.name,
    );
  }
}
