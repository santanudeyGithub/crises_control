// ignore_for_file: prefer_const_constructors
/*
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:crises_control/src/ping/bloc/bloc.dart';

void main() {
  group('PingBloc', () {
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          PingBloc(),
          isNotNull,
        );
      });
    });

    test('initial state has default value for customProperty', () {
      final pingBloc = PingBloc();
      expect(pingBloc.state.customProperty, equals('Default Value'));
    });

    blocTest<PingBloc, PingState>(
      'CustomPingEvent emits nothing',
      build: PingBloc.new,
      act: (bloc) => bloc.add(const SelectedPing()),
      expect: () => <PingState>[],
    );
  });
}
*/