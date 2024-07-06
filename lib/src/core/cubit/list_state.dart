part of 'list_cubit.dart';

enum ListStateActions { initial, loading, success, error, empty }

abstract class ListState extends Equatable {
  const ListState();
}

class ListInitial extends ListState {
  const ListInitial(this.action);
  final ListStateActions action;
  @override
  List<Object?> get props => [action];
}

class ListLoading extends ListState {
  const ListLoading(this.action);
  final ListStateActions action;
  @override
  List<Object?> get props => [action];
}

class EmptyList extends ListState {
  const EmptyList(this.action);
  final ListStateActions action;
  @override
  List<Object?> get props => [action];
}

class LocationsListLoaded extends ListState {
  const LocationsListLoaded(this.locations, this.action);
  final List<LocationsData> locations;
  final ListStateActions action;
  @override
  List<Object?> get props => [locations];
}

class DepartmentsListLoaded extends ListState {
  const DepartmentsListLoaded(this.departments, this.action);
  final List<DepartmentsData> departments;
  final ListStateActions action;
  @override
  List<Object?> get props => [departments];
}

class GroupsListLoaded extends ListState {
  const GroupsListLoaded(this.groups, this.action);
  final List<GroupData> groups;
  final ListStateActions action;
  @override
  List<Object?> get props => [groups];
}

class UsersListsLoaded extends ListState {
  const UsersListsLoaded(this.users, this.action);
  final List<UserData> users;
  final ListStateActions action;
  @override
  List<Object?> get props => [users];
}

class AffectedLocationsListLoaded extends ListState {
  const AffectedLocationsListLoaded(this.affectedLocations, this.action);
  final List<AffectedLocationsData> affectedLocations;
  final ListStateActions action;
  @override
  List<Object?> get props => [affectedLocations];
}

class ListError extends ListState {
  const ListError(this.error, this.action);
  final CCError error;
  final ListStateActions action;
  @override
  List<Object?> get props => [error];
}

class CommunicationPrefencesLoaded extends ListState {
  const CommunicationPrefencesLoaded(
    this.action,
    this.companyCommsResponse,
    this.cascadingPlanResponse,
    this.commMethods,
  );

  final ListStateActions action;
  final CompanyCommsResponse companyCommsResponse;
  final CascadingPlanResponse cascadingPlanResponse;
  final List<MessageMethod> commMethods;

  @override
  List<Object?> get props =>
      [action, companyCommsResponse, cascadingPlanResponse];
}

class AcknowledgeOptionsLoaded extends ListState {
  const AcknowledgeOptionsLoaded(this.action, this.acknowledgeOptions);
  final ListStateActions action;
  final List<AcknowledgeOption> acknowledgeOptions;
  @override
  List<Object?> get props => [action, acknowledgeOptions];
}

class SocialIntergrationsLoaded extends ListState {
  const SocialIntergrationsLoaded(this.action, this.socialIntergrations);
  final ListStateActions action;
  final List<String> socialIntergrations;
  @override
  List<Object?> get props => [action, socialIntergrations];
}
