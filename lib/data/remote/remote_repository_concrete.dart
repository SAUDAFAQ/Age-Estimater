import 'package:age_estimater/data/data_sources/http_manager.dart';
import 'package:age_estimater/data/model/age_model.dart';
import 'package:age_estimater/data/remote/remote_repository.dart';

class RemoteRepositoryConcrete implements RemoteRepository {
  final HttpManager httpManager;

  RemoteRepositoryConcrete(this.httpManager);

  @override
  Future<AgeEstimateModel> getAgeEstimate(String name) async {
    return httpManager.getAgeEstimate(name);
  }
}
