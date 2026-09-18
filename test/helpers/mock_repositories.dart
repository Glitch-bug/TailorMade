import 'package:mocktail/mocktail.dart';
import 'package:tailor_made/core/constants/enums.dart';
import 'package:tailor_made/core/extensions/datetime_extension.dart';
import 'package:tailor_made/core/usecase/usecase.dart';
import 'package:tailor_made/features/client/domain/usecases/edit_client_measurements.dart';
import 'package:tailor_made/features/client/domain/usecases/erase_client.dart';
import 'package:tailor_made/features/client/domain/usecases/edit_client.dart';
import 'package:tailor_made/features/client/domain/usecases/save_client_measurements.dart';
import 'package:tailor_made/features/client/data/models/client_model.dart';
import 'package:tailor_made/features/client/domain/repositories/client_repository.dart';
import 'package:tailor_made/features/client/domain/usecases/save_client.dart';

import '../fixtures/fixtures.dart';

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

  registerFallbackValue(
    const ClientParams(
      firstName: 'KM',
      lastName: 'Yiadom',
      phoneNumber: '0777798580',
      address: 'Accra, Airport Residential',
      gender: Gender.male,
      email: 'km@gmail.com',
    ),
  );

  registerFallbackValue(NoParams());

  registerFallbackValue(const IdParams(id: '1'));

  registerFallbackValue(
      MeasurementParams(id: '1', measurements: fixture('measurements.json')));

  registerFallbackValue(
    const ClientEditParams(
      id: '1',
      firstName: 'KM',
      lastName: 'Yiadom',
      phoneNumber: '0777798580',
      address: 'Accra, Airport Residential',
      gender: Gender.male,
      email: 'km@gmail.com',
    ),
  );

  registerFallbackValue(EditMeasurementParams(
      id: '1', measurements: fixture('measurements.json')));
}
