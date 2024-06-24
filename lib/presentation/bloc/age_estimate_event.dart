part of 'age_estimate_bloc.dart';

abstract class AgeEstimateEvent extends Equatable {
  const AgeEstimateEvent();

  @override
  List<Object> get props => [];
}

class GetAgeEvent extends AgeEstimateEvent {
  final String name;

  const GetAgeEvent(this.name);

  @override
  List<Object> get props => [name];
}

class ResetEvent extends AgeEstimateEvent {}
