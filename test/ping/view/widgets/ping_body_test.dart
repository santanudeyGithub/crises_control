// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:crises_control/src/ping/ping.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PingBody', () {
    testWidgets('renders Text', (tester) async {
      await tester.pumpWidget(
        BlocProvider(
          create: (context) => PingBloc(),
          child: MaterialApp(home: PingListBody()),
        ),
      );

      expect(find.byType(Text), findsOneWidget);
    });
  });
}
