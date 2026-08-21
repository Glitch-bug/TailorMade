import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tailor_made/core/error/failures.dart';
import 'package:tailor_made/features/client/domain/usecases/erase_client.dart';
import '../../../../helpers/mock_repositories.dart';

void main() {
  late EraseClient usecase;
  late MockClientRepository mockClientRepository;

  setUp(() {
    mockClientRepository = MockClientRepository();
    usecase = EraseClient(mockClientRepository);
  });

  const id = IdParams(id: "1");

  void arrangeReturnNull() {
        when(()  =>  mockClientRepository.eraseClient(id: any(named: 'id')))
        .thenAnswer((_) async => const Right(null));
  }

  void arrangeReturnFailure() {
    when(() => mockClientRepository.eraseClient(id: any(named:'id'))).thenAnswer((_) async => Left(Failure()));
  }
  test('Should trigger clientRepository.eraseClient', () async {
    arrangeReturnNull();

    final result = await usecase(id) ;

    expect(result, const Right(null));
    verify(() => mockClientRepository.eraseClient(id:id.id)).called(1);
    verifyNoMoreInteractions(mockClientRepository);
  });

  test('Should return a Failure when repository call fails', () async {
    arrangeReturnFailure();
    const failure = Failure();
    

    final result = await usecase(id);

    expect(result, const Left(failure));
    verify(() => mockClientRepository.eraseClient(id: id.id)).called(1);
    verifyNoMoreInteractions(mockClientRepository);
  });


}
