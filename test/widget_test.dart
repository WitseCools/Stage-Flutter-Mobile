// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:frontend/main.dart';
import 'package:frontend/providers/User.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:frontend/screens/log_in_screen.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Log In screen Render', (WidgetTester tester) async {
    Widget loginWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(home: new LogInScreen()));
    await tester.pumpWidget(loginWidget);

    var textGreet = find.text("Welcome,");
    var textLogin = find.text("Log in to continue");

    expect(textGreet, findsOneWidget);
    expect(textLogin, findsOneWidget);
    expect(find.byType(AuthCard), findsOneWidget);
    Text textGreetFind = tester.firstWidget(textGreet);
    expect(textGreetFind.style.color, HexColor("#222C4A"));
  });

  testWidgets('AuthCard', (WidgetTester tester) async {
    Widget loginWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(home: new AuthCard()));
    await tester.pumpWidget(Provider(create: (_) => 42, child: loginWidget));
    var textFieldEmail = find.byKey(ValueKey("Email"));
    var textFieldpass = find.byKey(ValueKey("Pass"));
    var button = find.byKey(ValueKey("Button"));

    await tester.tap(textFieldEmail);
    await tester.enterText(textFieldEmail, "witsecools@hotmail.com");
    await tester.tap(textFieldEmail);
    await tester.enterText(textFieldEmail, "admin");
    await tester.tap(button);

    var findHomeScreen = find.byWidget(HomeScreen());
    expect(textFieldEmail, findsWidgets);
    expect(textFieldpass, findsWidgets);
    expect(findHomeScreen, findsOneWidget);
  });
}
