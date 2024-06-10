import 'package:flutter/material.dart';
import 'package:pbl5/models/user/user.dart';
import 'package:pbl5/services/api_models/api_page_response/api_page_response.dart';
import 'package:pbl5/services/service_repositories/search_repository.dart';
import 'package:pbl5/shared_customization/extensions/api_page_response_ext.dart';
import 'package:pbl5/shared_customization/helpers/utilizations/dio_parse_error.dart';
import 'package:pbl5/view_models/base_view_model.dart';

class SearchViewModel extends BaseViewModel {
  ApiPageResponse<User>? searchData;
  final SearchRepository _searchRepo;
  final TextEditingController searchController = TextEditingController();

  SearchViewModel({required SearchRepository searchRepo})
      : _searchRepo = searchRepo;

  Future<void> searchCompanies({
    String query = '',
    int page = 1,
    VoidCallback? onSuccess,
    Function(String)? onFailure,
  }) async {
    try {
      var response =
          await _searchRepo.searchCompanies(query: query, page: page);
      searchData = searchData.insertPage(response);
      debugPrint('Search Result: ${searchData?.data}');
      onSuccess?.call();
      updateUI();
    } catch (error) {
      debugPrint(error.toString());
      onFailure?.call(parseError(error));
    }
    updateUI();
  }
}
