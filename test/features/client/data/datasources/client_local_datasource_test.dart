
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tailor_made/core/error/exceptions.dart';
import 'package:tailor_made/features/client/data/datasources/client_local_datasource.dart';
import 'package:tailor_made/features/client/data/models/client_model.dart';

import '../../../../fixtures/fixtures.dart';
import '../../../../helpers/mock_repositories.dart';

class MockBox extends Mock implements Box<ClientModel> {}

void main() {
  late ClientLocalDataSourceImpl dataSource;
  late MockBox mockBox;

  setUp(() {
    mockBox = MockBox();
    dataSource = ClientLocalDataSourceImpl(mockBox);
  });

  setUpAll(() {
    registerFallbackValues();
  });

  void arrangeReturnNull() async {
    when(() => mockBox.get(any())).thenAnswer((_) => clientModel);
    when(() => mockBox.put(any(), any())).thenAnswer((_) async {});
  }

  void arrangeReturnMeasurementsNull() {
    when(() => mockBox.get(any())).thenReturn(clientModelMeasurements);
    when(() => mockBox.put(any(), any())).thenAnswer((_) async => {});
  }

  void arrangeGetReturnNull() async {
    when(() => mockBox.get(any())).thenReturn(null);
    when(() => mockBox.put(any(), any())).thenAnswer((_) async {});
  }

  void arrangeThrowPutException() {
    when(() => mockBox.get(any())).thenAnswer((_) => clientModel);
    when(() => mockBox.put(any(), any())).thenThrow(Exception("write failed"));
  }

  void arrangeThrowPutMeasurementsException() {
    when(() => mockBox.put(any(), any())).thenThrow(Exception("Write Error!"));
    when(() => mockBox.get(any())).thenReturn(clientModelMeasurements);
  }

  void arrangeReturn3ClientModels() {
    when(() => mockBox.values.toList()).thenReturn(clientModels);
  }

  void arrangeThrowException() {
    when(() => mockBox.values.toList()).thenThrow(Exception('Read Error!'));
  }

  void arrangeDeleteReturnNull() {
    when(() => mockBox.delete(any())).thenAnswer((_) async => {});
  }

  void arrangeDeleteThrowException() {
    when(() => mockBox.delete(any())).thenThrow(Exception());
  }

  group('Add Client', () {
    // void arrangeReturnNull() async {
    //   when(() => mockBox.put(any(), any())).thenAnswer((_) async {});
    // }

    // void arrangeThrowException() async {
    //   when(() => mockBox.put(any(), any()))
    //       .thenThrow(Exception("write failed"));
    // }

    test('should call box.put with correct client', () async {
      arrangeReturnNull();

      await dataSource.addClient(client: clientModel);
      verify(() => mockBox.put(clientModel.id, clientModel));
      verifyNoMoreInteractions(mockBox);
    });

    test('should throw LocalStorageException  when box.put fails', () async {
      arrangeThrowPutException();

      expect(() => dataSource.addClient(client: clientModel),
          throwsA(isA<LocalStorageException>()));
      verify(() => mockBox.put(clientModel.id, clientModel)).called(1);
      verifyNoMoreInteractions(mockBox);
    });
  });

  group('Edit Client', () {
    test('should return LocalStorageException when box.put fails', () {
      arrangeThrowPutException();

      expect(
          () => dataSource.editClient(
              client: clientModel.copyWith(firstName: "Benjamin Kudjo")),
          throwsA(isA<LocalStorageException>()));
      verify(() => mockBox.get(clientModel.id)).called(1);
      verify(() => mockBox.put(clientModel.id,
          clientModel.copyWith(firstName: "Benjamin Kudjo"))).called(1);
      verifyNoMoreInteractions(mockBox);
    });

    test("should return LocalStorageException when the client doesn't exist",
        () async {
      arrangeGetReturnNull();

      expect(() => dataSource.editClient(client: clientModel),
          throwsA(isA<LocalStorageException>()));
      verify(() => mockBox.get(clientModel.id)).called(1);
      verifyNoMoreInteractions(mockBox);
    });

    test('should query the right client and pass the correct client to box.put',
        () async {
      arrangeReturnNull();

      await dataSource.editClient(client: clientModel);
      verify(() => mockBox.get(clientModel.id)).called(1);
      verify(() => mockBox.put(clientModel.id, clientModel)).called(1);
      verifyNoMoreInteractions(mockBox);
    });
  });

  group('Get Clients', () {
    test('should return list of client models provided by box.values',
        () async {
      arrangeReturn3ClientModels();

      final result = await dataSource.getClients();

      expect(result, clientModels);
      verify(() => mockBox.values.toList()).called(1);
      verifyNoMoreInteractions(mockBox);
    });

    test('should throw LocalStorage exception when box.values fails', () async {
      arrangeThrowException();

      expect(
          () => dataSource.getClients(), throwsA(isA<LocalStorageException>()));
      verify(() => mockBox.values.toList()).called(1);
      verifyNoMoreInteractions(mockBox);
    });
  });

  group('Erase Client', () {
    test('should pass the right client id to box.delete', () async {
      arrangeDeleteReturnNull();
      // expect(() async => await dataSource.eraseClient(id: "1"), isA<Future<void>>());

      await dataSource.eraseClient(id: "1");

      verify(() => mockBox.delete("1")).called(1);
      verifyNoMoreInteractions(mockBox);
    });

    test('should return LocalStorageException if box.delete fails', () async {
      arrangeDeleteThrowException();

      expect(() async => await dataSource.eraseClient(id: "1"),
          throwsA(isA<LocalStorageException>()));
      verify(() => mockBox.delete("1")).called(1);
      verifyNoMoreInteractions(mockBox);
    });
  });

  group('Edit Client Measurements', () {
    test('should pass altered measurement values to box.put', () async {
      arrangeReturnMeasurementsNull();

      await dataSource.editClientMeasurements(
        id: clientModelMeasurements.id,
        measurements: fixture("alt_measurements.json"),
      );
      verify(() => mockBox.get(clientModelMeasurements.id)).called(1);
      verify(
        () => mockBox.put(
          clientModelMeasurements.id,
          clientModelMeasurements.copyWith(
            measurements: fixture("alt_measurements.json"),
          ),
        ),
      ).called(1);
      verifyNoMoreInteractions(mockBox);
    });

    test('should throw LocalStorageException when box.get returns null',
        () async {
      arrangeGetReturnNull();

      expect(
          () async => await dataSource.editClientMeasurements(
                id: clientModelMeasurements.id,
                measurements: fixture("alt_measurements.json"),
              ),
          throwsA(isA<LocalStorageException>()));
      verify(() => mockBox.get(clientModelMeasurements.id)).called(1);
      verifyNever(
        () => mockBox.put(
          clientModelMeasurements.id,
          clientModelMeasurements.copyWith(
            measurements: fixture("alt_measurements.json"),
          ),
        ),
      );
      verifyNoMoreInteractions(mockBox);
    });

    test('should throw LocalStorageException when box.put fails', () {
      arrangeThrowPutMeasurementsException();

      expect(
          () async => await dataSource.editClientMeasurements(
                id: clientModelMeasurements.id,
                measurements: fixture("alt_measurements.json"),
              ),
          throwsA(isA<LocalStorageException>()));
      verify(() => mockBox.get(clientModelMeasurements.id)).called(1);
      verify(
        () => mockBox.put(
          clientModelMeasurements.id,
          clientModelMeasurements.copyWith(
            measurements: fixture("alt_measurements.json"),
          ),
        ),
      ).called(1);
      verifyNoMoreInteractions(mockBox);
    });
  });
  group('Save Client Measurements', () {


    test('should pass the correct measurement values to box.put', () async {
      arrangeReturnNull();

      await dataSource.saveClientMeasurements(
        id: clientModel.id,
        measurements: fixture("alt_measurements.json"),
      );
      verify(() => mockBox.get(clientModel.id)).called(1);
      verify(
        () => mockBox.put(
          clientModel.id,
          clientModel.copyWith(
            measurements: fixture("alt_measurements.json"),
          ),
        ),
      ).called(1);
      verifyNoMoreInteractions(mockBox);
    });
    test('should throw LocalStorageException when box.get returns null', () {
      arrangeGetReturnNull();

      expect(
          () async => await dataSource.saveClientMeasurements(
                id: clientModel.id,
                measurements: fixture("alt_measurements.json"),
              ),
          throwsA(isA<LocalStorageException>()));
      verify(() => mockBox.get(clientModel.id)).called(1);
      verifyNever(
        () => mockBox.put(
          clientModel.id,
          clientModel.copyWith(
            measurements: fixture("alt_measurements.json"),
          ),
        ),
      );
      verifyNoMoreInteractions(mockBox);
    });
    test('should throw LocalStorageException when box.put fails', () {
      arrangeThrowPutException();

      expect(
          () async => await dataSource.saveClientMeasurements(
                id: clientModel.id,
                measurements: fixture("alt_measurements.json"),
              ),
          throwsA(isA<LocalStorageException>()));
      verify(() => mockBox.get(clientModel.id)).called(1);
      verify(
        () => mockBox.put(
          clientModel.id,
          clientModel.copyWith(
            measurements: fixture("alt_measurements.json"),
          ),
        ),
      ).called(1);
      verifyNoMoreInteractions(mockBox);
    });
  });
}
