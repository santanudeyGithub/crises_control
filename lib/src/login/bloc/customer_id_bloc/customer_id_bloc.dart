// ignore_for_file: depend_on_referenced_packages, inference_failure_on_untyped_parameter

import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:crises_control/src/core/models/authentication_credentials.dart';
import 'package:crises_control/src/login/repository/login_repository.dart';
import 'package:crises_control/src/core/errors/cc_error.dart';
import 'package:equatable/equatable.dart';
part 'customer_id_event.dart';
part 'customer_id_state.dart';

class CustomerIdBloc extends Bloc<CustomerIdEvent, CustomerIdState> {
  CustomerIdBloc(
    this._loginRepository,
  ) : super(CustomerIdInitial(isLoading: true)) {
    //ToDo add Demo Parameter
    on<CustomerIdNext>(onCustomerIdNext);
  }
  final LoginRepository _loginRepository;

  Future<void> onCustomerIdNext(event, emit) async {
    AuthenticationCredentials authenticationCredentials;
    final customerId = event.customerId.toString();
    emit(CustomerIdLoading(isLoading: true)); // Todo add demo parameter

    if (customerId == "MSAL") {
      _loginRepository.authenticateWithMicrosoft();
    }

    if (customerId == "OKTA") {
      _loginRepository.authenticateWithOkta();
    }

    if (customerId == "") {
      emit(
        const CustomerIdFailure(
          CCError(
            errorTitle: 'Customer ID is required',
            errorMessage: 'enter_customer_id',
          ),
        ),
      );
    } else {
      final result = await _loginRepository.setApiUrl(customerId);
      result.fold(
        (error) => emit(CustomerIdFailure(error)),
        (apiUrl) => {
          authenticationCredentials =
              _loginRepository.getAuthenticationCredentials(customerId),
          emit(CustomerIdSuccess(apiUrl, authenticationCredentials)),
        },
      );
    }
  }
}
