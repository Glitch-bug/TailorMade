import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tailor_made/core/constants/enums.dart';
import 'package:tailor_made/core/error/exceptions.dart';
import 'package:tailor_made/core/error/failures.dart';
import 'package:tailor_made/core/extensions/datetime_extension.dart';
import 'package:tailor_made/features/client/data/models/client_model.dart';
import 'package:tailor_made/features/client/data/repositories/client_repository_impl.dart';
import 'package:tailor_made/features/client/data/datasources/client_local_datasource.dart';
import 'package:tailor_made/features/client/domain/entities/client.dart';
import 'package:uuid/uuid.dart';

import '../../../../fixtures/fixtures.dart' ;
import '../../../../helpers/mock_repositories.dart';

class MockClientLocalDataSource extends Mock implements ClientLocalDataSource {}

class MockUuid extends Mock implements Uuid {}

void main() {
  late ClientRepositoryImpl repositoryImpl;
  late MockClientLocalDataSource mockClientLocalDataSource;
  late MockUuid mockUuid;

  const String errorMessage = "An unexpected local storage error occured";

  final clientModels = [
    ClientModel(
        id: '1',
        firstName: 'Kobby',
        lastName: 'Yiadom',
        phoneNumber: '0555598580',
        address: 'Kpone Shanghai',
        gender: Gender.male,
        email: 'kobby@gmail.com',
        dateAdded: DateTime.now().format()),
    ClientModel(
        id: '2',
        firstName: 'Kofi',
        lastName: 'Yiadom',
        phoneNumber: '0666698580',
        address: 'Tema C7',
        gender: Gender.male,
        email: 'kofi@gmail.com',
        dateAdded: DateTime.now().format()),
    ClientModel(
        id: '3',
        firstName: 'KM',
        lastName: 'Yiadom',
        phoneNumber: '0777798580',
        address: 'Accra, Airport Residential',
        gender: Gender.male,
        email: 'km@gmail.com',
        dateAdded: DateTime.now().format()),
  ];

  setUpAll((){
    registerFallbackValues();
    mockUuid = MockUuid();
  });

  setUp(() {
    mockClientLocalDataSource = MockClientLocalDataSource();
    repositoryImpl = ClientRepositoryImpl(mockClientLocalDataSource, mockUuid);
  });

  

  group('addClient', () {
    
    void arrangeReturnNull() async {
      when(() => mockUuid.v4()).thenReturn('1');

      when(() =>
              mockClientLocalDataSource.addClient(client: any(named: 'client')))
          .thenAnswer((_) async {});
    }

    void arrangeThrowException() async {
      when(() => mockUuid.v4()).thenReturn('0cbeec6b-72a8-4932-93d4-80fa3720ab82');

      when(() =>
              mockClientLocalDataSource.addClient(client: any(named: 'client')))
          .thenThrow(const LocalStorageException(errorMessage));
    }

    test('returns null on success', ()async {
      arrangeReturnNull();
      final result = await repositoryImpl.addClient(
        firstName: client.firstName,
        lastName: client.lastName,
        email: client.email,
        address: client.address,
        phoneNumber: client.phoneNumber,
        gender: client.gender,
      );

      expect(result, const Right(null));
      verify(() => mockClientLocalDataSource.addClient(client: ClientModel.fromEntity(client))).called(1);
      verifyNoMoreInteractions(mockClientLocalDataSource);
    });

    test('returns LocalStorageFailure on failure', () async{
      arrangeThrowException();
      final result = await repositoryImpl.addClient(
        firstName: client.firstName,
        lastName: client.lastName,
        email: client.email,
        address: client.address,
        phoneNumber: client.phoneNumber,
        gender: client.gender,
      );
      // print(result);
      expect(result, equals(const Left(LocalStorageFailure(errorMessage))));
      // verify(() => mockClientLocalDataSource.addClient(client: clientModels.first)).called(1);
      // verifyNoMoreInteractions(mockClientLocalDataSource);
    });
  });

  group('editClient', () {
    void arrangeReturnNull() async {
      when(() => mockClientLocalDataSource.editClient(
              client: any(named: 'client')))
          .thenAnswer((_) async {});
    }

    void arrangeThrowException() async {
      when(() => mockClientLocalDataSource.editClient(
              client: any(named: 'client')))
          .thenThrow(const LocalStorageException(errorMessage));
    }

    test('returns null on success', () async {
      arrangeReturnNull();
      final result = await repositoryImpl.editClient(
        id: client.id,
        firstName: client.firstName,
        lastName: client.lastName,
        email: client.email,
        address: client.address,
        phoneNumber: client.phoneNumber,
        gender: client.gender,
      );

      expect(result, const Right(null));
      verify(() => mockClientLocalDataSource.editClient(client: ClientModel.fromEntity(client))).called(1);
      verifyNoMoreInteractions(mockClientLocalDataSource);
    });

    test('returns LocalStorageFailure on failure', ()async {
      arrangeThrowException();
      final result = await repositoryImpl.editClient(
        id: client.id,
        firstName: client.firstName,
        lastName: client.lastName,
        email: client.email,
        address: client.address,
        phoneNumber: client.phoneNumber,
        gender: client.gender,
      );

      expect(result, const Left(LocalStorageFailure(errorMessage)));
      // verify(() => mockClientLocalDataSource.editClient(client: ClientModel.fromEntity(client))).called(1);
      // verifyNoMoreInteractions(mockClientLocalDataSource);
    });
  });

  group('getClients', () {
    void arrangeReturn3Clients() {
      when(() => mockClientLocalDataSource.getClients())
          .thenAnswer((_) async => clientModels);
    }

    void arrangeThrowException() {
      when(() => mockClientLocalDataSource.getClients()).thenThrow(const LocalStorageException(errorMessage));
    }

    test('should return a list of 3 clients  on success', () async{
      arrangeReturn3Clients();
      final result = await repositoryImpl.getClients();

      expect(result.isRight(), true);
      final actual = (result as Right<Failure, List<Client>>).value;
      expect(actual, equals(clients));
      verify(() => mockClientLocalDataSource.getClients()).called(1);
      verifyNoMoreInteractions(mockClientLocalDataSource);
    });

    test('returns LocalStorageFailure on failure', ()async {
      arrangeThrowException();
      final result = await repositoryImpl.getClients();

      expect(result, equals(const Left(LocalStorageFailure(errorMessage))));
      verify(() => mockClientLocalDataSource.getClients()).called(1);
      verifyNoMoreInteractions(mockClientLocalDataSource);
    });
  });

  group('eraseClient', () {
    void arrangeReturnNull(){
      when(() => mockClientLocalDataSource.eraseClient(id: any(named:"id"))).thenAnswer(
        (_) async => {}
      ); 
    }

    void arrangeThrowException () {
      when(() => mockClientLocalDataSource.eraseClient(id:any(named:"id"))).thenThrow(
        const LocalStorageException(errorMessage)
      );
    }

    test(' should return null on success', ()async{
      arrangeReturnNull();

      final result = await repositoryImpl.eraseClient(id: "1");

      expect(result, equals(const Right(null)));
      verify(() => mockClientLocalDataSource.eraseClient(id: "1")).called(1);
      verifyNoMoreInteractions(mockClientLocalDataSource);
    });


    test(" should return LocalStorageFailure on exception", ()async{
      arrangeThrowException();

      final result = await repositoryImpl.eraseClient(id:"1");

      expect(result, equals(const Left(LocalStorageFailure(errorMessage))));

      verify(()  => mockClientLocalDataSource.eraseClient(id:"1")).called(1);
      verifyNoMoreInteractions(mockClientLocalDataSource);
    });
  });


  group('editClientMeasurements', (){
    void arrangeReturnNull(){
      when(() => mockClientLocalDataSource.editClientMeasurements(id: any(named:"id"), measurements: any(named:"measurements"))).thenAnswer(
        (_) async => {});
    }

    void arrangeThrowException() {
      when(() => mockClientLocalDataSource.editClientMeasurements(id: any(named:"id"), measurements: any(named:"measurements"))).thenThrow(const LocalStorageException(errorMessage));
    }


    test(' should return null on success', ()async{
      arrangeReturnNull();

      final result = await repositoryImpl.editClientMeasurements(id: "1", measurements: {"red": "herring"});

      expect(result, const Right(null));

      verify(() => mockClientLocalDataSource.editClientMeasurements(id: "1", measurements: {"red": "herring"}));
      verifyNoMoreInteractions(mockClientLocalDataSource);
    });


    test(' should return LocalStorageFailure on exception', ()async{
      arrangeThrowException();

      final result = await repositoryImpl.editClientMeasurements(id: "1", measurements: {"red": "herring"});

      expect(result, const Left(LocalStorageFailure(errorMessage)));

      verify(() => mockClientLocalDataSource.editClientMeasurements(id: "1", measurements: {"red": "herring"}));
      verifyNoMoreInteractions(mockClientLocalDataSource);
    });
  });


  group('saveClientMeasurments', (){
    void arrangeReturnNull(){
      when(() => mockClientLocalDataSource.saveClientMeasurements(id: any(named: "id"), measurements: any(named:"measurements"))).thenAnswer((_) async => {});
    }

    void arrangeThrowException(){
      when(() => mockClientLocalDataSource.saveClientMeasurements(id: any(named: "id"), measurements: any(named:"measurements"))).thenThrow(const LocalStorageException(errorMessage));
    }


    test(' should return null on success',()async{
      arrangeReturnNull();

      final result = await repositoryImpl.saveClientMeasurements(id: "1", measurements: {"red":"herring"});

      expect(result, const Right(null));
      verify(() => mockClientLocalDataSource.saveClientMeasurements(id: "1", measurements: {"red":"herring"})).called(1);
      verifyNoMoreInteractions(mockClientLocalDataSource);
    });
    test(' should return LocalStorageFailure on exception', ()async{
      arrangeThrowException();


      final result = await repositoryImpl.saveClientMeasurements(id: "1", measurements: {"red":"herring"});

      expect(result, const Left(LocalStorageFailure(errorMessage)));
      verify(() => mockClientLocalDataSource.saveClientMeasurements(id: "1", measurements: {"red":"herring"})).called(1);
      verifyNoMoreInteractions(mockClientLocalDataSource);
    });
  });

}
