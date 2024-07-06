// ignore_for_file: constant_identifier_names, deprecated_member_use

import 'package:crises_control/src/core/presentation/styles/text/material_colors_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class RestServiceConstants {
  /// https://
  static const https = 'https://';

  static const genericApiUrl =
      'https://apps.crises-control.com/CompanyApiV2/Api/';

  ///the crises control development apps API base URL
  ///https://devapps.crises-control.com/CrisesControlCore/api
  static const devappsUrl =
      'https://devapps.crises-control.com/CrisesControlCore/api';

  ///devapps.crises-control.com
  static const devappsbaseUrl = 'devapps.crises-control.com';

  /// /CrisesControlCore/api/'
  static const coreApiPath = 'CrisesControlCore/api';

  /// https://devapps.crises-control.com/CrisesControlCore/api/App
  static const devappsAppUrl =
      'https://devapps.crises-control.com/CrisesControlCore/api/App';

  ///the crises control development authorisation API base URL
  static const devauthUrl = 'https://devauth.crises-control.com/';

  //For Dev Auth
  static const clientId = '2963ebbf-2cec-4baf-aa97-df3bdb08fe07';
  static const clientSecret = 'b4134e92-b465-4d8d-b339-dd0ff6b31a45';
}

class RestContentType {
  static const applicationJson = 'application/json';
  static const applicationFormUrlEncoded = 'application/x-www-form-urlencoded';
}

class ApiContrtollers {
  //connect
  static const connect = 'connect';
  //app
  static const app = 'App';
  //company
  static const company = 'Company';
  static const companyParameters = 'CompanyParameters';

  //user
  static const user = 'User';

  //Messaging
  static const messaging = 'Messaging';

  //Reporting
  static const reporting = 'Reporting';
}

class ApiEndPoints {
  //Company
  static const getCompanyApi = 'GetCompanyApi';

  /// /Login
  static const verifyLogin = 'VerifyLogin';
  static const sendPasswordOTP = 'SendPasswordOTP';

  /// /Location
  static const location = 'Location';

  // /Messaging
  static const messaging = 'Messaging';

  /// /Department
  static const department = 'Department';

  /// /User
  static const user = 'User';

  /// Group
  static const group = 'Group';

  /// getMessages
  static const getMessages = 'GetMessages';

  /// /Incident
  static const incident = 'Incident';
  static const getAllCompanyIncident = 'GetAllCompanyIncident';
  static const getAllActiveCompanyIncident = 'GetAllActiveCompanyIncident';
  static const getCompanyIncidentById = 'GetCompanyIncidentById';

  /// /App
  static const captureUserLocation = 'CaptureUserLocation';

  /// /Launch
  static const getCompanyComms = 'GetCompanyComms';
  static const getCascading = 'GetCascading';
  static const getSocialIntegration = 'GetSocialIntegration';
}

class ObjectMappingIds {
  static const objectMappingIdLocation = 9;
  static const objectMappingIdGroup = 10;
  static const objectMappingIdDepartment = 100;
}

class AppApiEndPoints {
  /// /AppHome
  static const appHome = 'AppHome';

  /// CCPhoneNumbers
  static const ccPhoneNumbers = 'CCPhoneNumbers';
}

class CrisesControlVersions {
  static const apiVersion = '5.7.0.0';
  static const appVersion = 'Version  6.0.0.0';
}

class AudioAssetsConstants {
  static const audioPath = 'audios/';
  static const audioAssetsExtension = '.mp3';
  static const beeping_1 = 'beeping_1';
  static const beeping_2 = 'beeping_2';
  static const beeping_3 = 'beeping_3';
  static const beeping_4 = 'beeping_4';
  static const beeping = 'beeping';
  static const bell_chime = 'bell_chime';
  static const jetta_horn = 'jetta_horn';
  static const ring1 = 'ring1';
  static const ring2 = 'ring2';
  static const ring3 = 'ring3';
  static const sms_alert = 'sms_alert';
  static const space_siren = 'space_siren';
  static const whooping = 'whooping';
}

class UIConstants {
  static const double defaultCornerRadius = 8.0;
  static const double buttonTextSize = 18;
}

class SharedPrefencesKey {
  static const loggedIn = 'loggedIn';
}

class Keys {
  static const encryptionPassPhrase = '!hI5rr)aBIGsjG*9ORkE3tvCT%zcWaVB';
}

