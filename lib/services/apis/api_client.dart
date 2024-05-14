import 'package:dio/dio.dart';
import 'package:pbl5/models/account/account.dart';
import 'package:pbl5/models/application_position/application_position.dart';
import 'package:pbl5/models/company/company.dart';
import 'package:pbl5/models/conversation/conversation.dart';
import 'package:pbl5/models/language/language.dart';
import 'package:pbl5/models/message/message.dart';
import 'package:pbl5/models/notification_data/notification_data.dart';
import 'package:pbl5/models/skill/skill.dart';
import 'package:pbl5/models/system_roles_response/system_roles_response.dart';
import 'package:pbl5/models/user/user.dart';
import 'package:pbl5/models/user_awards/user_awards.dart';
import 'package:pbl5/models/user_educations/user_educations.dart';
import 'package:pbl5/models/user_experiences/user_experiences.dart';
import 'package:pbl5/screens/pair/pair.dart';
import 'package:pbl5/services/api_models/api_page_response/api_page_response.dart';
import 'package:retrofit/retrofit.dart';

import '/models/credential/credential.dart';
import '../api_models/api_response/api_response.dart';

part 'api_client.g.dart';

//git commit -m "PBL-627 <message>"
//git commit -m "PBL-696 <message>"
//git commit -m "PBL-539 <message>"
@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

