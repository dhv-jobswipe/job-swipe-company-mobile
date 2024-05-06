import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:pbl5/models/app_data.dart';
import 'package:pbl5/services/apiAI/api_ai.dart';
import 'package:pbl5/services/apis/api_client.dart';
import 'package:pbl5/services/app_dio.dart';
import 'package:pbl5/services/service_repositories/authentication_repository.dart';
import 'package:pbl5/services/service_repositories/chat_repository.dart';
import 'package:pbl5/services/service_repositories/company_repository.dart';
import 'package:pbl5/services/service_repositories/notification_repository.dart';
import 'package:pbl5/services/service_repositories/recommendation_predict_repository.dart';
import 'package:pbl5/services/service_repositories/system_constant_repository.dart';
import 'package:pbl5/services/service_repositories/user_repository.dart';
import 'package:pbl5/shared_customization/helpers/utilizations/storages.dart';
import 'package:pbl5/view_models/app_notification_view_model.dart';
import 'package:pbl5/view_models/chat_view_model.dart';
import 'package:pbl5/view_models/conversation_view_model.dart';
import 'package:pbl5/view_models/forgot_password_view_model.dart';
import 'package:pbl5/view_models/integrated_auth_view_model.dart';
import 'package:pbl5/view_models/log_in_view_model.dart';
import 'package:pbl5/view_models/main_view_model.dart';
import 'package:pbl5/view_models/notification_view_model.dart';
import 'package:pbl5/view_models/profile_view_model.dart';
import 'package:pbl5/view_models/register_view_model.dart';
import 'package:pbl5/view_models/reset_password_view_model.dart';
import 'package:pbl5/view_models/swipe_selection_view_model.dart';

GetIt getIt = GetIt.instance;

Future<void> setupLocator() async {
  ///
  /// Other dependencies
  ///
  var storage = getIt
      .registerSingleton<CustomSharedPreferences>(CustomSharedPreferences());
  await storage.init();

  var apis = getIt.registerSingleton<ApiClient>(
      ApiClient(AppDio(), baseUrl: dotenv.env["BASE_URL"]!));

  var apiAI = getIt.registerSingleton<ApiAI>(
      ApiAI(AppDio(), baseUrl: dotenv.env["AI_URL"]!));

  getIt.registerLazySingleton<AppData>(() => AppData());

  ///
  /// Repositories
  ///
  var authRepo = getIt.registerSingleton<AuthenticationRepositoty>(
      AuthenticationRepositoty(apis: apis));

  var userRepo =
      getIt.registerSingleton<UserRepository>(UserRepository(apis: apis));

  var recPredictRepo = getIt.registerSingleton<RecommendationPredictRepository>(
      RecommendationPredictRepository(apiAI: apiAI));

  var notiRepo = getIt.registerSingleton<NotificationRepository>(
      NotificationRepository(apis: apis));

  var chatRepo =
      getIt.registerSingleton<ChatRepository>(ChatRepository(apis: apis));

  var systemConstantRepo = getIt.registerSingleton<SystemConstantRepository>(
      SystemConstantRepository(apis: apis));

  var companyRepo =
      getIt.registerSingleton<CompanyRepository>(CompanyRepository(apis: apis));

  ///
  /// View models
  ///
  getIt.registerLazySingleton<LogInViewModel>(() => LogInViewModel(
      authenticationRepositoty: authRepo, customSharedPreferences: storage));

  getIt.registerLazySingleton<RegisterViewModel>(
      () => RegisterViewModel(authenticationRepositoty: authRepo));

  getIt.registerLazySingleton<SwipeSelectionViewModel>(
      () => SwipeSelectionViewModel(recPredictRepo: recPredictRepo));

  getIt.registerLazySingleton<MainViewModel>(() => MainViewModel());

  getIt.registerLazySingleton<IntegratedAuthViewModel>(
      () => IntegratedAuthViewModel(authenticationRepositoty: authRepo));

  getIt.registerLazySingleton<ProfileViewModel>(() => ProfileViewModel(
        authRepositoty: authRepo,
        userRepository: userRepo,
        systemConstantRepository: systemConstantRepo,
        customSharedPreferences: storage,
        companyRepository: companyRepo,
      ));

  getIt.registerLazySingleton<NotificationViewModel>(
      () => NotificationViewModel(notificationRepository: notiRepo));

  getIt.registerLazySingleton<ChatViewModel>(
      () => ChatViewModel(chatRepository: chatRepo));

  getIt.registerLazySingleton<ConversationViewModel>(
      () => ConversationViewModel(chatRepository: chatRepo));

  getIt.registerLazySingleton<AppNotificationViewModel>(
      () => AppNotificationViewModel(
            notificationRepository: notiRepo,
            authenticationRepositoty: authRepo,
            sp: storage,
            notificationViewModel: getIt<NotificationViewModel>(),
            conversationViewModel: getIt<ConversationViewModel>(),
            chatViewModel: getIt.get<ChatViewModel>(),
          ));

  getIt.registerLazySingleton<ForgotPasswordViewModel>(
      () => ForgotPasswordViewModel(authenticationRepositoty: authRepo));

  getIt.registerLazySingleton<ResetPasswordViewModel>(
      () => ResetPasswordViewModel(authenticationRepositoty: authRepo));
}