class FrontEndConstants {
  static const forgotCustomerIdDescription =
      "Any email that you received from Crises Control will have your Customer ID. If you don't have any email from Crises Control, contact your company administrator to get your Customer ID.";
  static const defaultErrorMessage =
      'There was a problem proccessing your request';
  static const emailPlaceholder = 'email';
  static const emailExamplePlaceholder = 'email@company.com';
  static const passwordPlaceholder = 'password';
  static const loginToConnect = 'LOGIN TO CONNECT';
  static const canNotBeEmpty = "Can't be empty.";
  static const invalidEmailMessage = 'Please check your email is correct';

  static const int debouncerDuration = 500;
  static const double googleMapDefaultZoomLevel = 14.4746;
}

class AppConstants {
  static const Iterable<Locale> supportedLocales = [
    Locale('en', ''),
    Locale('de', ''),
    Locale('it', ''),
    Locale('pl', ''),
    Locale('fr', ''),
    Locale('es', '')
  ];

  static const Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates =
      [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  static ThemeData themeData = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primarySwatch: generateMaterialColor(Palette.primary),
    errorColor: generateMaterialColor(Palette.primaryRedColor),
    textTheme: const TextTheme(
      caption: TextStyle(color: Palette.primary),
    ),
    iconTheme: const IconThemeData(color: Palette.primary),
  );
}

class MessageConstants {
  static const pingMessageLength = 200;
  static const incidentMessageLength = 200;
  static const incidentJournalLength = 500;
}

class CrisesControlUrls {
  static const portal = 'https://www.crises-control.com';
  static const logo =
      'https://www.crises-control.com/wp-content/uploads/2022/01/crises-control-logo-small.png';

  static const whatsNewurl = 'https://www.crises-control.com/whats-new-app/';
}

class SupportConstants {
  static const supportPhoneNumber = "+44(0)2085841385";
  static const supportEmail = "support@crises-control.com";
}

class MockData {
  static const pdfUrl = 'https://www.africau.edu/images/default/sample.pdf';
}

class SecureStorageKeys {
  static const crisesControlAccessTokenKey = 'crises_control_access_token';
  static const azureAdAccessTokenKey = 'azure_ad_access_token';
  static const oktaAccessTokenKey = 'okta_access_token';
}

class DateFormats {
  static const standardDateFormat = 'dd/MM/yyyy hh:mm';
}

class GoogleMaps {
  static const String googlePlacesApiAutoCompletePath =
      "https://maps.googleapis.com/maps/api/place/autocomplete/json?key=%s&input=%s";
  static const String googlePlacesApiDetail =
      "https://maps.googleapis.com/maps/api/place/details/json?key=%s&place_id=%s";
  static const String googlePlacesApiGeocode =
      "https://maps.googleapis.com/maps/api/geocode/json?key=%s&latlng=%s";
  static const String googlePlacesApiKey =
      "AIzaSyAesyplGOZcVGJEJYvPhiSpVvSoGs5xhE0";
  // static static readonly Position DefaultPinPosition = new Position(51.5074, 0.1278);
  static const double defaultMapSpanRadius = 1;
  static const double mileToKm = 1.60934;
}

class CompanyParamKeys {
  static const String aosEnabled = "SOS_ENABLED";
  static const String attachmentPhotoCompressionRate =
      "ATTACHMENT_PHOTO_COMPRESSION_RATE";
  static const String attachmentVideoQuality = "ATTACHMENT_VIDEO_QUALITY";
  static const String attachmentMaxSize = "ATTACHMENT_MAX_SIZE";
  static const String allowOffDuty = "ALLOW_OFF_DUTY";
  static const String allowOffDutyChannelChangeUser =
      "ALLOW_OFF_DUTY_CHANNEL_CHANGE_USER";
  static const String messagePriorityLimit = "MESSAGE_PRIORITY_LIMIT";
  static const String allowChangePriorityUser = "ALLOW_CHANGE_PRIORITY_USER";
  static const String allowChangeChannelUser = "ALLOW_CHANGE_CHANNEL_USER";
  static const String allowChannelPrioritySetup =
      "ALLOW_CHANNEL_PRIORITY_SETUP";
  static const String allowChannelSeveritySetup =
      "ALLOW_CHANNEL_SEVERITY_SETUP";
  static const String keyContactRequiredForIncident =
      "KEY_CONTACT_REQUIRED_FOR_INCIDENT";
  static const String showUsersPersonnelInfo = "SHOW_USERS_PERSONNEL_INFO";
  static const String forceCcChannelsApp = "FORCE_CC_CHANNELS_APP";
  static const String defaultReplyChannel = "DEFAULT_REPLY_CHANNEL";
  static const String maxMessageCharLimit = "MAX_MESSAGE_CHAR_LIMIT";
  static const String allowSocialPosting = "ALLOW_SOCIAL_POSTING";
  static const String allowKeyholderNomination = "ALLOW_KEYHOLDER_NOMINATION";
  static const String trackingDistanceFilter = "TRACKING_DISTANCE_FILTER";
  static const String trackingAccuracy = "TRACKING_ACCURACY";
  static const String trackingInterval = "TRACKING_INTERVAL";
  static const String phoneContactLabel = "PHONE_CONTACT_LABEL";
  static const String allowTrackMeDuringTravel = "ALLOW_TRACK_ME_DURING_TRAVEL";
  static const String activeIsop = "ACTIVE_ISOP";
}

