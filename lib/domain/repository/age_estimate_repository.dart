import 'package:age_estimater/data/model/age_model.dart';
import 'package:age_estimater/data/remote/remote_repository.dart';

class AgeEstimateRepository {
  final RemoteRepository remoteRepository;

  AgeEstimateRepository(this.remoteRepository);

  Future<AgeEstimateModel> getAgeEstimate(String name) async {
    return remoteRepository.getAgeEstimate(name);
  }
}
