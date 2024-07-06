// ignore_for_file: prefer_const_constructors
/*
import 'package:bloc_test/bloc_test.dart';
import 'package:crises_control/src/settings/cubit/settings_cubit.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SettingsBloc', () {
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          SettingsBloc(),
          isNotNull,
        );
      });
    });

    test('initial state has default value for customProperty', () {
      final settingsBloc = SettingsBloc();
      expect(settingsBloc.state.customProperty, equals('Default Value'));
    });

//blocTest<SettingsBloc, SettingsState>(
    blocTest(
      'CustomSettingsEvent emits nothing',
      build: SettingsBloc.new,
      act: (bloc) => bloc.add(const CustomSettingsEvent()),
      expect: () => <SettingsState>[],
    );
  });
}
*/