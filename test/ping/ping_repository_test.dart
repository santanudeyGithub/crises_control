/*import 'package:crises_control/src/core/models/login_data.dart';
import 'package:crises_control/src/core/models/rest_credentials.dart';
import 'package:crises_control/src/login/services/authentication_database_service.dart';
import 'package:crises_control/src/ping/models/ping.dart';
import 'package:crises_control/src/ping/repository/ping_repository.dart';
import 'package:crises_control/src/ping/services/ping_rest_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationDatabaseService extends Mock
    implements AuthenticationDatabaseService {}

class MockPingRestService extends Mock implements PingRestService {}

void main() {
  late PingRepository sut;
  late MockAuthenticationDatabaseService mockAuthenticationDatabaseService;
  late MockPingRestService mockPingRestService;

  LoginData loginData = LoginData(
    firstLogin: false,
    twoFactorLogin: false,
    companyId: 1,
    userId: 1,
    customerId: 'devtest',
    portal: 'portal',
    firstName: 'luca',
    lastName: 'pirolo',
    primaryEmail: 'luca.pirolo@transputec.com',
    companyName: 'transputec',
    uploadPath: '',
    companyMasterPlan: '',
    companyLoginLogo: '',
    iosLogo: '',
    androidLogo: '',
    windowsLogo: '',
    userDeviceId: 1,
    uniqueGuiId: 'ads',
    userRole: 'ADMIN',
    userLanguage: 'en',
    trackingStartTime: DateTime(200),
    trackingEndTime: DateTime(200),
    trackingInterval: 1,
    messageLength: 1,
    audioRecordMaxDuration: 1,
    uniqueKey: 'ads',
    forceUpdate: false,
  );

  RestCredentials restCredentials = RestCredentials(
    'accessToken',
    loginData,
  );

  setUp(
    () {
      mockAuthenticationDatabaseService = MockAuthenticationDatabaseService();
      mockPingRestService = MockPingRestService();
      
      sut = PingRepository(
        mockPingRestService,
        mockAuthenticationDatabaseService,
      );
    },
  );

  tearDown(() => resetMocktailState());

  void arrangeMockAuthenticationDatabase() {
    when(() => mockAuthenticationDatabaseService.retrieveRestCredentials())
        .thenAnswer((_) async => restCredentials);
  }

  //test get all pings
  test(
    'should return a empty list of pings',
    () async {
      //arrange
      arrangeMockAuthenticationDatabase();
      when(
        () => mockPingRestService.getUsersPings(
          userId: restCredentials.loginData.userId,
          accessToken: restCredentials.accessToken,
        ),
      ).thenAnswer(
        (_) async => const PingResponse(data: [], errorCode: '0'),
      );

      //act
      final result = await sut.getPings();
      verify(() => mockAuthenticationDatabaseService.retrieveRestCredentials())
          .called(1);
      //assert
      expect(result.isRight(), true);
    },
  );

}
*/