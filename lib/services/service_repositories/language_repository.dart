import 'package:pbl5/models/language/language.dart';
import 'package:pbl5/services/api_models/api_response/api_response.dart';
import 'package:pbl5/services/apis/api_client.dart';

//git commit -m "PBL-576 <message>"
//git commit -m "PBL-577 <message>"
//git commit -m "PBL-554 <message>"
//git commit -m "PBL-555 <message>"
//git commit -m "PBL-550 <message>"
//git commit -m "PBL-551 <message>"
class LanguageRepository {
  final ApiClient apis;

  const LanguageRepository({required this.apis});

  Future<ApiResponse<List<Language>>> updateLanguages(
          {required List<Language> languages}) =>
      apis.updateLanguages(languages);

  Future<ApiResponse> deleteLanguage({required List<String> ids}) =>
      apis.deleteLanguage(ids);

  Future<ApiResponse<List<Language>>> insertLanguages(
          {required List<Language> languages}) =>
      apis.insertLanguages(languages);
}
