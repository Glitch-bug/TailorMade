import 'package:mocktail/mocktail.dart';
import 'package:tailor_made/core/constants/enums.dart';
import 'package:tailor_made/core/extensions/datetime_extension.dart';
import 'package:tailor_made/features/client/data/models/client_model.dart';
import 'package:tailor_made/features/client/domain/repositories/client_repository.dart';
import 'package:tailor_made/features/client/domain/usecases/edit_client.dart';

class MockClientRepository extends Mock implements ClientRepository {}

void registerFallbackValues() {
  registerFallbackValue(
    Gender.male,
  );
  registerFallbackValue(
    ClientModel(
      id: '3',
      firstName: 'KM',
      lastName: 'Yiadom',
      phoneNumber: '0777798580',
      address: 'Accra, Airport Residential',
      gender: Gender.male,
      email: 'km@gmail.com',
      dateAdded: DateTime.now().format(),
    ),
  );
}
