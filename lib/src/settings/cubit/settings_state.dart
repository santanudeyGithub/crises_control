// ignore_for_file: prefer_const_constructors_in_immutables

part of 'settings_cubit.dart';

abstract class SettingsState extends Equatable {
  const SettingsState({required String customProperty});

  @override
  List<Object> get props => [];
}

class SettingsInitial extends SettingsState {
  SettingsInitial({required super.customProperty});
}
