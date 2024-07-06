// ignore_for_file: public_member_api_docs, sort_constructors_first
/*part of 'customer_id_cubit.dart';

@immutable
class CustomerIdState extends Equatable {
  const CustomerIdState({
    required this.isLoading,
    this.companyLogo,
    this.error,
    this.apiUrl,
    this.authenticationCredentials,
  });
  final bool isLoading;
  final CCError? error;
  final String? apiUrl;
  final AuthenticationCredentials? authenticationCredentials;
  final File? companyLogo;

  @override
  List<Object?> get props => [
        error,
        apiUrl,
        authenticationCredentials,
        companyLogo,
        isLoading,
      ];

  CustomerIdState copyWith({
    bool? isLoading,
    CCError? error,
    String? apiUrl,
    AuthenticationCredentials? authenticationCredentials,
    File? companyLogo,
  }) {
    return CustomerIdState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      apiUrl: apiUrl ?? this.apiUrl,
      authenticationCredentials:
          authenticationCredentials ?? this.authenticationCredentials,
      companyLogo: companyLogo ?? this.companyLogo,
    );
  }
}
*/