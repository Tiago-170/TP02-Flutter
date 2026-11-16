// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gestion_utilisateur/main.dart';

void main() {
  testWidgets('Le champ téléphone accepte uniquement des chiffres', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    final phoneField = tester.widget<TextField>(find.byType(TextField).at(2));

    expect(phoneField.keyboardType, TextInputType.number);
    expect(phoneField.inputFormatters, isNotNull);
    expect(phoneField.inputFormatters, contains(isA<FilteringTextInputFormatter>()));
  });
}
