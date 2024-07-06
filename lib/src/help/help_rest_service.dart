import 'package:crises_control/src/core/constants.dart';
import 'package:crises_control/src/core/services/base_rest_service.dart';
import 'package:crises_control/src/help/models/feedback_request_body.dart';
import 'package:crises_control/src/help/models/policy_response.dart';

enum PolicyType { privacy, terms }

class HelpRestService extends BaseRestService {
  HelpRestService();

  Future<PolicyResponse?> getPolicy({
    required String accessToken,
    required PolicyType policyType,
  }) async {
    var endpoint =
        (policyType == PolicyType.privacy) ? '/GetPrivacyPolicy' : '/GetTnC';
    final result = await sendHttpRequest(
      accessToken: accessToken,
      controller: ApiContrtollers.app,
      endPoint: endpoint,
      httpRequestMethod: HttpRequestMethod.get,
    );

    return PolicyResponse.fromJson(result);
  }

  Future<void> sendFeedback({
    required String accessToken,
    required FeedbackRequestBody feedbackRequestBody,
  }) async {
    final result = await sendHttpRequest(
      accessToken: accessToken,
      controller: ApiContrtollers.app,
      endPoint: '/SendFeedback',
      httpRequestMethod: HttpRequestMethod.post,
      requestBody: feedbackRequestBody.toJson(),
    );

    return result;
  }
}
