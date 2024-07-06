/*import 'package:crises_control/src/core/models/access_token.dart';
import 'package:crises_control/src/core/models/authentication_credentials.dart';
import 'package:crises_control/src/core/services/connectivity_service.dart';
import 'package:crises_control/src/core/services/oauth_service/oauth_service.dart';
import 'package:crises_control/src/login/repository/login_repository.dart';
import 'package:crises_control/src/login/services/authentication_database_service.dart';
import 'package:crises_control/src/login/services/authentication_service.dart';
import 'package:crises_control/src/core/services/secure_storge_service.dart';
import 'package:crises_control/src/login/services/login_rest_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

//This is how you create a mock class for testing purposes using mocktail package
class MockAuthenticationService extends Mock implements AuthenticationService {}

class MockOAuthService extends Mock implements OAuthSevrice {}

class MockConnectivityService extends Mock implements ConnectivityService {}

class MockAuthenticationDatabaseService extends Mock
    implements AuthenticationDatabaseService {}

class MockSecureStorageService extends Mock implements SecureStorageService {}

class MockLoginRestService extends Mock implements LoginRestService {}

void main() {
  //SUT - System Under Test
  late LoginRepository sut;
  //Mock services
  late MockAuthenticationService mockAuthenticationService;
  late MockOAuthService mockOAuthService;
  late MockAuthenticationDatabaseService mockAuthenticationDatabaseService;
  late MockSecureStorageService mockSecureStorageService;
  late MockLoginRestService mockLoginRestService;

  //Test variables
  const customerId = 'devtest';
  const companyName = 'transputec';
  const mockApi = 'www.mock.api.com';
  const companyLogo = 'www.mock-logo.api.com';
  const String email = 'mockperson@email.com';
  const String password = 'mockpassword';
  const AccessToken accessToken = AccessToken(
    accessToken: 'accessToken',
    tokenType: 'tokenType',
    expiresIn: 312,
  );

  final AuthenticationCredentials authenticationCredentials =
      AuthenticationCredentials(
    email,
    password,
    customerId,
    true,
    companyName,
    companyLogo,
  );

  setUp(() {
    mockAuthenticationService = MockAuthenticationService();
    mockOAuthService = MockOAuthService();
    mockAuthenticationDatabaseService = MockAuthenticationDatabaseService();
    mockSecureStorageService = MockSecureStorageService();
    mockLoginRestService = MockLoginRestService();

    sut = LoginRepository(
      mockAuthenticationService,
      mockAuthenticationDatabaseService,
      mockOAuthService,
      mockSecureStorageService,
      mockLoginRestService,
    );
  });

  tearDown(() => resetMocktailState());

  void arrangeAuthenticationService() {
    when(() => mockAuthenticationService.getSetApiUrl(customerId))
        .thenAnswer((_) async => mockApi);

    when(() => mockAuthenticationService.authoriseUserWithPassword(
          email: email,
          password: password,
        )).thenAnswer((_) async => accessToken);

    when(
      () => mockAuthenticationService.authoriseUserWithPassword(
        email: email,
        password: password,
      ),
    ).thenAnswer((_) async => accessToken);
  }

  void arrangeAuthenticationDatabase() {
    when(
      () => mockAuthenticationDatabaseService.addApiUrl('www.mock.api.com'),
    ).thenAnswer((_) async => null);
    when(
      () => mockAuthenticationDatabaseService.addAuthenticationCredentials(
        authenticationCredentials,
      ),
    ).thenAnswer((_) async => null);
    when(
      () => mockAuthenticationDatabaseService
          .addAuthenticationCredentials(authenticationCredentials),
    ).thenAnswer((_) async => null);
  }

  //Set up runs before the tests. Here you should initialise objects that you need for the tests

  group(
    'getApiUrl',
    () {
      test(
        'Get API url using the LoginRestService',
        () async {
          // arrange
          arrangeAuthenticationDatabase();
          arrangeAuthenticationService();
          // act
          final result = sut.setApiUrl(customerId);
          await result;
          // assert

          verify(() => mockAuthenticationService.getSetApiUrl(customerId))
              .called(1);

          verify(() => mockAuthenticationDatabaseService
              .addApiUrl('www.mock.api.com')).called(1);

          verifyNoMoreInteractions(mockAuthenticationService);
          verifyNoMoreInteractions(mockAuthenticationDatabaseService);
        },
      );

      test(
        """login with user with password should call authorise authoriseUserWithPassword on the authentication service
        it should also add the access token to the authentication database if the access token was retrieved from the server
        """,
        () async {
          arrangeAuthenticationDatabase();
          arrangeAuthenticationService();
          // act
          final result =
              await sut.loginUserWithPassword(email, password, false, '');
          result;
          // assert

          verify(
            () => mockAuthenticationService.authoriseUserWithPassword(
              email: email,
              password: password,
            ),
          ).called(1);

          verify(
            () => mockAuthenticationDatabaseService
                .addAuthenticationCredentials(authenticationCredentials),
          ).called(1);

          verifyNoMoreInteractions(mockAuthenticationService);
          verifyNoMoreInteractions(mockAuthenticationDatabaseService);
        },
      );

      test(
        'If remeber me is set to true, user credentials should be added to encrypted database',
        () async {
          // arrange
          arrangeAuthenticationDatabase();
          arrangeAuthenticationService();
          // act
          final result = sut.loginUserWithPassword(
            email,
            password,
            false,
            '',
          );
          await result;
          verify(
            () => mockAuthenticationService.authoriseUserWithPassword(
              email: email,
              password: password,
            ),
          ).called(1);

          verify(
            () => mockAuthenticationDatabaseService
                .addAuthenticationCredentials(authenticationCredentials),
          ).called(1);

          verify(
            () => mockAuthenticationDatabaseService
                .addAuthenticationCredentials(authenticationCredentials),
          ).called(1);

          verifyNoMoreInteractions(mockAuthenticationService);
          verifyNoMoreInteractions(mockAuthenticationDatabaseService);
        },
      );

      test(
        """login with user with password should call authorise authoriseUserWithPassword on the authentication service
        it should also add the access token to the authentication database if the access token was retrieved from the server
        """,
        () async {
          arrangeAuthenticationService();
          arrangeAuthenticationDatabase();
          // act
          final result =
              sut.loginUserWithPassword(email, password, true, customerId);
          await result;
          // assert

          verify(
            () => mockAuthenticationService.authoriseUserWithPassword(
              email: email,
              password: password,
            ),
          ).called(1);

          verify(() => mockAuthenticationDatabaseService
                  .addAuthenticationCredentials(authenticationCredentials))
              .called(1);

          verify(
            () => mockAuthenticationDatabaseService
                .addAuthenticationCredentials(authenticationCredentials),
          ).called(1);

          verifyNoMoreInteractions(mockAuthenticationService);
          verifyNoMoreInteractions(mockAuthenticationDatabaseService);
        },
      );
    },
  );

  group('loginUserWithPassword', () {
    test(
      'If remeber me is set to true, user credentials should be added to encrypted database',
      () async {
        // arrange
        arrangeAuthenticationDatabase();
        arrangeAuthenticationService();
        // act
        final result = sut.loginUserWithPassword(
          email,
          password,
          false,
          customerId,
        );
        await result;
        verify(
          () => mockAuthenticationService.authoriseUserWithPassword(
            email: email,
            password: password,
          ),
        ).called(1);

        verify(
          () => mockAuthenticationDatabaseService
              .addAuthenticationCredentials(authenticationCredentials),
        ).called(1);

        verifyNoMoreInteractions(mockAuthenticationService);
        verifyNoMoreInteractions(mockAuthenticationDatabaseService);
      },
    );

    test(
      'If remeber me is set to true, user credentials should be added to encrypted database',
      () async {
        // arrange
        arrangeAuthenticationDatabase();
        arrangeAuthenticationService();
        // act
        final result = sut.loginUserWithPassword(
          email,
          password,
          false,
          '',
        );
        await result;
        verify(
          () => mockAuthenticationService.authoriseUserWithPassword(
            email: email,
            password: password,
          ),
        ).called(1);

        verify(
          () => mockAuthenticationDatabaseService
              .addAuthenticationCredentials(authenticationCredentials),
        ).called(1);

        verifyNoMoreInteractions(mockAuthenticationService);
        verifyNoMoreInteractions(mockAuthenticationDatabaseService);
      },
    );
  });
}
*/