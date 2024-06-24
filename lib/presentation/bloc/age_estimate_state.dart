part of 'age_estimate_bloc.dart';

abstract class AgeEstimateState extends Equatable {
  const AgeEstimateState();

  @override
  List<Object> get props => [];
}

class AgeInitial extends AgeEstimateState {}

class AgeLoading extends AgeEstimateState {}

class AgeLoaded extends AgeEstimateState {
  final int age;

  const AgeLoaded(this.age);

  @override
  List<Object> get props => [age];
}

class AgeError extends AgeEstimateState {
  final String message;

  const AgeError(this.message);

  @override
  List<Object> get props => [message];
}
