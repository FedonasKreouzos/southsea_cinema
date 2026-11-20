import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/views/settings_view.dart';

void main() {
  testWidgets(
    'Settings screen displays form fields and switch',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SettingsView(),
        ),
      );

      expect(find.text('Address'), findsOneWidget);
      expect(find.text('Email Address'), findsOneWidget);
      expect(find.text('Patron Number'), findsOneWidget);
      expect(find.text('Preferences'), findsOneWidget);
      expect(find.byType(TextField), findsNWidgets(3));
      expect(find.byType(Switch), findsOneWidget);
      expect(find.text('SAVE SETTINGS'), findsOneWidget);
      expect(find.text('CANCEL'), findsOneWidget);
    },
  );

  testWidgets(
    'Editing fields and saving settings updates state',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SettingsView(),
        ),
      );

      final Finder addressField = find.byType(TextField).at(0);
      final Finder emailField = find.byType(TextField).at(1);
      final Finder patronField = find.byType(TextField).at(2);

      await tester.enterText(
        addressField,
        '10 Elm Road, Portsmouth',
      );

      await tester.enterText(
        emailField,
        'alex@example.com',
      );

      await tester.enterText(
        patronField,
        '5678',
      );

      final Finder switchFinder = find.byType(Switch);

      expect(
        tester.widget<Switch>(switchFinder).value,
        isTrue,
      );

      await tester.ensureVisible(switchFinder);
      await tester.tap(switchFinder);
      await tester.pumpAndSettle();

      expect(
        tester.widget<Switch>(switchFinder).value,
        isFalse,
      );

      final Finder saveButton = find.text('SAVE SETTINGS');

      await tester.ensureVisible(saveButton);
      await tester.tap(saveButton);
      await tester.pumpAndSettle();

      expect(
        find.text('Settings saved successfully'),
        findsOneWidget,
      );
    },
  );
}