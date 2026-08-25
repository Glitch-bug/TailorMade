import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tailor_made/core/constants/enums.dart';
import 'package:tailor_made/core/error/failures.dart';
import '../../../../helpers/mock_repositories.dart';
import 'package:tailor_made/features/client/domain/usecases/save_client.dart';

void main() {
  late SaveClient usecase;
  late MockClientRepository mockClientRepository;

  setUp(() {
    mockClientRepository = MockClientRepository();
    usecase = SaveClient(mockClientRepository);
  });

  setUpAll((){
    registerFallbackValues();
  });

  void arrangeReturnNull() {
    when(
      () => mockClientRepository.addClient(
        firstName: any(named: 'firstName'),
        lastName: any(named: 'lastName'),
        phoneNumber: any(named: 'phoneNumber'),
        email: any(named: 'email'),
        gender: any(named: 'gender'),
        address: any(named: 'address'),
      ),
    ).thenAnswer((_) async => const Right(null));
  }

  void arrangeReturnFailure() {
    when(
      () => mockClientRepository.addClient(
        firstName: any(named: 'firstName'),
        lastName: any(named: 'lastName'),
        phoneNumber: any(named: 'phoneNumber'),
        email: any(named: 'email'),
        gender: any(named: 'gender'),
        address: any(named: 'address'),
      ),
    ).thenAnswer((_) async => const Left(LocalStorageFailure()));
  }

  const clientParams = ClientParams(
      firstName: 'Ben',
      lastName: 'Dover',
      phoneNumber: '02411116666',
      email: 'BenDover@gmail.com',
      address: 'Memory Lane',
      gender: Gender.male);

  group('Should return', () {
    test('null when successful', () async {
      arrangeReturnNull();

      final result = await usecase(clientParams);

      expect(result, const Right(null));
      verify(() => mockClientRepository.addClient(
        firstName: any(named: 'firstName'),
        lastName: any(named: 'lastName'),
        phoneNumber: any(named: 'phoneNumber'),
        email: any(named: 'email'),
        gender: any(named: 'gender'),
        address: any(named: 'address'),
      )).called(1);
      verifyNoMoreInteractions(mockClientRepository);
    });

    test('Failure upon failure', ()async {
      arrangeReturnFailure();

      final result = await usecase(clientParams);

      expect(result, const Left(LocalStorageFailure()));

      verify(() => mockClientRepository.addClient(
        firstName: any(named: 'firstName'),
        lastName: any(named: 'lastName'),
        phoneNumber: any(named: 'phoneNumber'),
        email: any(named: 'email'),
        gender: any(named: 'gender'),
        address: any(named: 'address'),
      )).called(1);
      verifyNoMoreInteractions(mockClientRepository);
    });
  });
}
