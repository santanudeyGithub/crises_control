// ignore_for_file: unused_field, unused_local_variable

import 'dart:io';

import 'package:crises_control/src/core/core.dart';
import 'package:crises_control/src/core/errors/cc_error.dart';
import 'package:crises_control/src/core/errors/exceptions.dart';
import 'package:crises_control/src/core/models/acknowledge_message_body.dart';
import 'package:crises_control/src/core/models/communication_models/message_response.dart';
import 'package:crises_control/src/core/models/communication_models/selected_communication.dart';
import 'package:crises_control/src/core/models/list_models/departments.dart';
import 'package:crises_control/src/core/models/list_models/groups.dart';
import 'package:crises_control/src/core/models/list_models/locations.dart';
import 'package:crises_control/src/core/models/media_attachments.dart';
import 'package:crises_control/src/core/models/message_reply_body.dart';
import 'package:crises_control/src/core/models/replies.dart';
import 'package:crises_control/src/core/presentation/pages/lists/user_list_page.dart';
import 'package:crises_control/src/core/services/crises_control_rest_service.dart';
import 'package:crises_control/src/core/services/page_cache_database.dart';
import 'package:crises_control/src/login/services/authentication_database_service.dart';
import 'package:crises_control/src/ping/models/ping.dart';
import 'package:crises_control/src/ping/models/ping_info.dart';
import 'package:crises_control/src/ping/models/ping_severity.dart';
import 'package:crises_control/src/ping/models/send_ping_body.dart';
import 'package:crises_control/src/ping/services/ping_rest_service.dart';
import 'package:dartz/dartz.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/models/list_models/request/request_models.dart';

enum ReplyType { all, sender, renotify }

class PingRepository {
  PingRepository(
    this._pingRestService,
    this._authenticationDatabaseService,
    this._crisesControlRestService,
    this._pageCacheDatabase,
  );
  final ImagePicker _picker = ImagePicker();
  final PingRestService _pingRestService;
  final AuthenticationDatabaseService _authenticationDatabaseService;
  final CrisesControlRestService _crisesControlRestService;
  final PageCacheDatabase _pageCacheDatabase;

  Future<MediaAttachment?> addMediaAttachment(
      {required bool isVideo,
      required bool fromGallery,
      required bool saveToGallery}) async {
    final XFile? image;

    if (isVideo) {
      image = await _picker.pickVideo(
        source: fromGallery ? ImageSource.gallery : ImageSource.camera,
      );
    } else {
      image = await _picker.pickImage(
        source: fromGallery ? ImageSource.gallery : ImageSource.camera,
      );
    }

    if (image != null) {
      int imageFileSize = await image.length();
      var attachmentType =
          isVideo ? MediaAttachmentType.video : MediaAttachmentType.image;

      var mediaAttachment = MediaAttachment(
        'Title',
        image.name,
        image.name,
        imageFileSize,
        image.path,
        attachmentType,
      );

      if (saveToGallery) {
        await ImageGallerySaver.saveFile(image.path);
      }

      return mediaAttachment;
    } else {
      return null;
    }
  }

  ///This method retrieves the users ping
  Future<Either<CCError, PingResponse>> getPings() async {
    var restCredentials =
        await _authenticationDatabaseService.retrieveRestCredentials();

    try {
      var pings = await _pingRestService.getUsersPings(
        userId: restCredentials.loginData.userId,
        accessToken: restCredentials.accessToken,
      );

      if (pings != null) {
        // _pageCacheDatabase.insertPingCache(cache: pings.data); 
        return Right(pings);
      }

      return const Left(CCError(errorTitle: 'No pings'));
    } on UnauthorisedException {
      return const Left(CCError.unauthorisedError);
    } on SocketException {
      //If the user has not got a connection to the internet
      return const Left(CCError.noConnectivityError);
    } on ServerException {
      return const Left(CCError());
    } on Exception {
      return const Left(CCError());
    }
  }

  ///This method retrieves the users ping from the cache
  List<PingData> getPingsFromCache() {
    try {
      // var pings = _pageCacheDatabase.retrievePingCache(); 
      // return pings;
      return [];
    } on Exception {
      return [];
    }
  }

  Future<Either<CCError, PingInfo>> getPingInfo({
    required int messageId,
  }) async {
    var restCredentials =
        await _authenticationDatabaseService.retrieveRestCredentials();

    try {
      var response = await _pingRestService.getPingInfo(
        messageId: messageId,
        accessToken: restCredentials.accessToken,
      );
      if (response != null) {
        return Right(response.data);
      }
      return const Left(CCError());
    } on UnauthorisedException {
      return const Left(CCError.unauthorisedError);
    } on SocketException {
      //If the user has not got a connection to the internet
      return const Left(CCError.noConnectivityError);
    } on ServerException {
      return const Left(CCError());
    } on Exception {
      return const Left(CCError());
    }
  }

