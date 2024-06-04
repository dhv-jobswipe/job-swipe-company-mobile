import 'package:pbl5/models/pair/pair.dart';
import 'package:pbl5/models/user/user.dart';
import 'package:pbl5/services/apiAI/api_ai.dart';
import 'package:pbl5/services/api_models/api_page_response/api_page_response.dart';
import 'package:pbl5/services/api_models/api_response/api_response.dart';
import 'package:pbl5/services/apis/api_client.dart';

class SwipeSelectionRepository {
  final ApiClient apiClient;
  final ApiAI apiAI;

  const SwipeSelectionRepository(
      {required this.apiAI, required this.apiClient});

  Future<ApiPageResponse<User>> getRecommendedUsers(
          {int page = 1, int paging = 25}) =>
      apiAI.getRecommendedUsers(page: page, paging: paging);

  Future<ApiResponse<Pair>> requestMatchedPair(String userId) =>
      apiClient.requestMatchedPair(userId);

  Future<ApiResponse<Pair>> acceptPair(String pairId) =>
      apiClient.acceptPair(pairId);

  Future<ApiResponse<Pair>> rejectPair(String pairId) =>
      apiClient.rejectPair(pairId);

  Future<ApiResponse<Pair>> getMatchById(String pairId) =>
      apiClient.getMatchById(pairId);

  Future<ApiResponse<Pair>> getMatchByAccountId(String accountId) =>
      apiClient.getMatchByAccountId(accountId);

  Future<bool> sendInterviewInvitationMail({
    required String pairId,
    required String interviewTime,
    required String interviewPositionId,
  }) async {
    var res = await apiClient.sendInterviewInvitationMail(
      {
        "matching_id": pairId,
        "interview_time": interviewTime,
        "interview_position_id": interviewPositionId
      },
    );
    return res.status == "success";
  }
}
