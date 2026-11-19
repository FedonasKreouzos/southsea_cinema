import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/widgets/primary_button.dart';

void main() {
  testWidgets('PrimaryButton displays the correct label',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PrimaryButton(
            label: 'Book Now',
            onPressed: () {},
          ),
        ),
      ),
    );

    expect(find.text('Book Now'), findsOneWidget);
  });

  testWidgets('PrimaryButton calls onPressed when tapped',
      (WidgetTester tester) async {
    bool wasPressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PrimaryButton(
            label: 'Add to Order',
            onPressed: () {
              wasPressed = true;
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Add to Order'));

    expect(wasPressed, isTrue);
  });
}