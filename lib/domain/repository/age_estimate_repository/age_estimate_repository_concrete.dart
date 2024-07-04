import 'package:age_estimater/data/model/age_model.dart';
import 'package:age_estimater/data/remote/remote_repository.dart';
import 'package:age_estimater/domain/repository/age_estimate_repository/age_estimate_repository.dart';

class AgeEstimateRepositoryConcrete implements AgeEstimateRepository {
  final RemoteRepository remoteRepository;

  AgeEstimateRepositoryConcrete(this.remoteRepository);

  @override
  Future<AgeEstimateModel> getAgeEstimate(String name) async {
    return remoteRepository.getAgeEstimate(name);
  }
}
