import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/main.dart';

void main() {
  testWidgets('Home page displays movie cards and booking buttons',
      (WidgetTester tester) async {
    await tester.pumpWidget(const SouthseaCinemaApp());
    await tester.pumpAndSettle();

    // Check the home page title
    expect(find.text('Southsea Cinema'), findsOneWidget);

    // Check that both movies are displayed
    expect(find.text('Dracula'), findsOneWidget);
    expect(find.text('Taken'), findsOneWidget);

    // Check that both Book Now buttons are displayed
    expect(find.text('Book Now'), findsNWidgets(2));
  });
}
