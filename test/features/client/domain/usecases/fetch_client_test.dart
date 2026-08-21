import 'package:tailor_made/core/constants/enums.dart';
import 'package:tailor_made/core/error/failures.dart';
import 'package:tailor_made/core/usecase/usecase.dart';
import 'package:tailor_made/features/client/domain/entities/client.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tailor_made/features/client/domain/usecases/fetch_clients.dart';

import '../../../../helpers/mock_repositories.dart';


void main() {
  late FetchClients usecase;
  late MockClientRepository mockClientRepository;

  setUp((){
    mockClientRepository = MockClientRepository();
    usecase = FetchClients(mockClientRepository);
  });


  final clients = [
    Client(id:'1', firstName: 'Kobby', lastName:'Yiadom', phoneNumber: '0555598580', address: 'Kpone Shanghai', gender: Gender.male, email: 'kobby@gmail.com', dateAdded: DateTime.now()),
    Client(id:'2', firstName: 'Kofi', lastName:'Yiadom', phoneNumber: '0666698580', address: 'Tema C7', gender: Gender.male, email: 'kofi@gmail.com', dateAdded: DateTime.now()),
    Client(id:'3', firstName: 'KM', lastName:'Yiadom', phoneNumber: '0777798580', address: 'Accra, Airport Residential', gender: Gender.male, email: 'km@gmail.com', dateAdded: DateTime.now()),
  ];

  void arrangeReturn3Clients(){
    when(() => mockClientRepository.getClients()).thenAnswer((_) async => Right(clients));
  }

  void arrangeReturnFailure(){
    when(() => mockClientRepository.getClients()).thenAnswer((_) async => Left(Failure()));
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

  test('Should return a Failure when repository call fails', () async {
    arrangeReturnFailure();

    final result = await usecase(NoParams());
    expect(result, Left(Failure()));
    verify(() => mockClientRepository.getClients()).called(1);
    verifyNoMoreInteractions(mockClientRepository);
  });
}