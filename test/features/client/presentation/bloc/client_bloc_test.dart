import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/src/either.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tailor_made/core/error/failures.dart';
import 'package:tailor_made/core/usecase/usecase.dart';
import 'package:tailor_made/features/client/domain/usecases/save_client.dart';
import 'package:tailor_made/features/client/domain/usecases/fetch_clients.dart';
import 'package:tailor_made/features/client/domain/usecases/erase_client.dart';
import 'package:tailor_made/features/client/domain/usecases/edit_client.dart';
import 'package:tailor_made/features/client/domain/usecases/edit_client_measurements.dart';
import 'package:tailor_made/features/client/domain/usecases/save_client_measurements.dart';
import 'package:tailor_made/features/client/presentation/bloc/client_bloc.dart';
import 'package:tailor_made/core/constants/enums.dart';
import 'package:tailor_made/core/constants/strings.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:tailor_made/core/utils/input_converter.dart';
import '../../../../fixtures/fixtures.dart';
import '../../../../helpers/mock_repositories.dart';

class MockSaveClient extends Mock implements SaveClient {}

class MockFetchClients extends Mock implements FetchClients {}

class MockEraseClient extends Mock implements EraseClient {}

class MockEditClient extends Mock implements EditClient {}

class MockEditClientMeasurements extends Mock
    implements EditClientMeasurements {}

