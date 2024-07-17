import 'package:age_estimater/data/data_sources/http_manager.dart';
import 'package:age_estimater/data/model/age_model.dart';
import 'package:age_estimater/domain/repository/age_estimate_repository/age_estimate_repository.dart';

class RemoteAgeEstimateRepository implements AgeEstimateRepository {
  final httpManager = HttpManager();

  RemoteAgeEstimateRepository();

  @override
  Future<AgeEstimateModel> getAgeEstimate(String name) async {
    return httpManager.getAgeEstimate(name);
  }
}
