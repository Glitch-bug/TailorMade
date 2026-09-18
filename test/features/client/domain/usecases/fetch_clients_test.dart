import 'package:tailor_made/core/error/failures.dart';
import 'package:tailor_made/core/usecase/usecase.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tailor_made/features/client/domain/usecases/fetch_clients.dart';

import '../../../../fixtures/fixtures.dart';
import '../../../../helpers/mock_repositories.dart';


void main() {
  late FetchClients usecase;
  late MockClientRepository mockClientRepository;

  setUp((){
    mockClientRepository = MockClientRepository();
    usecase = FetchClients(mockClientRepository);
  });



  void arrangeReturn3Clients(){
    when(() => mockClientRepository.getClients()).thenAnswer((_) async => Right(clients));
  }

  void arrangeReturnFailure(){
    when(() => mockClientRepository.getClients()).thenAnswer((_) async => const Left(LocalStorageFailure()));
  }
  test('Should get clients from the repository', ()async{
    // arrange
    arrangeReturn3Clients();
    // act 
    final result = await usecase(NoParams());

    //assert 
    expect(result, Right(clients));
    verify(() => mockClientRepository.getClients()).called(1);
    verifyNoMoreInteractions(mockClientRepository);
  });

  test('Should return LocalStorageFailure when repository call fails', () async {
    arrangeReturnFailure();

    final result = await usecase(NoParams());
    expect(result, const Left(LocalStorageFailure()));
    verify(() => mockClientRepository.getClients()).called(1);
    verifyNoMoreInteractions(mockClientRepository);
  });
}