  Future<Either<CCError, String>> acknowledgePing({
    required int msgListId,
    required int responseId,
  }) async {
    var restCredentials =
        await _authenticationDatabaseService.retrieveRestCredentials();

    try {
      final body = AcknowledgeMessageBody(
        msgListId: msgListId,
        responseId: responseId,
        ackMethod: "APP",
        userLocationLong: "",
        userLocationLat: "",
        companyKey: "",
      );

      final response = await _crisesControlRestService.acknowledgeMessage(
        accessToken: restCredentials.accessToken,
        msgListId: msgListId,
        acknowledgeMessageBody: body,
      );

      return const Right('test');
    } on UnauthorisedException {
      return const Left(CCError.unauthorisedError);
    } on SocketException {
      //If the user has not got a connection to the internet
      return const Left(CCError.noConnectivityError);
    } on ServerException {
      return const Left(CCError());
    } on Exception {
      return const Left(CCError());
    }
  }

  // Future<Either<CCError, String>> sendPing({
  //   required String message,
  //   required List<MediaAttachment> mediaAttachments,
  //   required List<AcknowledgeOption> ackOptions,
  //   required List<SelectedCommunication> messageMethods,
  //   required List<int> usersToNotify,
  //   required List<GroupData> groups,
  //   required List<LocationsData> locations,
  //   required List<DepartmentsData> departments,
  //   required int cascadePlanId,
  //   required bool slientMessage,
  // }) async {
  //   var restCredentials =
  //       await _authenticationDatabaseService.retrieveRestCredentials();

  //   try {
  //     List<PingMessageObj> pingMessageObjs = [];

  //     for (var group in groups) {
  //       pingMessageObjs.add(PingMessageObj(
  //         objectMappingId: group.objectMappingId,
  //         sourceObjectPrimaryId: ObjectMappingIds.objectMappingIdGroup,
  //       ));
  //     }
  //     for (var department in departments) {
  //       pingMessageObjs.add(PingMessageObj(
  //         objectMappingId: department.objectMappingId,
  //         sourceObjectPrimaryId: ObjectMappingIds.objectMappingIdDepartment,
  //       ));
  //     }
  //     for (var location in locations) {
  //       pingMessageObjs.add(PingMessageObj(
  //         objectMappingId: location.objectMappingId,
  //         sourceObjectPrimaryId: ObjectMappingIds.objectMappingIdLocation,
  //       ));
  //     }

  //     final sendPingBody = SendPingBody(
  //       messageText: message,
  //       ackOptions: ackOptions,
  //       priority: 1,
  //       multiResponse: true,
  //       messageType: "Ping",
  //       incidentActivationId: 0,
  //       pingMessageObjLst: pingMessageObjs,
  //       usersToNotify: usersToNotify,
  //       audioAssetId: 0,
  //       silentMessage: slientMessage,
  //       messageMethod: messageMethods.map((e) => e.id).toList(),
  //       mediaAttachments: mediaAttachments,
  //       socialHandle: const [],
  //       cascadePlanId: cascadePlanId,
  //       sendToAllRecipient: true,
  //     );

  //     final result = await _pingRestService.sendPing(
  //       accessToken: restCredentials.accessToken,
  //       sendPingBody: sendPingBody,
  //     );

  //     return const Right('test');
  //   } on UnauthorisedException {
  //     return const Left(CCError.unauthorisedError);
  //   } on SocketException {
  //     //If the user has not got a connection to the internet
  //     return const Left(CCError.noConnectivityError);
  //   } on ServerException {
  //     return const Left(CCError());
  //   } on Exception {
  //     return const Left(CCError());
  //   }
  // }

  Future<Either<CCError, dynamic>> sendPing({
    required String message,
    required List<MediaAttachment> mediaAttachments,
    required List<AcknowledgeOption> ackOptions,
    required List<SelectedCommunication> messageMethods,
    required List<SelectedUser> usersToNotify,
    required List<GroupData> groups,
    required List<LocationsData> locations,
    required List<DepartmentsData> departments,
    required int cascadePlanId,
    required bool slientMessage,
    required int priorityIndex,
  }) async {
    var restCredentials =
        await _authenticationDatabaseService.retrieveRestCredentials();

    try {
      //Groups, Departments, Locations
      List<MessageObjRq> messageObjs = [];
      messageObjs.addAll(groups.map((g) => g.toAcknowledgeOptionRq()).toList());
      messageObjs
          .addAll(departments.map((d) => d.toAcknowledgeOptionRq()).toList());
      messageObjs
          .addAll(locations.map((l) => l.toAcknowledgeOptionRq()).toList());

      //AckOptions
      List<AcknowledgeOptionRq> ackOptionsRq = [];
      for (var i = 0; i < ackOptions.length; i++) {
        ackOptionsRq.add(ackOptions[i].toAcknowledgeOptionRq(i));
      }

      final sendPingBody = SendPingBody(
        messageText: message,
        ackOptions: ackOptionsRq,
        priority: PriorityHelper.pingIndexToPriorityValue(priorityIndex),
        multiResponse: ackOptionsRq.isNotEmpty,
        messageType: BackendConstants.messageTypePing,
        incidentActivationId: 0,
        pingMessageObjLst: messageObjs,
        usersToNotify: usersToNotify.map((e) => e.userId).toList(),
        audioAssetId: 0, 
        silentMessage: slientMessage,
        messageMethod: messageMethods.map((e) => e.id).toList(),
        mediaAttachments: mediaAttachments, 
        socialHandle: const [], 
        cascadePlanId: cascadePlanId,
        sendToAllRecipient: true,
      );

      final response = await _pingRestService.sendPing(
        accessToken: restCredentials.accessToken,
        sendPingBody: sendPingBody,
      );

      return Right(response);
    } on UnauthorisedException {
      return const Left(CCError.unauthorisedError);
    } on SocketException {
      //If the user has not got a connection to the internet
      return const Left(CCError.noConnectivityError);
    } on ServerException {
      return const Left(CCError());
    } on Exception {
      return const Left(CCError());
    }
  }

