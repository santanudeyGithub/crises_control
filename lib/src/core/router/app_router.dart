import 'package:crises_control/main.dart';
import 'package:crises_control/src/account/account_repository.dart';
import 'package:crises_control/src/account/cubit/account_cubit.dart';
import 'package:crises_control/src/account/views/account_page.dart';
import 'package:crises_control/src/companies/companies_page.dart';
import 'package:crises_control/src/core/cubit/list_cubit.dart';
import 'package:crises_control/src/core/message_recipients/cubit/message_recipients_cubit.dart';
import 'package:crises_control/src/core/message_recipients/views/message_recipients_page.dart';
import 'package:crises_control/src/core/pdf_viewer/cubit/pdf_cubit.dart';
import 'package:crises_control/src/core/pdf_viewer/pdf_page.dart';
import 'package:crises_control/src/core/presentation/pages/lists/acknowledge_options_list_page.dart';
import 'package:crises_control/src/core/presentation/pages/lists/affected_location_list_page.dart';
import 'package:crises_control/src/core/presentation/pages/lists/audio_messages_list_page.dart';
import 'package:crises_control/src/core/presentation/pages/lists/communication_preferences_list_page.dart';
import 'package:crises_control/src/core/presentation/pages/lists/department_list_page.dart';
import 'package:crises_control/src/core/presentation/pages/lists/group_list_page.dart';
import 'package:crises_control/src/core/presentation/pages/lists/location_list_page.dart';
import 'package:crises_control/src/core/presentation/pages/lists/social_intergrations_list_page.dart';
import 'package:crises_control/src/core/presentation/pages/lists/user_list_page.dart';
import 'package:crises_control/src/core/presentation/pages/media/photo_viewer_page.dart';
import 'package:crises_control/src/core/record_audio/Record_audio_page.dart';
import 'package:crises_control/src/core/record_audio/cubit/record_audio_cubit.dart';
import 'package:crises_control/src/core/repository/crises_control_core_repository.dart';
import 'package:crises_control/src/core/repository/google_maps_repository.dart';
import 'package:crises_control/src/core/router/page_arguments/page_arguments.dart';
import 'package:crises_control/src/core/router/route_constants.dart';
import 'package:crises_control/src/core/services/contact_service.dart';
import 'package:crises_control/src/core/services/file_service.dart';
import 'package:crises_control/src/core/services/location_service.dart';
import 'package:crises_control/src/core/services/page_cache_database.dart';
import 'package:crises_control/src/core/services/url_launcher_service.dart';
import 'package:crises_control/src/core/web_view/web_view_page.dart';
import 'package:crises_control/src/help/help.dart';
import 'package:crises_control/src/help/help_repository.dart';
import 'package:crises_control/src/help/view/feedback_page.dart';
import 'package:crises_control/src/home/home.dart';
import 'package:crises_control/src/home/repository/home_repository.dart';
import 'package:crises_control/src/home/services/home_rest_service.dart';
import 'package:crises_control/src/incident/cubits/incident_messages/incident_messages_cubit.dart';
import 'package:crises_control/src/incident/cubits/launch_incident/launch_incident_cubit.dart';
import 'package:crises_control/src/incident/cubits/launched_incidents/launched_incidents_cubit.dart';
import 'package:crises_control/src/incident/cubits/map_position_picker/map_position_picker_cubit.dart';
import 'package:crises_control/src/incident/cubits/message_editor_cubit/message_editor_cubit.dart';
import 'package:crises_control/src/incident/cubits/select_incident_cubit/select_incident_cubit.dart';
import 'package:crises_control/src/incident/incident.dart';
import 'package:crises_control/src/incident/incident_repository.dart';
import 'package:crises_control/src/incident/models/all_active_incident.dart';
import 'package:crises_control/src/incident/view/incident_media_assets_page.dart';
import 'package:crises_control/src/incident/view/incident_messages_page.dart';
import 'package:crises_control/src/incident/view/launch_incident_page.dart';
import 'package:crises_control/src/incident/view/map_position_picker_page.dart';
import 'package:crises_control/src/incident/view/message_details_page.dart';
import 'package:crises_control/src/incident/view/select_incident_page.dart';
import 'package:crises_control/src/incident/widgets/message_editor_page.dart';
import 'package:crises_control/src/login/bloc/customer_id_bloc/customer_id_bloc.dart';
import 'package:crises_control/src/login/bloc/login_bloc/login_bloc.dart';
import 'package:crises_control/src/login/cubit/login_first_otp_cubit/login_first_otp_cubit.dart';
import 'package:crises_control/src/login/repository/login_repository.dart';
import 'package:crises_control/src/login/services/authentication_database_service.dart';
import 'package:crises_control/src/login/services/biometric_service.dart';
import 'package:crises_control/src/login/view/pages/customer_id_page.dart';
import 'package:crises_control/src/login/view/pages/forgot_password.dart';
import 'package:crises_control/src/login/view/pages/login_biometric_page.dart';
import 'package:crises_control/src/login/view/pages/login_first_otp_page.dart';
import 'package:crises_control/src/login/view/pages/login_first_time_page.dart';
import 'package:crises_control/src/login/view/pages/login_page.dart';
import 'package:crises_control/src/ping/cubit/media_attachments_cubit.dart';
import 'package:crises_control/src/ping/cubit/new_ping_cubit.dart';
import 'package:crises_control/src/ping/cubit/ping_details/ping_details_cubit.dart';
import 'package:crises_control/src/ping/cubit/pings/pings_cubit.dart';
import 'package:crises_control/src/ping/ping.dart';
import 'package:crises_control/src/ping/repository/ping_repository.dart';
import 'package:crises_control/src/ping/view/new_ping_page.dart';
import 'package:crises_control/src/ping/view/ping_media_attachments_page.dart';
import 'package:crises_control/src/settings/cubit/settings_cubit.dart';
import 'package:crises_control/src/settings/cubit/siren_sound_cubit.dart';
import 'package:crises_control/src/settings/settings.dart';
import 'package:crises_control/src/settings/view/choose_language.dart';
import 'package:crises_control/src/settings/view/off_duty_page.dart';
import 'package:crises_control/src/settings/view/siren_sound_page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  AppRouter();

  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteConstants.customerIdPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => CustomerIdBloc(
              context.read<LoginRepository>(),
            ),
            child: const CustomerIdPage(),
          ),
        );
      case RouteConstants.splashScreen1:
        return MaterialPageRoute(builder: (_) => SplashScreen1());
      case RouteConstants.splashScreen2:
        return MaterialPageRoute(builder: (_) => SplashScreen2());
      case RouteConstants.splashScreen:
      // return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RouteConstants.onboardingScreen:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
      case RouteConstants.loginPage:
        final args = routeSettings.arguments as LoginPageArguments;
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return BlocProvider(
              create: (context) => LoginBloc(
                RepositoryProvider.of<LoginRepository>(context),
                RepositoryProvider.of<BiometricService>(context),
              ),
              child: LoginPage(
                customerId: args.customerId,
                authenticationCredentials: args.authenticationCredentials,
              ),
            );
          },
        );

      case RouteConstants.loginBiometricPage:
        final args = routeSettings.arguments as LoginBiometricPageArguments;
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return BlocProvider(
              create: (context) => LoginBloc(
                RepositoryProvider.of<LoginRepository>(context),
                RepositoryProvider.of<BiometricService>(context),
              ),
              child: LoginBiometricPage(
                authenticationCredentialsList:
                    args.authenticationCredentialsList,
              ),
            );
          },
        );
      case RouteConstants.forgotPasswordPage:
        final args = routeSettings.arguments as ForgotPasswordPageArguments;
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return BlocProvider(
              create: (context) => LoginBloc(
                RepositoryProvider.of<LoginRepository>(context),
                RepositoryProvider.of<BiometricService>(context),
              ),
              child: ForgotPassword(
                  authenticationCredentials: args.authenticationCredentials,
                  customerId: args.customerId,
                  email: args.email),
            );
          },
        );
      case RouteConstants.loginFirstTimePage:
        final args = routeSettings.arguments as LoginFirstTimePageArguments;
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return LoginFirstTimePage(
              customerId: args.customerId,
              userName: args.userName,
              rememberMe: args.rememberMe,
            );
          },
        );

      case RouteConstants.loginFirstOtpPage:
        final args = routeSettings.arguments as LoginFirstOtpPageArguments;
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return BlocProvider(
              create: (context) => LoginFirstOtpCubit(
                RepositoryProvider.of<LoginRepository>(context),
              ),
              child: LoginFirstOtpPage(
                customerId: args.customerId,
                oldPassword: args.oldPassword,
                newPassword: args.newPassword,
                userName: args.userName,
                rememberMe: args.rememberMe,
              ),
            );
          },
        );

      case RouteConstants.homePage:
        return MaterialPageRoute(
          builder: (_) => RepositoryProvider(
            create: (context) => HomeRepository(
              RepositoryProvider.of<HomeRestService>(context),
              RepositoryProvider.of<PageCacheDatabase>(context),
              RepositoryProvider.of<AuthenticationDatabaseService>(context),
              RepositoryProvider.of<ContactService>(context),
            ),
            child: BlocProvider(
              create: (context) => HomeCubit(
                RepositoryProvider.of<HomeRepository>(context),
              )..pageFirstLoad(),
              child: HomePage(),
            ),
          ),
          fullscreenDialog: true,
        );

      case RouteConstants.settingsPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SettingsCubit(),
            child: const SettingsPage(),
          ),
        );

      case RouteConstants.pingListPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => PingsCubit(
              RepositoryProvider.of<PingRepository>(context),
            )..loadAllPings(),
            child: const PingListPage(),
          ),
        );

      case RouteConstants.pingDetailsPage:
        final args = routeSettings.arguments as PingDetailsPageArgument;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => PingDetailsCubit(
              RepositoryProvider.of<PingRepository>(context),
              RepositoryProvider.of<CrisesControlCoreRepository>(context),
            )
              ..loadPingDetailsPage(args.selectedPing)
              ..getCommunicationMethods(),
            child: PingDetailsPage(selectedPing: args.selectedPing),
          ),
        );

      case RouteConstants.newPingPage:
        final args = routeSettings.arguments as NewPingPageArguments;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => NewPingCubit(
              RepositoryProvider.of<PingRepository>(context),
              RepositoryProvider.of<CrisesControlCoreRepository>(context),
            ),
            child: NewPingPage(
              selectedUsers: args.selectedUsers,
            ),
          ),
        );
      case RouteConstants.pingMediaAttachments:
        final args =
            routeSettings.arguments as PingMediaAttachmentPageArguments;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => MediaAttachmentsCubit(
              RepositoryProvider.of<PingRepository>(context),
            ),
            child: PingMediAttachmentPage(
              mediaAttachments: args.mediaAttachments,
            ),
          ),
        );
      case RouteConstants.incidentsPage:
        final args = routeSettings.arguments as IncidentsPageArgument;
        var status = args.isAwaitingLaunchIncident
            ? IncidentStatus.AwaitingLaunch
            : IncidentStatus.Launched;

        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => LaunchedIncidentsCubit(
              RepositoryProvider.of<IncidentRepository>(context),
            )..getAllActiveIncidents(status),
            child: IncidentsPage(
              isAwaitingIncidents: args.isAwaitingLaunchIncident,
            ),
          ),
        );

      case RouteConstants.incidentMessagesPage:
        final args = routeSettings.arguments as IncidentMessagesPageArguments;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => IncidentMessagesCubit(
              RepositoryProvider.of<IncidentRepository>(context),
            )..loadIncidentMessages(
                incidentId: args.incident.incidentActivationId,
              ),
            child: IncidentsMessagePage(
              incident: args.incident,
            ),
          ),
        );

      case RouteConstants.selectIncidentPage:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => SelectIncidentCubit(
              RepositoryProvider.of<IncidentRepository>(context),
            )..loadCompanyIncidents(),
            child: const SelectIncidentPage(),
          ),
        );

      case RouteConstants.launchIncidentPage:
        final args = routeSettings.arguments as LaunchIncidentPageArguments;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => LaunchIncidentCubit(
              RepositoryProvider.of<IncidentRepository>(context),
              RepositoryProvider.of<CrisesControlCoreRepository>(context),
            ),
            child: LaunchIncidentPage(incidentId: args.incidentId),
          ),
        );

      case RouteConstants.locationsListPage:
        final args = routeSettings.arguments as LocationListPageArguments;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ListCubit(
              RepositoryProvider.of<CrisesControlCoreRepository>(context),
            ),
            child: LocationListPage(
              selectedLocations: args.selectedLocations,
              locationListType: args.locationListType,
            ),
          ),
        );

      case RouteConstants.affectedLocationsListPage:
        final args =
            routeSettings.arguments as AffectedLocationListPageArguments;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ListCubit(
              RepositoryProvider.of<CrisesControlCoreRepository>(context),
            ),
            child: AffectedLocationListPage(
              selectedLocations: args.selectedLocations,
            ),
          ),
        );

      case RouteConstants.mapPositionPickerPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => MapPositionPickerCubit(
              RepositoryProvider.of<GoogleMapsRepository>(context),
              RepositoryProvider.of<LocationService>(context),
            ),
            child: const MapPositionPickerPage(),
          ),
        );

      case RouteConstants.groupListPage:
        final args = routeSettings.arguments as GroupListPageArguments;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ListCubit(
              RepositoryProvider.of<CrisesControlCoreRepository>(context),
            ),
            child: GroupListPage(
              selectedGroups: args.selectedGroups,
            ),
          ),
        );

      case RouteConstants.userListPage:
        final args = routeSettings.arguments as UserListPageArguments;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ListCubit(
              RepositoryProvider.of<CrisesControlCoreRepository>(context),
            ),
            child: UserListPage(
              isIncidentManagerList: args.isIncidentManagerList,
              selectedUsersId: args.selectedUsersId,
            ),
          ),
        );

      case RouteConstants.departmentListPage:
        final args = routeSettings.arguments as DepartmentListPageArguments;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ListCubit(
              RepositoryProvider.of<CrisesControlCoreRepository>(context),
            ),
            child: DepartmentListPage(
              selectedDepartments: args.selectedDepartments,
            ),
          ),
        );

      case RouteConstants.communicationPrefencesListPage:
        final args =
            routeSettings.arguments as CommunicationPrefencesListPageArguments;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ListCubit(
              RepositoryProvider.of<CrisesControlCoreRepository>(context),
            ),
            child: CommunicationPreferencesListPage(
              selectedCommunicationPreferences: args.selectedMessageMethods,
              allCommunicationPreferences: args.allMessageMethods,
              allCascadingPlans: args.allCascadingPlans,
            ),
          ),
        );

      case RouteConstants.messageEditorPage:
        final args = routeSettings.arguments as MessageEditorPageArguments;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => MessageEditorCubit(),
            child: MessageEditorPage(
              message: args.message,
              incidentMessage: args.incidentMessages,
            ),
          ),
        );
      case RouteConstants.acknowledgeOptionsListPage:
        final args =
            routeSettings.arguments as AcknowledgeOptionsListPageArguments;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ListCubit(
              RepositoryProvider.of<CrisesControlCoreRepository>(context),
            )..loadAcknowledgeOptions(
                messageType: args.messageType,
                status: args.status,
              ),
            child: AcknowledgeOptionsListPage(
              selectedAcknowledgeOptions: args.selectedAcknowledgeOptions,
            ),
          ),
        );
      case RouteConstants.audioMessagesListPage:
        final args = routeSettings.arguments as AudioMessagesListPageArguments;
        return MaterialPageRoute(
          builder: (_) => AudioMessagesListPage(
            selectedAudioMessages: args.selectedAudioMessages,
          ),
        );

      case RouteConstants.messageRecipientsPage:
        final args =
            routeSettings.arguments as MessageRecipientsListPageArguments;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => MessageRecipientsCubit(
              RepositoryProvider.of<UrlLauncherService>(context),
              RepositoryProvider.of<CrisesControlCoreRepository>(context),
            )..loadAllAcknowledgeStatus(messageId: args.messageId),
            child: const MessageRecipientsPage(),
          ),
        );

      case RouteConstants.pdfPage:
        final args = routeSettings.arguments as PdfViewerPageArguments;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                PdfCubit(RepositoryProvider.of<FileService>(context), args.url)
                  ..displayPDFromURL(),
            child: const PdfPage(),
          ),
        );

      case RouteConstants.photoViewerPage:
        final args = routeSettings.arguments as PhotoViewerPageArguments;
        return MaterialPageRoute(
          builder: (_) => PhotoViewerPage(path: args.path),
          fullscreenDialog: true,
        );

      case RouteConstants.recordAudioPage:
        final args = routeSettings.arguments as RecordAudioPageArguments;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => RecordAudioCubit(
              RepositoryProvider.of<FileService>(context),
            ),
            child: RecordAudioPage(path: args.path),
          ),
        );

      case RouteConstants.helpPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => HelpCubit(
              RepositoryProvider.of<UrlLauncherService>(context),
              RepositoryProvider.of<HelpRepository>(context),
            ),
            child: const HelpPage(),
          ),
        );
      case RouteConstants.webViewPage:
        final args = routeSettings.arguments as WebViewPageArguments;
        return MaterialPageRoute(
          builder: (_) => WebViewPage(
            url: args.url,
            title: args.title,
          ),
        );
      case RouteConstants.incidentMediaAssetsPage:
        return MaterialPageRoute(
          builder: (_) => const IncidentMediaAssetsPage(),
        );
      case RouteConstants.mediaAssetListView:
        final args = routeSettings.arguments as MediaAssetListViewArguments;
        return MaterialPageRoute(
          builder: (_) => MediaAssetListView(
            mediaAttachments: args.mediaAttachments,
            type: args.type,
          ),
        );
      case RouteConstants.messageDetailsPage:
        final args = routeSettings.arguments as MessageDetailsPageArguments;
        return MaterialPageRoute(
          builder: (_) => MessageDetailsPage(
            incident: args.incident,
            incidentMessage: args.incidentMessage,
          ),
        );
      case RouteConstants.companiesPage:
        final args = routeSettings.arguments as CompaniesPageArguments;
        return MaterialPageRoute(
          builder: (_) => CompaniesPage(
            companies: args.companies,
          ),
        );

      case RouteConstants.accountPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AccountCubit(
              RepositoryProvider.of<AccountRepository>(context),
            )..loadUsersDetails(),
            child: AccountPage(),
          ),
        );

      case RouteConstants.feedbackPage:
        return MaterialPageRoute(
          builder: (_) => const FeedbackPage(),
        );

      case RouteConstants.sirenSoundPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SirenSoundCubit(),
            child: SirenSoundPage(),
          ),
        );

      case RouteConstants.offDutySettingsPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                SirenSoundCubit(), /////please check siren sound 07/03/2024 this id off duty new page implement
            child: OffDutySettingsPage(),
          ),
        );

      case RouteConstants.chooseLanguage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                SirenSoundCubit(), /////please check siren sound 07/03/2024 this id chooseLanguage new page implement
            child: ChooseLanguage(),
          ),
        );

      case RouteConstants.SocialIntergrationsListPage:
        final args =
            routeSettings.arguments as SocialIntergrationsListPageArguments;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ListCubit(
              RepositoryProvider.of<CrisesControlCoreRepository>(context),
            )..loadAllSocialIntergrations(),
            child: SocialIntergrationsListPage(
              selectedSocialIntegrations: args.selectedSocialIntergrations,
            ),
          ),
        );

      default:
        return null;
    }
  }
}
