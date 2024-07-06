import 'package:bloc/bloc.dart';
import 'package:crises_control/src/core/errors/cc_error.dart';
import 'package:crises_control/src/core/models/communication_models/cascading_plan_response.dart';
import 'package:crises_control/src/core/models/communication_models/company_comms_response.dart';
import 'package:crises_control/src/core/models/list_models/affected_locations.dart';
import 'package:crises_control/src/core/models/list_models/departments.dart';
import 'package:crises_control/src/core/models/list_models/groups.dart';
import 'package:crises_control/src/core/models/list_models/locations.dart';
import 'package:crises_control/src/core/models/list_models/users.dart';
import 'package:crises_control/src/core/repository/crises_control_core_repository.dart';
import 'package:crises_control/src/core/services/crises_control_rest_service.dart';
import 'package:equatable/equatable.dart';

import '../models/communication_models/message_response.dart';

part 'list_state.dart';

class ListCubit extends Cubit<ListState> {
  ListCubit(this._crisesControlCoreRepository)
      : super(const ListInitial(
          ListStateActions.initial,
        ));
  final CrisesControlCoreRepository _crisesControlCoreRepository;
  final EmptyList _emptyState = const EmptyList(ListStateActions.empty);

  Future<void> loadLocations() async {
    //loading state does emit if not delayed
    await Future.delayed(const Duration(milliseconds: 1));
    emit(const ListLoading(ListStateActions.loading));
    var result = await _crisesControlCoreRepository.getLocations();
    result.fold(
      (error) => emit(
        ListError(error, ListStateActions.error),
      ),
      (locations) {
        if (locations.data.isEmpty) {
          emit(_emptyState);
        }
        emit(
          LocationsListLoaded(
              locations.data
                  .where(
                    (element) => element.isNotDeleted,
                  )
                  .toList(),
              ListStateActions.success),
        );
      },
    );
  }

  Future<void> loadDepartments() async {
    emit(const ListLoading(ListStateActions.loading));
    var result = await _crisesControlCoreRepository.getDepartments();
    result.fold(
      (error) => emit(
        ListError(error, ListStateActions.error),
      ),
      (departments) {
        if (departments.data.isEmpty) {
          emit(_emptyState);
        }
        emit(
          DepartmentsListLoaded(
              departments.data
                  .where(
                    (element) => element.isNotDeleted,
                  )
                  .toList(),
              ListStateActions.success),
        );
      },
    );
  }

  Future<void> loadGroups() async {
    //loading state does emit if not delayed
    await Future.delayed(const Duration(milliseconds: 1));
    emit(const ListLoading(ListStateActions.loading));
    var result = await _crisesControlCoreRepository.getGroups();
    if (isClosed) return;
    result.fold(
      (error) => emit(
        ListError(error, ListStateActions.error),
      ),
      (groups) {
        if (groups.data.isEmpty) {
          emit(_emptyState);
        }
        emit(
          GroupsListLoaded(
              groups.data
                  .where(
                    (element) => element.isNotDeleted,
                  )
                  .toList(),
              ListStateActions.success),
        );
      },
    );
  }

  Future<void> loadUsers() async {
    //loading state does emit if not delayed
    await Future.delayed(const Duration(milliseconds: 1));
    emit(const ListLoading(ListStateActions.loading));
    var result = await _crisesControlCoreRepository.getUsers();
    if (isClosed) return;
    result.fold(
      (error) => emit(
        ListError(error, ListStateActions.error),
      ),
      (users) {
        if (users.data.data.isEmpty) {
          emit(_emptyState);
        }
        emit(
          UsersListsLoaded(users.data.data, ListStateActions.success),
        );
      },
    );
  }

  Future<void> loadAffectedLocations() async {
    //loading state does emit if not delayed
    await Future.delayed(const Duration(milliseconds: 1));
    emit(const ListLoading(ListStateActions.loading));
    var result = await _crisesControlCoreRepository.getAffectedLocations();
    result.fold(
      (error) => emit(
        ListError(error, ListStateActions.error),
      ),
      (affectedLocations) {
        if (affectedLocations.data.isEmpty) {
          emit(_emptyState);
        }
        emit(
          AffectedLocationsListLoaded(
              affectedLocations.data, ListStateActions.success),
        );
      },
    );
  }

  Future<void> loadCompanyCommsAndCascadingPlan({
    required CascadingPlanType cascadingPlanType,
  }) async {
    await Future.delayed(const Duration(microseconds: 1));
    emit(const ListLoading(ListStateActions.loading));
    CompanyCommsResponse? companyCommsResponse;
    CascadingPlanResponse? cascadingPlanResponse;

    final companyComms = await _crisesControlCoreRepository.getCompanyComms();
    companyComms.fold(
      (error) => emit(
        ListError(error, ListStateActions.error),
      ),
      (companyComms) {
        if (companyComms.data.priority.isEmpty) {
          emit(_emptyState);
        } else {
          companyCommsResponse = companyComms;
        }
      },
    );

    //check menu access
    final cascadingPlan = await _crisesControlCoreRepository.getCascadingPlans(
      cascadingPlanType: cascadingPlanType,
    );

    cascadingPlan.fold(
      (error) => emit(
        ListError(error, ListStateActions.error),
      ),
      (cascadingPlan) {
        cascadingPlanResponse = cascadingPlan;
      },
    );
    //TODOD check if low balance and display it
    if (companyCommsResponse != null && cascadingPlanResponse != null) {
      var companyComms = companyCommsResponse!.data.objectInfo
          .where((comm) => comm.status == 1)
          .toList();

      emit(
        CommunicationPrefencesLoaded(
          ListStateActions.success,
          companyCommsResponse!,
          cascadingPlanResponse!,
          companyComms,
        ),
      );
    }
  }

  Future<void> loadAcknowledgeOptions({
    required String messageType,
    required int status,
  }) async {
    await Future.delayed(const Duration(microseconds: 1));
    emit(const ListLoading(ListStateActions.loading));
    var result = await _crisesControlCoreRepository.getMessageResponse(
      messageType: messageType,
      status: status,
    );
    result.fold(
      (error) => emit(
        ListError(error, ListStateActions.error),
      ),
      (acknowledgeOptions) {
        if (acknowledgeOptions.data.isEmpty) {
          emit(_emptyState);
        }
        emit(
          AcknowledgeOptionsLoaded(
            ListStateActions.success,
            acknowledgeOptions.data,
          ),
        );
      },
    );
  }

  Future<void> loadAllSocialIntergrations() async {
    await Future.delayed(const Duration(microseconds: 1));
    emit(const ListLoading(ListStateActions.loading));
    var result = await _crisesControlCoreRepository.getSocialIntergrations();
    result.fold(
      (error) => emit(
        ListError(error, ListStateActions.error),
      ),
      (socialIntergrations) {
        if (socialIntergrations.isEmpty) {
          emit(_emptyState);
        }
        emit(
          SocialIntergrationsLoaded(
            ListStateActions.success,
            socialIntergrations,
          ),
        );
      },
    );
  }
}
