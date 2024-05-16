import 'package:dio/dio.dart';
import 'package:pbl5/models/user/user.dart';
import 'package:pbl5/services/api_models/api_page_response/api_page_response.dart';
import 'package:retrofit/http.dart';

part 'api_ai.g.dart';

@RestApi()
abstract class ApiAI {
  factory ApiAI(Dio dio, {String baseUrl}) = _ApiAI;

  @GET('/recommend/company')
  Future<ApiPageResponse<User>> getRecommendedUsers(
      {@Query('page') int page = 1, @Query('paging') int paging = 10});
}
