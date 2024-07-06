import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../utils/testing_helper.dart';


void signUpTest1() {
  testWidgets("Form Validation Test", (WidgetTester tester) async {
    TestHelper.tester = tester;
    await TestHelper.pumpApp();
    await TestHelper.tapButton(finder: find.text('Sign up?'));
    await TestHelper.tapButton(name: 'Sign up');
    expect(find.text('Please Enter a valid Username'), findsOneWidget);
    expect(find.text('Please Enter a valid First Name'), findsOneWidget);
    expect(find.text('Please Enter a valid Last Name'), findsOneWidget);
    expect(find.text('Please Enter a valid Date of Birth'), findsOneWidget);
    expect(find.text('Please select a gender'), findsOneWidget);
    expect(find.text('Please Enter a valid Password'), findsNWidgets(2));
  });
}
