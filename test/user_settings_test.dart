import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/user_settings.dart';

void main() {
  test('UserSettings has correct default values', () {
    const settings = UserSettings();

    expect(settings.address, isEmpty);
    expect(settings.email, isEmpty);
    expect(settings.patronNumber, isEmpty);
    expect(settings.receiveNews, isFalse);
  });

  test('UserSettings stores configured values', () {
    const settings = UserSettings(
      address: '10 Elm Road, Portsmouth',
      email: 'alex@example.com',
      patronNumber: '5678',
      receiveNews: true,
    );

    expect(settings.address, '10 Elm Road, Portsmouth');
    expect(settings.email, 'alex@example.com');
    expect(settings.patronNumber, '5678');
    expect(settings.receiveNews, isTrue);
  });
}