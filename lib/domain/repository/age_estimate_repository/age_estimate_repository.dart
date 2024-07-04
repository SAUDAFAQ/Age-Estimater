import 'package:age_estimater/data/model/age_model.dart';

abstract class AgeEstimateRepository {
  Future<AgeEstimateModel> getAgeEstimate(String name);
}
