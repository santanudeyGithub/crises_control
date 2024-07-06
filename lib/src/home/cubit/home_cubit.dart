import 'package:bloc/bloc.dart';
import 'package:crises_control/src/companies/models/company.dart';
import 'package:crises_control/src/core/errors/cc_error.dart';
import 'package:crises_control/src/core/models/login_data.dart';
import 'package:crises_control/src/core/models/user_info.dart';
import 'package:crises_control/src/home/models/app_home.dart';
import 'package:crises_control/src/home/models/home_item.dart';
import 'package:crises_control/src/home/repository/home_repository.dart';
import 'package:crises_control/src/home/widgets/widgets.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._homeRepository) : super(const HomeInitial());
  final HomeRepository _homeRepository;
  List<HomeIcon> _homeIcons = HomeItemHelper.homeIconsPlaceHolder;
  List<SecurityItem> _securityItems = [];
  List<Company> _companies = [];

  refresh() async {
    emit(HomeLoading(_homeIcons));
    var homeData = await _homeRepository.retrieveHomeData();
    var loginData = loadLoginData();
    homeData.fold(
      (error) async => emit(HomeFailure(error, _homeIcons)),
      (data) async {
        _homeIcons = await _homeRepository.getHomeIconsOrder(
          incidentCount: data.data.incidentCount,
          pingCount: data.data.pingCount,
        );
        if (loginData != null) {
          emit(HomeLoaded(
            data,
            _homeIcons,
            _securityItems,
            loginData,
            _companies,
          ));
        } else {
          emit(
            HomeFailure(
              const CCError(errorTitle: 'Login data not found'),
              _homeIcons,
            ),
          );
        }
      },
    );
  }

  void logout() async {
    final result = await _homeRepository.logoutUser();
    result.fold(
      (error) => emit(HomeFailure(error, _homeIcons)),
      (data) => emit(const HomeLoggedOut()),
    );
  }

  pageFirstLoad() async {
    emit(HomeLoading(_homeIcons));
    var homeData = await _homeRepository.retrieveHomeData();
    _securityItems = _homeRepository.retrieveUsersSecurityItems();
    var companies = _homeRepository.retrieveUserCompanies();
    if (companies != null) {
      _companies = companies;
    }

    var loginData = loadLoginData();
    homeData.fold(
      (error) async {
        var homeCahce = await _homeRepository.retrieveHomePageCache();
        homeCahce.fold(
          (error) {
            emit(HomeFailure(error, _homeIcons));
          },
          (cache) async {
            if (loginData != null) {
              emit(
                HomeLoaded(
                  null,
                  _homeIcons,
                  _securityItems,
                  loginData,
                  _companies,
                ),
              );
            }
          },
        );
      },
      (data) async {
        _homeIcons = await _homeRepository.getHomeIconsOrder(
          incidentCount: data.data.incidentCount,
          pingCount: data.data.pingCount,
        );
        if (loginData != null) {
          emit(HomeLoaded(
            data,
            _homeIcons,
            _securityItems,
            loginData,
            _companies,
          ));
        } else {
          emit(
            HomeFailure(
              const CCError(errorTitle: 'Login data not found'),
              _homeIcons,
            ),
          );
        }
      },
    );
  }

  LoginData? loadLoginData() {
    final result = _homeRepository.retrieveLoginData();
    LoginData? loginData;
    result.fold(
      (error) => emit(HomeFailure(error, _homeIcons)),
      (r) => loginData = r,
    );
    return loginData;
  }

  onRearrangedItems(List<HomeIcon> icons) async {
    await _homeRepository.addHomeIconsList(icons);
  }
}
