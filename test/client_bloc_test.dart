import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/src/either.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tailor_made/core/error/failures.dart';
import 'package:tailor_made/features/client/domain/repositories/client_repository.dart';
import 'package:tailor_made/features/client/domain/usecases/save_client.dart';
import 'package:tailor_made/features/client/domain/usecases/fetch_clients.dart';
import 'package:tailor_made/features/client/domain/usecases/erase_client.dart';
import 'package:tailor_made/features/client/domain/usecases/edit_client.dart';
import 'package:tailor_made/features/client/domain/usecases/edit_client_measurements.dart';
import 'package:tailor_made/features/client/domain/usecases/save_client_measurements.dart';
import 'package:tailor_made/features/client/presentation/bloc/client_bloc.dart';


class MockSaveClient extends Mock implements SaveClient {
}

class MockFetchClients extends Mock implements FetchClients {}
class MockEraseClient extends Mock implements EraseClient {}
class MockEditClient extends Mock implements EditClient {}
class MockEditClientMeasurements extends Mock implements EditClientMeasurements {}
class MockSaveClientMeasurements extends Mock implements SaveClientMeasurements {}
void main() {
  late ClientBloc sut;
  late MockSaveClient mockSaveClient;
  late MockEditClient mockEditClient;
  late MockEditClientMeasurements mockEditClientMeasurements;
  late MockFetchClients mockFetchClients;
  late MockEraseClient mockEraseClient;
  late MockSaveClientMeasurements mockSaveClientMeasurements;
  

  setUp((){
    mockSaveClient = MockSaveClient();
    mockEraseClient = MockEraseClient();
    mockFetchClients = MockFetchClients();
    mockEditClient = MockEditClient();
    mockEditClientMeasurements = MockEditClientMeasurements();
    mockSaveClientMeasurements = MockSaveClientMeasurements();


    sut = ClientBloc(
      saveClient: mockSaveClient,
      fetchClients: mockFetchClients,
      eraseClient: mockEraseClient,
      editClient: mockEditClient,
      editClientMeasurements: mockEditClientMeasurements,
      saveMeasurements: mockSaveClientMeasurements,
    );
  });


  group('Test Client Save',(){

    
  });

}