import 'package:flutter_test/flutter_test.dart';
import 'package:tailor_made/features/client/domain/entities/client.dart';
import 'package:tailor_made/features/client/data/models/client_model.dart';
import 'package:tailor_made/core/constants/enums.dart';
import '../../../../fixtures/fixtures.dart';
void main() {

  final nullClient = Client(
    id: '1',
    firstName: 'Kobby',
    lastName: 'Yiadom',
    address: 'Memory Lane',
    phoneNumber: '05555987898',
    gender: Gender.male,
    email: 'kobby234@gmail.com',
    dateAdded: DateTime.now(),
    measurements: null,
  );

  group('ClientModel entity conversion', () {
    test('fromEntity -> toEntity round trip preserves data', () {
      final model = ClientModel.fromEntity(client);
      final result = model.toEntity();

      expect(result, client);
    });

    test('handles null measurements', () async {
      final model = ClientModel.fromEntity(nullClient);
      expect(model.toEntity().measurements, isNull);
    });
  });

  group('ClientModel JSON', () {
    test('toJson -> fromJson round trip preserves measurements', () {
      final model = ClientModel.fromEntity(clientMeasurements);
      final json = model.toJson();
      final result = ClientModel.fromJson(json);

      expect(result.measurements, model.measurements);
    });
  });
}
