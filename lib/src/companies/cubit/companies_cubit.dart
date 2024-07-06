import 'package:bloc/bloc.dart';
import 'package:crises_control/src/companies/models/company.dart';
import 'package:crises_control/src/core/errors/cc_error.dart';
import 'package:equatable/equatable.dart';

part 'companies_state.dart';

class CompaniesCubit extends Cubit<CompaniesState> {
  CompaniesCubit() : super(const CompaniesState([], false, null));

  Future<void> loadUsersCompanies() async {}
}
