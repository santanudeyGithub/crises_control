import 'dart:developer';
import 'dart:io';

import 'package:crises_control/src/companies/models/company.dart';
import 'package:crises_control/src/core/constants.dart';
import 'package:crises_control/src/core/errors/cc_error.dart';
import 'package:crises_control/src/core/errors/exceptions.dart';
import 'package:crises_control/src/core/models/login_data.dart';
import 'package:crises_control/src/core/models/user_info.dart';
import 'package:crises_control/src/core/services/contact_service.dart';
import 'package:crises_control/src/core/services/page_cache_database.dart';
import 'package:crises_control/src/home/models/app_home.dart';
import 'package:crises_control/src/home/models/home_icon_model.dart';
import 'package:crises_control/src/home/models/home_item.dart';
import 'package:crises_control/src/home/models/home_page_cache.dart';
import 'package:crises_control/src/home/services/home_rest_service.dart';
import 'package:crises_control/src/login/services/authentication_database_service.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/widgets.dart';

class HomeRepository {
  HomeRepository(
    this._homeRestService,
    this._pageCacheService,
    this._authenticationDatabaseService,
    this._contactService,
  );
  final ContactService _contactService;
  final PageCacheDatabase _pageCacheService;
  final HomeRestService _homeRestService;
  final AuthenticationDatabaseService _authenticationDatabaseService;

  ///Retrieves the home data for the given userDeviceId
  ///Either returns a [CCError] in a failure case or [AppHome] in a success state
  Future<Either<CCError, AppHome>> retrieveHomeData() async {
    await _pageCacheService.init();
    var restCredentials =
        await _authenticationDatabaseService.retrieveRestCredentials();

    try {
      var data = await _homeRestService.getAppHomeData(
        userDeviceId: '1',
        companyId: '290',
        accessToken: restCredentials.accessToken,
      );

      if (data != null) {
        var appData = data.data;

        _pageCacheService.insertHomePageCache(
          cache: HomePageCache(
            _pageCacheService.retrieveHomeIcons(),
            appData.incidentCount,
            appData.pingCount,
          ),
        );

        addCrisesControlContact(
          appData: appData,
          accessToken: restCredentials.accessToken,
        );

        return Right(data);
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

  Future<Either<CCError, HomePageCache>> retrieveHomePageCache() async {
    try {
      await _pageCacheService.init();
      var pageCache = _pageCacheService.retrieveHomePageCache();
      return Right(pageCache);
    } on Exception {
      return const Left(CCError());
    }
  }

  Future<List<HomeIcon>> getHomeIconsOrder(
      {int incidentCount = 0, int pingCount = 0}) async {
    await _pageCacheService.init();
    var icons = _pageCacheService.retrieveHomeIcons();
    List<HomeIcon> homeIcon = [];
    for (var item in icons) {
      if (HomeItemType.pingMessages.name == item.homeItem) {
        homeIcon.add(HomeIcon(
          badgeNumber: pingCount,
          homeItem: HomeItemType.values.byName(item.homeItem),
        ));
      } else if (HomeItemType.incidents.name == item.homeItem) {
        homeIcon.add(HomeIcon(
          badgeNumber: incidentCount,
          homeItem: HomeItemType.values.byName(item.homeItem),
        ));
      } else {
        homeIcon.add(HomeIcon(
          badgeNumber: 0,
          homeItem: HomeItemType.values.byName(item.homeItem),
        ));
      }
    }
    return homeIcon;
  }

  Future<List<HomeIcon>> getHomeIconsOrderFromCache({
    required List<HomeIconModel> icons,
    int pingCount = 0,
    int incidentCount = 0,
  }) async {
    await _pageCacheService.init();
    List<HomeIcon> homeIcon = [];
    for (var item in icons) {
      if (HomeItemType.pingMessages.name == item.homeItem) {
        homeIcon.add(HomeIcon(
          badgeNumber: pingCount,
          homeItem: HomeItemType.values.byName(item.homeItem),
        ));
      } else if (HomeItemType.incidents.name == item.homeItem) {
        homeIcon.add(HomeIcon(
          badgeNumber: incidentCount,
          homeItem: HomeItemType.values.byName(item.homeItem),
        ));
      } else {
        homeIcon.add(HomeIcon(
          badgeNumber: 0,
          homeItem: HomeItemType.values.byName(item.homeItem),
        ));
      }
    }
    return homeIcon;
  }

  addHomeIconsList(List<HomeIcon> homeIcons) async {
    await _pageCacheService.init();
    List<HomeIconModel> icons = [];
    for (var item in homeIcons) {
      icons.add(HomeIconModel(item.homeItem.name));
    }
    await _pageCacheService.addHomeIconsList(icons);
  }

  List<SecurityItem> retrieveUsersSecurityItems() {
    var userInfo = _authenticationDatabaseService.retrieveUserInfo();
    if (userInfo != null) {
      return userInfo.secItems;
    }
    return [];
  }

  void addCrisesControlContact({
    required AppData appData,
    required String accessToken,
  }) async {
    if (!await FlutterContacts.requestPermission()) return;

    final result = await _homeRestService.getCrisesControlPhoneNumbers(
      accessToken: accessToken,
    );

    if (result != null) {
      try {
        _contactService.addCrisesControlContact(
          displayName: appData.companyParams
              .where((element) => element.name == 'PHONE_CONTACT_LABEL')
              .first
              .value,
          phoneNumbers: result,
          phoneContactLogoUrl: appData.phoneContactLogo,
        );
      } on Exception catch (e) {
        log(e.toString());
      }
    }
  }

  Either<CCError, LoginData> retrieveLoginData() {
    try {
      var loginData = _authenticationDatabaseService.retrieveloginData();
      return Right(loginData);
    } on Exception {
      return const Left(CCError());
    }
  }

  List<Company>? retrieveUserCompanies() {
    try {
      var companies = _authenticationDatabaseService.retrieveUserCompanies();
      return companies;
    } on Exception catch (e) {
      log('Error retrieving user companies: $e');
      return null;
    }
  }

  Future<Either<CCError, bool>> logoutUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      //Clear any ephemeral data
      _authenticationDatabaseService.clearDatabase();
      _pageCacheService.clearAllCache();

      //Set the user as logged out
      prefs.setBool(SharedPrefencesKey.loggedIn, false);
      return const Right(true);
    } on Exception catch (e) {
      log('Error logging out user: $e');
      return const Left(CCError());
    }
  }
}
