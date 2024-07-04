import 'package:age_estimater/data/model/age_model.dart';
import 'package:age_estimater/utils/const.dart';
import 'package:dio/dio.dart';

class HttpManager {
  late final Dio dio;

  HttpManager({required this.dio});

  Future<AgeEstimateModel> getAgeEstimate(String name) async {
    try {
      final response =
          await dio.get(Application.baseUrl, queryParameters: {'name': name});
      if (response.statusCode == 200) {
        return AgeEstimateModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load age estimate');
      }
    } catch (e) {
      throw Exception('Failed to load age estimate: $e');
    }
  }
}