  Future<Either<CCError, String>> replyToPing({
    required PingData ping,
    required String message,
    required ReplyType pingReplyTo,
    required List<int> messageMethod,
  }) async {
    var restCredentials =
        await _authenticationDatabaseService.retrieveRestCredentials();
    var replyTo = pingReplyTo == ReplyType.sender ? 'SENDER' : 'ALL';

    final messageReplyBody = MessageReplyBody(
      parentId: ping.messageId,
      messageText: message,
      replyTo: replyTo,
      messageType: "PING",
      activeIncidentId: 0,
      messageMethod: messageMethod,
      cascadePlanId: 0,
      currentUserId: restCredentials.loginData.userId,
      companyId: restCredentials.loginData.companyId,
      timeZoneId: '',
    );

    try {
      final result = await _crisesControlRestService.replyToMessage(
        accessToken: restCredentials.accessToken,
        messageReplyBody: messageReplyBody,
      );

      if (result != null && result.errorId != null) {     
      }
      return const Right('test');
    } on UnauthorisedException {
      return const Left(CCError.unauthorisedError);
    } on SocketException {
      //If the user has not got a connection to the internet
      return const Left(CCError.noConnectivityError);
    } on ServerException {
      return const Left(CCError());
    } on Exception {
      return const Left(CCError());
    }
  }

  Future<Either<CCError, String>> renotifyUnacknowledgeUsers({
    required PingData ping,
    required String message,
    required List<int> messageMethod,
    required int cascadingPlanId,
  }) async {
    final restCredentials =
        await _authenticationDatabaseService.retrieveRestCredentials();

    final messageReplyBody = MessageReplyBody(
      activeIncidentId: 0,
      companyId: restCredentials.loginData.companyId,
      currentUserId: restCredentials.loginData.userId,
      messageMethod: messageMethod,
      messageText: message,
      messageType: "PING",
      parentId: ping.messageId,
      cascadePlanId: cascadingPlanId,
      replyTo: "RENOTIFY",
      timeZoneId: "",
    );

    try {
      _crisesControlRestService.renotifyUnacknowledgedUsers(
        accessToken: restCredentials.accessToken,
        messageReplyBody: messageReplyBody,
      );
      return const Right('');
    } on UnauthorisedException {
      return const Left(CCError.unauthorisedError);
    } on SocketException {
      //If the user has not got a connection to the internet
      return const Left(CCError.noConnectivityError);
    } on ServerException {
      return const Left(CCError());
    } on Exception {
      return const Left(CCError());
    }
  }

  Future<Either<CCError, List<Reply>>> getReplies({
    required int parentId,
  }) async {
    var restCredentials =
        await _authenticationDatabaseService.retrieveRestCredentials();

    try {
      var response = await _crisesControlRestService.getRepliesForMessage(
        accessToken: restCredentials.accessToken,
        parentId: parentId,
      );

      if (response != null) {
        return Right(response.data);
      }
      return const Left(CCError());
    } on UnauthorisedException {
      return const Left(CCError.unauthorisedError);
    } on SocketException {
      //If the user has not got a connection to the internet
      return const Left(CCError.noConnectivityError);
    } on ServerException {
      return const Left(CCError());
    } on Exception {
      return const Left(CCError());
    }
  }

  Future<Either<CCError, String>> uploadAnAttachment({
    required File attachment,
  }) async {
    var restCredentials =
        await _authenticationDatabaseService.retrieveRestCredentials();

    try {
      var response = await _crisesControlRestService.uploadAttachment(
        accessToken: restCredentials.accessToken,
        attachment: attachment,
      );

      return const Left(CCError());
    } on UnauthorisedException {
      return const Left(CCError.unauthorisedError);
    } on SocketException {
      //If the user has not got a connection to the internet
      return const Left(CCError.noConnectivityError);
    } on ServerException {
      return const Left(CCError());
    } on Exception {
      return const Left(CCError());
    }
  }
}
