import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/main.dart';

Future<void> loadHomeScreen(WidgetTester tester) async {
  await tester.pumpWidget(const SouthseaCinemaApp());

  for (int i = 0; i < 20; i++) {
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 100)),
    );
    await tester.pump();

    if (find.text('Dracula').evaluate().isNotEmpty &&
        find.text('Taken').evaluate().isNotEmpty) {
      return;
    }
  }

  final texts = find
      .byType(Text)
      .evaluate()
      .map((e) => (e.widget as Text).data)
      .toList();
  fail('Movies failed to load. Visible text: $texts');
}

Future<void> openBasket(WidgetTester tester) async {
  await tester.tap(find.byTooltip('Open navigation menu'));
  await tester.pumpAndSettle();

  await tester.tap(find.text('My Basket'));
  await tester.pumpAndSettle();
}

void main() {
  setUp(() {
    rootBundle.evict('assets/data/movies.json');
  });
  testWidgets(
    'Complete booking flow and book a different movie',
    (WidgetTester tester) async {
      await loadHomeScreen(tester);

      await tester.tap(find.text('Book Now').first);
      await tester.pumpAndSettle();

      expect(find.text('Dracula (15)'), findsOneWidget);
      expect(find.text('A classic horror film.'), findsOneWidget);
      expect(find.text('Screening Time: 18:00'), findsOneWidget);
      expect(find.text('Ticket Price: £8.50'), findsOneWidget);

      await tester.tap(find.text('Add to Order'));
      await tester.pumpAndSettle();

      expect(
        find.text('Please select at least one ticket'),
        findsOneWidget,
      );

      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();

      expect(find.text('Dracula'), findsOneWidget);
      expect(find.text('Taken'), findsOneWidget);

      await tester.scrollUntilVisible(
        find.text('Taken'),
        300,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Book Now').last);
      await tester.pumpAndSettle();

      expect(find.text('Taken (15)'), findsOneWidget);
      expect(
        find.text(
          'An action thriller about a father searching for his daughter.',
        ),
        findsOneWidget,
      );
      expect(find.text('Screening Time: 20:00'), findsOneWidget);
      expect(find.text('Ticket Price: £9.50'), findsOneWidget);
    },
  );

  testWidgets(
    'Customer can add, remove and complete a booking',
    (WidgetTester tester) async {
      await loadHomeScreen(tester);

      await tester.tap(find.text('Book Now').first);
      await tester.pumpAndSettle();

      final dropdown = find.byType(DropdownMenu<int>);

      await tester.tap(dropdown);
      await tester.pumpAndSettle();

      await tester.tap(find.text('2').last);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Add to Order'));
      await tester.pumpAndSettle();

      expect(find.text('2 ticket(s) added to basket'), findsOneWidget);

      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();

      await openBasket(tester);

      expect(find.text('2 Tickets'), findsOneWidget);
      expect(find.text('£17.00'), findsNWidgets(2));

      await tester.tap(find.byIcon(Icons.delete));
      await tester.pumpAndSettle();

      expect(find.text('Your basket is empty'), findsOneWidget);

      await tester.pageBack();
      await tester.pumpAndSettle();

      await tester.tap(find.text('Book Now').first);
      await tester.pumpAndSettle();

      await tester.tap(dropdown);
      await tester.pumpAndSettle();

      await tester.tap(find.text('2').last);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Add to Order'));
      await tester.pumpAndSettle();

      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();

      await openBasket(tester);

      await tester.tap(find.text('BUY TICKETS'));
      await tester.pumpAndSettle();

      expect(find.text('Booking Confirmed'), findsOneWidget);

      await tester.tap(find.text('Done'));
      await tester.pumpAndSettle();

      expect(find.text('Your basket is empty'), findsOneWidget);
    },
  );
}