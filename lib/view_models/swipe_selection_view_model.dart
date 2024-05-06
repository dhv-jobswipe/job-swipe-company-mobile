import 'package:flutter/material.dart';
import 'package:pbl5/models/company/company.dart';
import 'package:pbl5/services/service_repositories/recommendation_predict_repository.dart';
import 'package:pbl5/view_models/base_view_model.dart';

class SwipeSelectionViewModel extends BaseViewModel {
  final RecommendationPredictRepository recPredictRepo;

  List<Company>? companies;

  SwipeSelectionViewModel({required this.recPredictRepo});

  Future<void> getRecommendedCompanies({
    VoidCallback? onSuccess,
    Function(String)? onFailure,
  }) async {
    try {
      companies = (await recPredictRepo.getRecommendedCompanies()).data;
      debugPrint('Companies: $companies');
      updateUI();
      onSuccess?.call();
    } on Exception catch (error) {
      onFailure?.call(error.toString());
    }
  }
}
