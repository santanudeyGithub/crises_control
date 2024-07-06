part of 'companies_cubit.dart';

class CompaniesState extends Equatable {
  const CompaniesState(this.companies, this.isLoading, this.error);
  final List<Company>? companies;
  final bool isLoading;
  final CCError? error;

  @override
  List<Object?> get props => [
        companies,
        isLoading,
        error,
      ];
}
