import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/main.dart';

void main() {
  testWidgets(
    'Complete booking flow and book a different movie',
    (WidgetTester tester) async {
      await tester.pumpWidget(const SouthseaCinemaApp());

      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.text('Dracula'), findsOneWidget);
      expect(find.text('Taken'), findsOneWidget);

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
}