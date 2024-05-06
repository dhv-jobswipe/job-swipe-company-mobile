import 'package:dio/dio.dart';
import 'package:pbl5/models/company/company.dart';
import 'package:retrofit/http.dart';

import '../api_models/api_response/api_response.dart';

part 'api_ai.g.dart';

@RestApi()
abstract class ApiAI {
  factory ApiAI(Dio dio, {String baseUrl}) = _ApiAI;

  @GET('/recommend/user')
  Future<ApiResponse<List<Company>>> getRecommendedCompanies();
}
