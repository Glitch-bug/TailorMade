import 'package:mocktail/mocktail.dart';
import 'package:tailor_made/core/constants/enums.dart';
import 'package:tailor_made/features/client/domain/repositories/client_repository.dart';
import 'package:tailor_made/features/client/domain/usecases/edit_client.dart';

class MockClientRepository extends Mock implements ClientRepository {

}


void registerFallbackValues() {
  registerFallbackValue( Gender.male,);
}