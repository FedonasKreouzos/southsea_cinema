import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:southsea_cinema/views/settings_view.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
  });

  testWidgets(
    'Settings screen displays form fields and switch',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SettingsView(),
        ),
      );

      await tester.pumpAndSettle();

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

      await tester.pumpAndSettle();

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

  testWidgets(
    'Saved settings are loaded when the settings page reopens',
    (WidgetTester tester) async {
      final preferences = SharedPreferencesAsync();

      await preferences.setString(
        'customer_address',
        '10 Elm Road, Portsmouth',
      );
      await preferences.setString(
        'customer_email',
        'alex@example.com',
      );
      await preferences.setString(
        'customer_patron_number',
        '5678',
      );
      await preferences.setBool(
        'customer_receive_news',
        false,
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: SettingsView(),
        ),
      );

      await tester.pumpAndSettle();

      expect(
        tester.widget<TextField>(find.byType(TextField).at(0))
            .controller!.text,
        '10 Elm Road, Portsmouth',
      );

      expect(
        tester.widget<TextField>(find.byType(TextField).at(1))
            .controller!.text,
        'alex@example.com',
      );

      expect(
        tester.widget<TextField>(find.byType(TextField).at(2))
            .controller!.text,
        '5678',
      );

      expect(
        tester.widget<Switch>(find.byType(Switch)).value,
        isFalse,
      );
    },
  );
}