class MockSaveClientMeasurements extends Mock
    implements SaveClientMeasurements {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  late ClientBloc bloc;
  late MockSaveClient mockSaveClient;
  late MockEditClient mockEditClient;
  late MockEditClientMeasurements mockEditClientMeasurements;
  late MockFetchClients mockFetchClients;
  late MockEraseClient mockEraseClient;
  late MockSaveClientMeasurements mockSaveClientMeasurements;
  late MockInputConverter mockInputConverter;

  setUp(() {
    mockSaveClient = MockSaveClient();
    mockEraseClient = MockEraseClient();
    mockFetchClients = MockFetchClients();
    mockEditClient = MockEditClient();
    mockEditClientMeasurements = MockEditClientMeasurements();
    mockSaveClientMeasurements = MockSaveClientMeasurements();
    mockInputConverter = MockInputConverter();

    bloc = ClientBloc(
      saveClient: mockSaveClient,
      fetchClients: mockFetchClients,
      eraseClient: mockEraseClient,
      editClient: mockEditClient,
      editClientMeasurements: mockEditClientMeasurements,
      saveMeasurements: mockSaveClientMeasurements,
      inputConverter: mockInputConverter,
    );
  });

  const gender = Gender.male;
  const String id = '1';
  final Map<String, dynamic> measurements = fixture('measurements.json');

  setUpAll(() {
    registerFallbackValues();
  });

  void arrangeInputConversion() {
    when(() => mockInputConverter.stringToGender(any()))
        .thenReturn(const Right(gender));
  }

  void arrangeFailureInputConversion() {
    when(() => mockInputConverter.stringToGender(any()))
        .thenReturn(const Left(InvalidInputFailure()));
  }

  group('ClientSave', () {
    void arrangeSaveClient() {
      when(() => mockSaveClient(any()))
          .thenAnswer((_) async => const Right(null));
    }

    void arrangeSaveClientFailure() {
      when(() => mockSaveClient(any()))
          .thenAnswer((_) async => const Left(LocalStorageFailure()));
    }

    blocTest(
        'should call the InputConverter to validate and convert the gender string to a Gender enum',
        build: () {
          arrangeInputConversion();

          arrangeSaveClient();

          return bloc;
        },
        act: (bloc) => bloc.add(ClientSave(
              firstName: client.firstName,
              lastName: client.lastName,
              gender: client.gender.value,
              phoneNumber: client.phoneNumber,
              email: client.email,
              address: client.address,
            )),
        expect: () => [ClientLoading(), ClientSaveSuccess()],
        verify: (_) {
          verify(() => mockInputConverter.stringToGender(client.gender.value))
              .called(1);
        });

    blocTest(
      'should emit [ClientLoading, ClientFailure] when input is invalid',
      build: () {
        arrangeFailureInputConversion();
        arrangeSaveClient();
        return bloc;
      },
      act: (bloc) => bloc.add(ClientSave(
        firstName: client.firstName,
        lastName: client.lastName,
        gender: client.gender.value,
        phoneNumber: client.phoneNumber,
        email: client.email,
        address: client.address,
      )),
      expect: () => [
        ClientLoading(),
        ClientFailure(AppStrings.invalidGender)
      ],
    );

    blocTest(
      'should emit [ClientLoading, ClientSaveSuccess] when input is valid',
      build: () {
        arrangeInputConversion();
        arrangeSaveClient();
        return bloc;
      },
      act: (bloc) => bloc.add(ClientSave(
        firstName: client.firstName,
        lastName: client.lastName,
        gender: client.gender.value,
        phoneNumber: client.phoneNumber,
        email: client.email,
        address: client.address,
      )),
      expect: () => [ClientLoading(), ClientSaveSuccess()],
      verify: (_) {
        verify(() => mockSaveClient(ClientParams(
            firstName: client.firstName,
            lastName: client.lastName,
            gender: client.gender,
            email: client.email,
            address: client.address,
            phoneNumber: client.phoneNumber))).called(1);
      },
    );

    blocTest(
      'should emit [ClientLoading, ClientFailure] when save fails',
      build: () {
        arrangeInputConversion();
        arrangeSaveClientFailure();
        return bloc;
      },
      act: (bloc) => bloc.add(ClientSave(
        firstName: client.firstName,
        lastName: client.lastName,
        gender: client.gender.value,
        phoneNumber: client.phoneNumber,
        email: client.email,
        address: client.address,
      )),
      expect: () =>
          [ClientLoading(), ClientFailure(AppStrings.localStorageFailure)],
    );
  });

  group('ClientFetchAll', () {
    void arrangeFetchClients() {
      when(() => mockFetchClients(any()))
          .thenAnswer((_) async => Right(clients));
    }

    void arrangeFetchEmpty() {
      when(() => mockFetchClients(any()))
          .thenAnswer((_) async => const Right([]));
    }

    void arrangeFetchFailure() {
      when(() => mockFetchClients(any()))
          .thenAnswer((_) async => const Left(LocalStorageFailure()));
    }

    blocTest(
        'should emit [ClientLoading, ClientDisplaySuccess] when clients are succesfully fetched',
        build: () {
          arrangeFetchClients();
          return bloc;
        },
        act: (bloc) => bloc.add(ClientFetchAll()),
        expect: () => [ClientLoading(), ClientDisplaySuccess(clients)],
        verify: (_) {
          verify(() => mockFetchClients(NoParams())).called(1);
        });

    blocTest(
        'should emit [ClientLoading, ClientDisplaySuccess] when empty list of clients are succesfully fetched',
        build: () {
          arrangeFetchEmpty();
          return bloc;
        },
        act: (bloc) => bloc.add(ClientFetchAll()),
        expect: () => [ClientLoading(), ClientDisplaySuccess([])],
        verify: (_) {
          verify(() => mockFetchClients(NoParams())).called(1);
        });

    blocTest(
      'should emit [ClientLoading, ClientFailure] when client fetch fails',
      build: () {
        arrangeFetchFailure();
        return bloc;
      },
      act: (bloc) => bloc.add(ClientFetchAll()),
      expect: () =>
          [ClientLoading(), ClientFailure(AppStrings.localStorageFailure)],
      verify: (_) {
        verify(() => mockFetchClients(NoParams())).called(1);
      },
    );

    group('ClientErase', () {
      void arrangeClientErase() {
        when(() => mockEraseClient(any()))
            .thenAnswer((_) async => const Right(null));
      }

      void arrangeClientEraseFailure() {
        when(() => mockEraseClient(any()))
            .thenAnswer((_) async => const Left(LocalStorageFailure()));
      }

      blocTest(
        'should emit [ClientLoading, ClientDeleteSucces] when client delete succeeds',
        build: () {
          arrangeClientErase();
          return bloc;
        },
        act: (bloc) => bloc.add(ClientErase(
          id: id,
        )),
        expect: () => [ClientLoading(), ClientDeleteSucces()],
        verify: (_) {
          verify(() => mockEraseClient(const IdParams(id: id))).called(1);
        },
      );

      blocTest(
        'should emit [ClientLoading, ClientFailure] when client delete fails',
        build: () {
          arrangeClientEraseFailure();
          return bloc;
        },
        act: (bloc) => bloc.add(ClientErase(id: id)),
        expect: () =>
            [ClientLoading(), ClientFailure(AppStrings.localStorageFailure)],
        verify: (_) {
          verify(() => mockEraseClient(const IdParams(id: id)));
        },
      );
    });
  });

  group('ClientMeasurementSave', () {
    void arrangeSaveMeasurements() {
      when(() => mockSaveClientMeasurements(any()))
          .thenAnswer((_) async => const Right(null));
    }

    void arrangeSaveMeasurementsFailure() {
      when(() => mockSaveClientMeasurements(any()))
          .thenAnswer((_) async => const Left(LocalStorageFailure()));
    }

    blocTest(
      'should emit [ClientLoading, ClientMeasurementsSaveSuccess] when client measurements are saved succesfully',
      build: () {
        arrangeSaveMeasurements();
        return bloc;
      },
      act: (bloc) => bloc.add(ClientMeasurementsSave(
        id: id,
        measurements: fixture("measurements.json"),
      )),
      expect: () => [ClientLoading(), ClientMeasurementsSaveSuccess()],
      verify: (_) {
        verify(
          () => mockSaveClientMeasurements(
            MeasurementParams(
              id: id,
              measurements: measurements,
            ),
          ),
        ).called(1);
      },
    );

    blocTest(
        'should emit [ClientLoading, ClientFailure] when saving client measurements  fails',
        build: () {
          arrangeSaveMeasurementsFailure();
          return bloc;
        },
        act: (bloc) => bloc
            .add(ClientMeasurementsSave(id: id, measurements: measurements)),
        expect: () =>
            [ClientLoading(), ClientFailure(AppStrings.localStorageFailure)],
        verify: (_) {
          verify(() => mockSaveClientMeasurements(MeasurementParams(
              id: id, measurements: fixture("measurements.json")))).called(1);
        });
  });

  group('ClientEdit', () {
    arrangeClientEdit() {
      when(() => mockEditClient(any()))
          .thenAnswer((_) async => const Right(null));
    }

    arrangeClientEditFailure() {
      when(() => mockEditClient(any()))
          .thenAnswer((_) async => const Left(LocalStorageFailure()));
    }

    blocTest(
        'should emit [ClientLoaading, ClientEditSuccess] when client measurements are successfully edited',
        build: () {
          arrangeInputConversion();
          arrangeClientEdit();
          return bloc;
        },
        act: (bloc) => bloc.add(
              ClientEdit(
                id: client.id,
                firstName: client.firstName,
                lastName: client.lastName,
                gender: client.gender.value,
                phoneNumber: client.phoneNumber,
                email: client.email,
                address: client.address,
              ),
            ),
        expect: () => [ClientLoading(), ClientEditSuccess()],
        verify: (_) {
          verify(() => mockEditClient(ClientEditParams(
                id: id,
                firstName: client.firstName,
                lastName: client.lastName,
                gender: client.gender,
                phoneNumber: client.phoneNumber,
                email: client.email,
                address: client.address,
              ))).called(1);
        });
    blocTest(
        'should emit [ClientLoaading, ClientFailure] when client edit fails',
        build: () {
          arrangeInputConversion();
          arrangeClientEditFailure();
          return bloc;
        },
        act: (bloc) => bloc.add(
              ClientEdit(
                id: client.id,
                firstName: client.firstName,
                lastName: client.lastName,
                gender: client.gender.value,
                phoneNumber: client.phoneNumber,
                email: client.email,
                address: client.address,
              ),
            ),
        expect: () =>
            [ClientLoading(), ClientFailure(AppStrings.localStorageFailure)],
        verify: (_) {
          verify(() => mockEditClient(ClientEditParams(
                id: id,
                firstName: client.firstName,
                lastName: client.lastName,
                gender: client.gender,
                phoneNumber: client.phoneNumber,
                email: client.email,
                address: client.address,
              ))).called(1);
        });

    blocTest(
        'should emit [ClientLoading, ClientFailure] when client gender conversion fails',
        build: () {
          arrangeFailureInputConversion();
          arrangeClientEdit();
          return bloc;
        },
        act: (bloc) => bloc.add(
              ClientEdit(
                id: client.id,
                firstName: client.firstName,
                lastName: client.lastName,
                gender: client.gender.value,
                phoneNumber: client.phoneNumber,
                email: client.email,
                address: client.address,
              ),
            ),
        expect: () =>
            [ClientLoading(), ClientFailure(AppStrings.invalidGender)],
        verify: (_) {
          verifyNever(
            () => mockEditClient(
              ClientEditParams(
                id: id,
                firstName: client.firstName,
                lastName: client.lastName,
                gender: client.gender,
                phoneNumber: client.phoneNumber,
                email: client.email,
                address: client.address,
              ),
            ),
          );
        });
  });

  group('ClientMeasurementsEdit', () {
    void arrangeClientMeasurementEdit() {
      when(() => mockEditClientMeasurements(any()))
          .thenAnswer((_) async => const Right(null));
    }

    void arrangeClientMeasurementEditFailure() {
      when(() => mockEditClientMeasurements(any())).thenAnswer((_) async =>
          const Left(LocalStorageFailure(AppStrings.localStorageFailure)));
    }

    blocTest(
        'should emit [ClientLoaading, ClientMeasurementEditSuccess] when client measurements are successfully edited',
        build: () {
          arrangeClientMeasurementEdit();
          return bloc;
        },
        act: (bloc) => bloc.add(ClientMeasurementsEdit(
              id: id,
              measurements: measurements,
            )),
        expect: () => [ClientLoading(), ClientMeasurementsEditSuccess()],
        verify: (_) {
          verify(() => mockEditClientMeasurements(
                  EditMeasurementParams(id: id, measurements: measurements)))
              .called(1);
        });
    blocTest(
        'should emit [ClientLoaading, ClientFailure] when client edit fails',
        build: () {
          arrangeClientMeasurementEditFailure();
          return bloc;
        },
        act: (bloc) => bloc.add(ClientMeasurementsEdit(
              id: id,
              measurements: measurements,
            )),
        expect: () =>
            [ClientLoading(), ClientFailure(AppStrings.localStorageFailure)],
        verify: (bloc) {
          verify(() => mockEditClientMeasurements(
                  EditMeasurementParams(id: id, measurements: measurements)))
              .called(1);
        });
  });
}
