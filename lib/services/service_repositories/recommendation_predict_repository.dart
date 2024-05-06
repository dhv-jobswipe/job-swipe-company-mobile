import 'package:pbl5/models/company/company.dart';
import 'package:pbl5/services/apiAI/api_ai.dart';
import 'package:pbl5/services/api_models/api_response/api_response.dart';

class RecommendationPredictRepository {
  final ApiAI apiAI;

  const RecommendationPredictRepository({required this.apiAI});

  Future<ApiResponse<List<Company>>> getRecommendedCompanies() =>
      apiAI.getRecommendedCompanies();
}
