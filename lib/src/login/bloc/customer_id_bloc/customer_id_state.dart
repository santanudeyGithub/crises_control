// ignore_for_file: prefer_const_constructors_in_immutables

part of 'customer_id_bloc.dart';

abstract class CustomerIdState extends Equatable {
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
}

class CustomerIdInitial extends CustomerIdState {
  CustomerIdInitial({required super.isLoading});

  @override
  List<Object?> get props => [];
}

class CustomerIdLoading extends CustomerIdState {
  CustomerIdLoading({required super.isLoading});

  @override
  List<Object?> get props => [];
}

class CustomerIdFailure extends CustomerIdState {
  const CustomerIdFailure(this.error) : super(isLoading: false);
  final CCError error;

  @override
  List<Object?> get props => [error];
}

class CustomerIdSuccess extends CustomerIdState {
  const CustomerIdSuccess(this.apiUrl, this.authenticationCredentials)
      : super(isLoading: false);
  final String apiUrl;
  final AuthenticationCredentials authenticationCredentials;
  @override
  List<Object?> get props => [apiUrl];
}
