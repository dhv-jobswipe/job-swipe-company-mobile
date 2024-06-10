import 'package:pbl5/models/user/user.dart';
import 'package:pbl5/services/api_models/api_page_response/api_page_response.dart';
import 'package:pbl5/services/apis/api_client.dart';

class SearchRepository {
  final ApiClient apis;

  const SearchRepository({required this.apis});

  Future<ApiPageResponse<User>> searchCompanies(
          {String query = '', int page = 1, int paging = 25}) =>
      apis.searchUsers(query: query, page: page, paging: paging);
}
