// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  const HomeInitial();

  @override
  List<Object?> get props => [];
}

class HomeLoading extends HomeState {
  const HomeLoading(this.homeIcons);
  final List<HomeIcon> homeIcons;

  @override
  List<Object?> get props => [];
}

class HomeLoaded extends HomeState {
  const HomeLoaded(
    this.appHome,
    this.icons,
    this.securityItems,
    this.loginData,
    this.companies,
  );
  final AppHome? appHome;
  final List<HomeIcon> icons;
  final List<SecurityItem> securityItems;
  final LoginData loginData;
  final List<Company> companies;

  @override
  List<Object?> get props => [appHome, icons];
}

class HomeFailure extends HomeState {
  const HomeFailure(this.error, this.homeIcons);
  final CCError error;
  final List<HomeIcon> homeIcons;

  @override
  List<Object?> get props => [error];
}

class HomeLoggedOut extends HomeState {
  const HomeLoggedOut();

  @override
  List<Object?> get props => [];
}