class SecItemKeys {
  static const String pingAudioMessage = "Ping_Audio_Message";
  static const String newIncident = "New_Incident";
  static const String incidents = "Incidents";
  static const String ping = "Ping";
  static const String incidentAudioMessage = "Incident_Audio_Message";
  static const String allowIncidentSimulation = "Allow_Incident_Simulation";
  static const String incidentAckOptions = "Incident_AckOptions";
  static const String incidentReplyMessage = "Incident_Reply_Message";
  static const String pingReplyMessage = "Ping_Reply_Message";
  static const String incidentReplyAllMessage = "Incident_ReplyAll_Message";
  static const String pingReplyAllMessage = "Ping_ReplyAll_Message";
  static const String newPing = "New_Ping";
  static const String awtLaunchIncidents = "AwtLaunch_Incidents";
  static const String activeIncidentTask = "Active_Incident_Task";
  static const String incidentReNotify = "Incident_ReNotify";
  static const String incidentSendUpdate = "Incident_Send_Update";
  static const String incidentStartConference = "Incident_Start_Conference";
  static const String pingReNotify = "Ping_ReNotify";
  static const String pingStartConference = "Ping_Start_Conference";
  static const String pingUseCascading = "Ping_Use_Cascading";
  static const String incidentUseCascading = "Incident_Use_Cascading";
  static const String incidentMessageAttachment = "Incident_Message_Attachment";
  static const String pingMessageAttachment = "Ping_Message_Attachment";
  static const String pingAckOptions = "Ping_AckOptions";
  static const String btnAddAsset = "Btn_AddAsset";
  static const String allowTrackMeDuringTravel = "Allow_Track_Me_During_Travel";
}

class BackendConstants {
  static const int objectMappingIdLocation = 9;
  static const int objectMappingIdGroup = 10;
  static const int objectMappingIdDepartment = 100;

  static const String participantTypeGroup = "GROUP";
  static const String participantTypeDepartment = "DEPARTMENT";
  static const String participantTypeUser = "USER";

  static const int assetTypeIdPing = 3;
  static const int assetTypeIdIncident = 4;

  static const String messageTypePing = "Ping";
  static const String messageTypeIncident = "Incident";
  static const String messageTypeIncidentSeverity = "IncidentSeverity";

  static const String cacsadingPlanTypeAll = "ALL";
  static const String cacsadingPlanTypePing = "Ping";
  static const String cascadingPlanTypeIncident = "Incident";
}

class UserRoleString {
  static const String admin = "ADMIN";
  static const String keyHolder = "KEYHOLDER";
  static const String superAdmin = "SUPERADMIN";
}

class OnboardingContent {
  String image;
  String title;
  String description;
  //String titletwo;
  OnboardingContent({
    required this.image,
    required this.title,
    required this.description,
    //required this.titletwo
  });
}

List<OnboardingContent> contents = [
  OnboardingContent(
      title: 'Critical Event Management Software',
      //titletwo: '',
      image: 'assets/images/transputec.png',
      description:
          "We make your business compliant and ready for any critical event"
          "of a document or a typeface."),
  OnboardingContent(
      title: 'Critical Incident Management',
      //titletwo: '',
      image: 'assets/images/onboardingTwo.png',
      description:
          "Manage incident response plans, assign tasks and track progress in real-time."),
  OnboardingContent(
      title: 'Critical Task Management',
      // titletwo: '',
      image: 'assets/images/onboardingThree.png',
      description:
          "Stay on top of tasks, ensure seamless task management during critical situations."),
  OnboardingContent(
      title: 'Mass Notification',
      //  titletwo: '',
      image: 'assets/images/onboardingFour.png',
      description:
          "Send alerts and updates to employees, stakeholders, and partners globally.")
];
