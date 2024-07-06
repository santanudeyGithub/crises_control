import 'package:crises_control/src/companies/models/company.dart';
import 'package:crises_control/src/core/models/audio_message.dart';
import 'package:crises_control/src/core/models/authentication_credentials.dart';
import 'package:crises_control/src/core/models/communication_models/cascading_plan_response.dart';
import 'package:crises_control/src/core/models/communication_models/company_comms_response.dart';
import 'package:crises_control/src/core/models/communication_models/message_response.dart';
import 'package:crises_control/src/core/models/communication_models/selected_communication.dart';
import 'package:crises_control/src/core/models/list_models/affected_locations.dart';
import 'package:crises_control/src/core/models/list_models/departments.dart';
import 'package:crises_control/src/core/models/list_models/groups.dart';
import 'package:crises_control/src/core/models/list_models/locations.dart';
import 'package:crises_control/src/core/models/media_attachments.dart';
import 'package:crises_control/src/core/presentation/pages/lists/user_list_page.dart';
import 'package:crises_control/src/incident/models/all_active_incident.dart';
import 'package:crises_control/src/incident/models/incident.dart';
import 'package:crises_control/src/incident/models/incident_detail.dart';
import 'package:crises_control/src/incident/models/incident_message.dart';
import 'package:crises_control/src/ping/models/ping.dart';

//This file contains all the page arguments

//Login
class LoginPageArguments {
  LoginPageArguments(this.customerId, this.authenticationCredentials);

  final String customerId;
  final AuthenticationCredentials authenticationCredentials;
}

//Forgot password Arguments
class ForgotPasswordPageArguments {
  ForgotPasswordPageArguments(this.customerId, this.email, this.authenticationCredentials);
final String email;
  final String customerId;
  final AuthenticationCredentials authenticationCredentials;
}
class LoginBiometricPageArguments {
  LoginBiometricPageArguments({
    required this.authenticationCredentialsList,
  });
  final List<AuthenticationCredentials> authenticationCredentialsList;
}

class LoginFirstTimePageArguments {
  LoginFirstTimePageArguments({
    required this.customerId,
    required this.userName,
    required this.rememberMe,
  });
  final String customerId;
  final String userName;
  final bool rememberMe;
}

class SOSPageArguments {
  SOSPageArguments({
    required this.UserId,
    required this.callmethod,
  });
  final int UserId;
  final int callmethod;
}


class LoginFirstOtpPageArguments {
  LoginFirstOtpPageArguments({
    required this.customerId,
    required this.oldPassword,
    required this.newPassword,
    required this.userName,
    required this.rememberMe,
  });
  final String customerId;
  final String oldPassword;
  final String newPassword;
  final String userName;
  final bool rememberMe;
}

class CompaniesPageArguments {
  CompaniesPageArguments(this.companies);
  final List<Company> companies;
}

//Ping
class PingDetailsPageArgument {
  PingDetailsPageArgument(this.selectedPing);
  final PingData selectedPing;
}

class MessageRepliesArguments {
  MessageRepliesArguments(this.parentId);
  final int parentId;
}

//Incident
class IncidentsPageArgument {
  IncidentsPageArgument(this.isAwaitingLaunchIncident);
  final bool isAwaitingLaunchIncident;
}

class IncidentMessagesPageArguments {
  IncidentMessagesPageArguments(this.incident);
  final AllActiveIncidentData incident;
}

class MessageDetailsPageArguments {
  MessageDetailsPageArguments(this.incident, this.incidentMessage);

  final Incident incident;
  final IncidentMessage incidentMessage;
}

class LaunchIncidentPageArguments {
  LaunchIncidentPageArguments(this.incidentId);
  final int incidentId;
}

class MediaAssetListViewArguments {
  MediaAssetListViewArguments(this.type, this.mediaAttachments);
  final MediaAttachmentType type;
  final List<MediaAttachment> mediaAttachments;
}

class PingMediaAttachmentPageArguments {
  PingMediaAttachmentPageArguments(this.mediaAttachments);
  final List<MediaAttachment> mediaAttachments;
}

class NewPingPageArguments {
  NewPingPageArguments({this.selectedUsers = const []});
  final List<SelectedUser> selectedUsers;
}

//Media
class RecordAudioPageArguments {
  RecordAudioPageArguments(this.path);
  final String path;
}

class WebViewPageArguments {
  WebViewPageArguments(this.url, this.title);
  final String title;
  final String url;
}

class PhotoViewerPageArguments {
  PhotoViewerPageArguments(this.path);
  final String path;
}

class PdfViewerPageArguments {
  PdfViewerPageArguments(this.url);
  final String url;
}

//Lists
enum LocationListType { toNotify, impacted, affected }

class LocationListPageArguments {
  LocationListPageArguments(this.selectedLocations, this.locationListType);
  final LocationListType locationListType;
  final List<LocationsData> selectedLocations;
}

class AffectedLocationListPageArguments {
  AffectedLocationListPageArguments(this.selectedLocations);
  final List<AffectedLocationsData> selectedLocations;
}

class GroupListPageArguments {
  GroupListPageArguments(this.selectedGroups);
  final List<GroupData> selectedGroups;
}

class UserListPageArguments {
  UserListPageArguments(
    this.isIncidentManagerList,
    this.selectedUsersId,
  );
  final bool isIncidentManagerList;
  final List<SelectedUser> selectedUsersId;
}

class SocialIntergrationsListPageArguments {
  SocialIntergrationsListPageArguments(this.selectedSocialIntergrations);
  final List<String> selectedSocialIntergrations;
}

class DepartmentListPageArguments {
  DepartmentListPageArguments(this.selectedDepartments);
  final List<DepartmentsData> selectedDepartments;
}

class CommunicationPrefencesListPageArguments {
  CommunicationPrefencesListPageArguments(
    this.allMessageMethods,
    this.selectedMessageMethods,
    this.allCascadingPlans,
  );
  final List<MessageMethod> allMessageMethods;
  final List<SelectedCommunication> selectedMessageMethods;
  final List<CascadingPlan> allCascadingPlans;
}

class MessageEditorPageArguments {
  MessageEditorPageArguments(this.message, this.incidentMessages);
  final String message;
  final List<IncidentMessages> incidentMessages;
}

class AcknowledgeOptionsListPageArguments {
  AcknowledgeOptionsListPageArguments(
    this.selectedAcknowledgeOptions,
    this.messageType,
    this.status,
  );
  final String messageType;
  final int status;
  final List<AcknowledgeOption> selectedAcknowledgeOptions;
}

class MessageRecipientsListPageArguments {
  MessageRecipientsListPageArguments(this.messageId);
  final int messageId;
}

class AudioMessagesListPageArguments {
  AudioMessagesListPageArguments(this.selectedAudioMessages);
  final List<AudioMessage> selectedAudioMessages;
}

