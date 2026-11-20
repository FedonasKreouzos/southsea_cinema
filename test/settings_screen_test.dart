import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:southsea_cinema/views/settings_view.dart';

void main() {
  late SharedPreferencesAsync preferences;

  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
    preferences = SharedPreferencesAsync();
  });

  tearDown(() {
    SharedPreferencesAsyncPlatform.instance = null;
  });

  Future<void> openSettings(WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SettingsView(),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
  }

  testWidgets(
    'Settings screen displays form fields and switch',
    (WidgetTester tester) async {
      await openSettings(tester);

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
    'Saved preferences load when Settings screen opens',
    (WidgetTester tester) async {
      await preferences.setString(
        'customer_address',
        '10 Elm Road, Portsmouth',
      );
      await preferences.setString(
        'customer_email',
        'test@example.com',
      );
      await preferences.setString(
        'customer_patron_number',
        '5678',
      );
      await preferences.setBool(
        'customer_receive_news',
        false,
      );

      await openSettings(tester);

      expect(
        tester.widget<TextField>(find.byType(TextField).at(0)).controller!.text,
        '10 Elm Road, Portsmouth',
      );

      expect(
        tester.widget<TextField>(find.byType(TextField).at(1)).controller!.text,
        'test@example.com',
      );

      expect(
        tester.widget<TextField>(find.byType(TextField).at(2)).controller!.text,
        '5678',
      );

      expect(
        tester.widget<Switch>(find.byType(Switch)).value,
        isFalse,
      );
    },
  );

  testWidgets(
    'Editing and saving settings stores updated preferences',
    (WidgetTester tester) async {
      await openSettings(tester);

      await tester.enterText(
        find.byType(TextField).at(0),
        '20 New Road, Portsmouth',
      );

      await tester.enterText(
        find.byType(TextField).at(1),
        'new@example.com',
      );

      await tester.enterText(
        find.byType(TextField).at(2),
        '9876',
      );

      final switchFinder = find.byType(Switch);
      await tester.ensureVisible(switchFinder);
      await tester.tap(switchFinder);
      await tester.pump();

      final saveButton = find.text('SAVE SETTINGS');
      await tester.ensureVisible(saveButton);
      await tester.tap(saveButton);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(
        find.text('Settings saved successfully'),
        findsOneWidget,
      );

      expect(
        await preferences.getString('customer_address'),
        '20 New Road, Portsmouth',
      );

      expect(
        await preferences.getString('customer_email'),
        'new@example.com',
      );

      expect(
        await preferences.getString('customer_patron_number'),
        '9876',
      );

      expect(
        await preferences.getBool('customer_receive_news'),
        isFalse,
      );
    },
  );

  testWidgets(
    'Saved preferences remain available when Settings screen is reopened',
    (WidgetTester tester) async {
      await preferences.setString(
        'customer_address',
        '20 New Road, Portsmouth',
      );
      await preferences.setString(
        'customer_email',
        'new@example.com',
      );
      await preferences.setString(
        'customer_patron_number',
        '9876',
      );
      await preferences.setBool(
        'customer_receive_news',
        false,
      );

      await openSettings(tester);

      await tester.pumpWidget(const SizedBox.shrink());
      await openSettings(tester);

      expect(
        tester.widget<TextField>(find.byType(TextField).at(0)).controller!.text,
        '20 New Road, Portsmouth',
      );

      expect(
        tester.widget<TextField>(find.byType(TextField).at(1)).controller!.text,
        'new@example.com',
      );

      expect(
        tester.widget<TextField>(find.byType(TextField).at(2)).controller!.text,
        '9876',
      );

      expect(
        tester.widget<Switch>(find.byType(Switch)).value,
        isFalse,
      );
    },
  );
}