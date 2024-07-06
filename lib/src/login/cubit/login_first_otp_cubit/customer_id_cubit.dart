/*import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:crises_control/src/core/errors/cc_error.dart';
import 'package:crises_control/src/core/models/authentication_credentials.dart';
import 'package:crises_control/src/login/bloc/customer_id_bloc/customer_id_bloc.dart';
import 'package:crises_control/src/login/repository/login_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'customer_id_state.dart';

class CustomerIdCubit extends Cubit<CustomerIdState> {
  CustomerIdCubit(this._loginRepository)
      : super(const CustomerIdState(isLoading: false));
  final LoginRepository _loginRepository;

  Future<void> onCustomerIdNext({required String customerId}) async {
    emit(state.copyWith(
      isLoading: true,
      error: null,
      apiUrl: null,
      companyLogo: null,
    ));
    checkAuthenticationProvider(customerId);

    if (customerId == "") {
      emit(state.copyWith(
        isLoading: false,
        error: const CCError(
          errorTitle: 'Customer ID is required',
          errorMessage: 'enter_customer_id',
        ),
      ));
    } else {
      final result = await _loginRepository.setApiUrl(customerId);
      result.fold(
        (error) => emit(state.copyWith(isLoading: false, error: error)),
        (apiUrl) async {
          final companyLogo =
              await _loginRepository.getCompanyLogo(customerId: customerId);

          final authenticationCredentials =
              _loginRepository.getAuthenticationCredentials(customerId);

          emit(
            state.copyWith(
              apiUrl: apiUrl,
              companyLogo: companyLogo,
              authenticationCredentials: authenticationCredentials,
              isLoading: false,
            ),
          );
        },
      );
    }
  }

  void checkAuthenticationProvider(String customerId) {
    if (customerId == "MSAL") {
      _loginRepository.authenticateWithMicrosoft();
    }

    if (customerId == "OKTA") {
      _loginRepository.authenticateWithOkta();
    }
  }
}
*/