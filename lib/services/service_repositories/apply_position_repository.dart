import 'package:pbl5/models/application_position/application_position.dart';
import 'package:pbl5/models/skill/skill.dart';
import 'package:pbl5/services/api_models/api_response/api_response.dart';
import 'package:pbl5/services/apis/api_client.dart';

//git commit -m "PBL-696 <message>"
class ApplyPositionRepository {
  final ApiClient apis;

  const ApplyPositionRepository({required this.apis});

  ///
  /// Application Position
  ///
  Future<ApiResponse<List<ApplicationPosition>>> updateApplyPositions(
          {required List<ApplicationPosition> applicationPositions}) =>
      apis.updateApplyPositions(applicationPositions);

  Future<ApiResponse> deleteApplyPositions({required List<String> ids}) =>
      apis.deleteApplyPositions(ids);

  Future<ApiResponse<List<ApplicationPosition>>> insertApplyPositions(
          {required List<ApplicationPosition> applicationPositions}) =>
      apis.insertApplyPositions(applicationPositions);

  ///
  /// Skill
  ///
  Future<ApiResponse<List<Skill>>> updateSkills({
    required String applicationPositionId,
    required List<Skill> skills,
  }) =>
      apis.updateSkills(applicationPositionId, skills);

  Future<ApiResponse> deleteSkills({
    required String applicationPositionId,
    required List<String> ids,
  }) =>
      apis.deleteSkills(applicationPositionId, ids);
}
