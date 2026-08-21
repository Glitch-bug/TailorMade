import 'package:fpdart/fpdart.dart';
import 'package:tailor_made/core/constants/enums.dart';
import 'package:tailor_made/core/error/failures.dart';
import 'package:tailor_made/features/client/domain/usecases/edit_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../../helpers/mock_repositories.dart';

void main() {
  late EditClient usecase;
  late MockClientRepository mockClientRepository;

  setUp(() {
    mockClientRepository = MockClientRepository();
    usecase = EditClient(mockClientRepository);

  });
  
  setUpAll((){
    registerFallbackValues();
  });
  const failure = Failure();

  const clientEditParams =  ClientEditParams(
    id: '1',
    firstName: "Bob",
    lastName: "Brown",
    address: 'Lake Shore Drive',
    email: "bobby_brown@gmail.com",
    gender: Gender.male,
    phoneNumber: "03467987989",
  );

  void arrangeReturnNull() {
    when(
      () => mockClientRepository.editClient(
        id: any(named: 'id'),
        firstName: any(named: 'firstName'),
        lastName: any(named: 'lastName'),
        email: any(named: 'email'),
        phoneNumber: any(named: 'phoneNumber'),
        gender: any(named: 'gender'),
        address: any(named: 'address'),
      ),
    ).thenAnswer((_) async => const Right(null));
  }

  void arrangeReturnFailure() {
    when(
      () => mockClientRepository.editClient(
        id: any(named: 'id'),
        firstName: any(named: 'firstName'),
        lastName: any(named: 'lastName'),
        email: any(named: 'email'),
        phoneNumber: any(named: 'phoneNumber'),
        gender: any(named: 'gender'),
        address: any(named: 'address'),
      ),
    ).thenAnswer((_) async => Left(failure));
  }

  group('Should return ', () {
    test('null upon success', () async {
      arrangeReturnNull();

      final result = await usecase(clientEditParams);

      expect(result, const Right(null));
      verify(
        () => mockClientRepository.editClient(
            id: '1',
            firstName: "Bob",
            lastName: "Brown",
            address: 'Lake Shore Drive',
            email: "bobby_brown@gmail.com",
            gender: Gender.male,
            phoneNumber: "03467987989"),
      ).called(1);
      verifyNoMoreInteractions(mockClientRepository);
    });
    test('Failure when the call fails', () async {
      arrangeReturnFailure();

      final result = await usecase(clientEditParams);

      expect(result, const Left(Failure()));

      verify(
        () => mockClientRepository.editClient(
            id: '1',
            firstName: "Bob",
            lastName: "Brown",
            address: 'Lake Shore Drive',
            email: "bobby_brown@gmail.com",
            gender: Gender.male,
            phoneNumber: "03467987989"),
      ).called(1);

      verifyNoMoreInteractions(mockClientRepository);
    });
  });
}
