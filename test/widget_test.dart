import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:southsea_cinema/main.dart';

void main() {
  testWidgets(
    'Complete booking flow and book a different movie',
    (WidgetTester tester) async {
      // Open the app
      await tester.pumpWidget(const SouthseaCinemaApp());
      await tester.pumpAndSettle();

      // Check the home page
      expect(find.text('Dracula'), findsOneWidget);
      expect(find.text('Taken'), findsOneWidget);

      // EXERCISE 6: Book Dracula
      await tester.tap(find.text('Book Now').first);
      await tester.pumpAndSettle();

      // Check Dracula's booking details
      expect(find.text('Dracula (15)'), findsOneWidget);
      expect(find.text('A classic horror film.'), findsOneWidget);
      expect(find.text('Screening Time: 18:00'), findsOneWidget);
      expect(find.text('Ticket Price: £8.50'), findsOneWidget);

      // Add tickets to the order
      await tester.tap(find.text('Add to Order'));
      await tester.pumpAndSettle();

      expect(
        find.text('0 ticket(s) added to order'),
        findsOneWidget,
      );

      // EXERCISE 7: Return to the home page
      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();

      // Confirm we are back on the home page
      expect(find.text('Dracula'), findsOneWidget);
      expect(find.text('Taken'), findsOneWidget);

      // Scroll down until Taken is visible
      await tester.scrollUntilVisible(
        find.text('Taken'),
        300,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.pumpAndSettle();

      // Book Taken
      await tester.tap(find.text('Book Now').last);
      await tester.pumpAndSettle();

      // Check Taken's booking details
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