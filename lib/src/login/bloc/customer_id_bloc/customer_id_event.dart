part of 'customer_id_bloc.dart';

abstract class CustomerIdEvent extends Equatable {
  const CustomerIdEvent();
}

class CustomerIdNext extends CustomerIdEvent {
  const CustomerIdNext(this.customerId);
  final String customerId;

  @override
  List<Object?> get props => [customerId];
}
