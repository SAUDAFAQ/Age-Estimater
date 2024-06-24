import 'package:age_estimater/data/data_sources/http_manager.dart';
import 'package:age_estimater/data/model/age_model.dart';

class AgeEstimateRepository {
  final HttpManager httpManager;

  AgeEstimateRepository(this.httpManager);

  Future<AgeEstimateModel> getAgeEstimate(String name) async {
    return httpManager.getAgeEstimate(name);
  }
}