//git commit -m "PBL-541 <message>"
//git commit -m "PBL-540 <message>"
  //git commit -m "PBL-577 <message>"
  //git commit -m "PBL-535 <message>"
  //git commit -m "PBL-554 <message>"

  ///
  /// Authentication
  ///
  @POST('/auth/login')
  Future<ApiResponse<Credential>> login(@Body() Map<String, dynamic> body);

  @POST('/auth/user-register')
  Future<ApiResponse<User>> register(@Body() Map<String, dynamic> body);

  @POST('/auth/logout')
  Future<ApiResponse> logout();

  @POST('/auth/refresh-token')
  Future<ApiResponse<Credential>> refreshToken(
      @Body() Map<String, dynamic> body);

  @POST('/auth/forgot-password')
  Future<ApiResponse> forgotPassword(@Body() Map<String, dynamic> body);

  @POST('/auth/reset-password')
  Future<ApiResponse> resetPassword(@Body() Map<String, dynamic> body);

  @GET('/auth/account')
  Future<ApiResponse<Account>> getAccount();

  @GET('/auth/account/{account_id}')
  Future<ApiResponse<Account>> getAccountById(@Path("account_id") String id);

  ///
  /// User
  ///
  @GET('/profile/user')
  Future<ApiResponse<User>> getProfile();

  @GET('/profile/user')
  Future<ApiResponse<User>> getProfileById(@Query("user_id") String id);

  @PATCH('/profile/user/avatar')
  Future<ApiResponse> updateAvatar(@Body() FormData body);

  @PATCH('/profile/user?type=basic_info')
  Future<ApiResponse<User>> updateBasicInfo(@Body() Map<String, dynamic> body);

  @PATCH('/profile/user?type=education')
  Future<ApiResponse<User>> updateEducation(@Body() List<UserEducations> body);

  @POST('/profile/user?type=education')
  Future<ApiResponse<User>> insertEducation(@Body() List<UserEducations> body);

  @DELETE('/profile/user?type=education')
  Future<ApiResponse> deleteEducation(@Body() List<String> body);

  @PATCH('/profile/user?type=experience')
  Future<ApiResponse<User>> updateExperience(
      @Body() List<UserExperiences> body);

  @POST('/profile/user?type=experience')
  Future<ApiResponse<User>> insertExperience(
      @Body() List<UserExperiences> body);

  @DELETE('/profile/user?type=experience')
  Future<ApiResponse> deleteExperience(@Body() List<String> body);

  @PATCH('/profile/user?type=award')
  Future<ApiResponse<User>> updateAward(@Body() List<UserAwards> body);

  @POST('/profile/user?type=award')
  Future<ApiResponse<User>> insertAward(@Body() List<UserAwards> body);

  @DELETE('/profile/user?type=award')
  Future<ApiResponse> deleteAward(@Body() List<String> body);

  ///
  /// Application position
  ///
  @PATCH('/account/application-positions')
  Future<ApiResponse<List<ApplicationPosition>>> updateApplyPositions(
      @Body() List<ApplicationPosition> body);

  @DELETE('/account/application-positions')
  Future<ApiResponse> deleteApplyPositions(@Body() List<String> body);

  @POST('/account/application-positions')
  Future<ApiResponse<List<ApplicationPosition>>> insertApplyPositions(
      @Body() List<ApplicationPosition> body);

  ///
  /// Skill
  ///
  @PATCH('/account/application-positions/{application_position_id}')
  Future<ApiResponse<List<Skill>>> updateSkills(
    @Path("application_position_id") String applicationPositionId,
    @Body() List<Skill> body,
  );

  @DELETE('/account/application-positions')
  Future<ApiResponse> deleteSkills(
    @Query("application_position_id") String applicationPositionId,
    @Body() List<String> body,
  );

  ///
  /// Language
  ///
  @PATCH('/account/languages')
  Future<ApiResponse<List<Language>>> updateLanguages(
      @Body() List<Language> body);

  @DELETE('/account/languages')
  Future<ApiResponse> deleteLanguage(@Body() List<String> body);

  @POST('/account/languages')
  Future<ApiResponse<List<Language>>> insertLanguages(
      @Body() List<Language> body);

  ///
  /// Company
  ///
  @GET('/profile/company')
  Future<ApiResponse<Company>> getCompanyProfile();

  @PATCH('/profile/company/avatar')
  Future<ApiResponse> updateCompanyAvatar(@Body() FormData body);

  @PATCH('/profile/company')
  Future<ApiResponse<Company>> updateCompanyBasicInfo(
      @Body() Map<String, dynamic> body);

  ///
  /// System constant
  ///
  @GET('/constants/system-roles')
  Future<SystemRolesResponse> getSystemRoles();

  @GET('/constants?is_prefix=true')
  Future<ApiResponse<List<SystemConstant>>> getSystemConstantsByPrefix(
      @Query("constant_type") String prefix);

  @GET('/constants')
  Future<ApiResponse<SystemConstant>> getSystemConstantByType(
      @Query("constant_type") String type);

  @GET('/constants/types')
  Future<ApiResponse<List<String>>> getAllSystemTypes();

  @GET('/constants/{id}')
  Future<ApiResponse<SystemConstant>> getSystemConstantById(
      @Path("id") String id);

  ///
  /// Notification
  ///
  @GET('/notifications')
  Future<ApiPageResponse<NotificationData>> getNotifications({
    @Query('page') int page = 1,
    @Query('paging') int paging = 15,
  });

  @GET("/notifications")
  Future<ApiResponse<NotificationData>> getNotificationById(
      @Query("notification_id") String notificationId);

  @GET("/notifications/unread-count")
  Future<ApiResponse> getUnreadNotificationCount();

  @PATCH("/notifications")
  Future<ApiResponse> markAsRead(
      @Query("notification_id") String notificationId);

  @PATCH("/notifications?is_all=true")
  Future<ApiResponse> markAllAsRead();

  ///
  /// Conversation & Message
  ///
  @GET("/chat/conversations")
  Future<ApiPageResponse<Conversation>> getConversations({
    @Query('page') int page = 1,
    @Query('paging') int paging = 15,
  });

  @GET("/chat/conversations")
  Future<ApiResponse<Conversation>> getConversationById(
      @Query("conversation_id") String conversationId);

  @GET("/chat/conversations/unread-count")
  Future<ApiResponse> getUnreadMessageCount(
      @Query("conversation_id") String conversationId);

  @GET("/chat/messages")
  Future<ApiPageResponse<Message>> getMessages(
    @Query('conversation_id') String conversationId, {
    @Query('page') int page = 1,
    @Query('paging') int paging = 25,
  });

  @GET("/chat/messages")
  Future<ApiResponse<Message>> getMessageById(
      @Query("conversation_id") String conversationId,
      @Query("message_id") String messageId);

  @POST("/chat/messages")
  Future<ApiResponse<List<Message>>> sendMessage(
      @Query("conversation_id") String conversationId, @Body() FormData body);

  @PATCH("/chat/messages")
  Future<ApiResponse> markAsReadMessage(
      @Query("conversation_id") String conversationId,
      @Query("message_id") String messageId);

  @PATCH("/chat/messages?is_all=true")
  Future<ApiResponse> markAllAsReadMessage(
      @Query("conversation_id") String conversationId);

  ///
  /// pair
  ///
  @GET('/matched-pairs')
  Future<ApiResponse<Pair>> getMatchById(@Query("match_id") String pairId);

  @POST('/matched-pairs/request')
  Future<ApiResponse<Pair>> requestMatchedPair(
      @Query("requested_account_id") String requestedAccountId);

  @POST('/matched-pairs/accept')
  Future<ApiResponse<Pair>> acceptPair(@Query("match_id") String pairId);

  @POST('/matched-pairs/reject')
  Future<ApiResponse<Pair>> rejectPair(@Query("match_id") String pairId);

  ///
  ///
  ///
}
