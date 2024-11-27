import 'package:domain/domain.dart';
import 'package:domain/src/shared/exceptions/empty_param_exception.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {});
  group('Event', () {
    test('> create event with empty name > throws EmptyParamException', () {
      // Arrange
      const name = '';
      const data = 'data';

      // Act - Assert
      expect(
        () => Event(name: name, data: data),
        throwsA(isA<EmptyParamException>()),
      );
    });

    test('> create event with empty data > throws EmptyParamException', () {
      // Arrange
      const name = 'name';
      const data = '';

      // Act - Assert
      expect(
        () => Event(name: name, data: data),
        throwsA(isA<EmptyParamException>()),
      );
    });

    test('> create event with valid name and data > creates instance of Event',
        () {
      // Arrange
      const name = 'event';
      const data = 'information';

      // Act
      final event = Event(name: name, data: data);

      // Assert
      expect(
        event,
        isA<Event>()
            .having((e) => e.name, 'Event name', equals(name))
            .having((e) => e.data, 'Event data', equals(data)),
      );
    });
  });
}
