import 'package:age_estimater/data/remote/remote_age_estimate_repository.dart';
import 'package:age_estimater/domain/repository/age_estimate_repository/age_estimate_repository.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void setupLocator() {
  sl.registerLazySingleton<AgeEstimateRepository>(() => RemoteAgeEstimateRepository());
}
