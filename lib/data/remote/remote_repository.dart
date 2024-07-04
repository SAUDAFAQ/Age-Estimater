import 'package:age_estimater/data/model/age_model.dart';

abstract class RemoteRepository {
  Future<AgeEstimateModel> getAgeEstimate(String name);
}