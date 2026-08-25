import 'package:mocktail/mocktail.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tailor_made/core/error/failures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tailor_made/features/client/domain/usecases/save_client_measurements.dart';
import '../../../../helpers/mock_repositories.dart';


void main() {
  late SaveClientMeasurements usecase;
  late MockClientRepository mockClientRepository;

  setUp((){
    mockClientRepository = MockClientRepository();
    usecase = SaveClientMeasurements(mockClientRepository);
  });

  void arrangeReturnsNull(){
    when(() => mockClientRepository.saveClientMeasurements(id: any(named:'id'), measurements: any(named: 'measurements') )).thenAnswer((_) async => const Right(null));
  }

  void arrangeReturnsFailure(){
    when(() => mockClientRepository.saveClientMeasurements(id: any(named:'id'), measurements: any(named: 'measurements') )).thenAnswer((_) async => const Left(Failure()));
  }

  group('Should return', (){

    test('null upon success',()async {
      arrangeReturnsNull();

      final result = await usecase(MeasurementParams(id: '1', measurements: {'fox':'rabbits'}));
      expect(result, const Right(null));
      verify(() => mockClientRepository.saveClientMeasurements(id:any(named:'id'), measurements: any(named: 'measurements'),),).called(1);
      verifyNoMoreInteractions(mockClientRepository);
    });
    test('Failure upon failure', ()async {
      arrangeReturnsFailure();

      final result = await usecase(MeasurementParams(id: '1', measurements: {'fox':'rabbits'}));
      expect(result, const Left(Failure()));
      verify(() => mockClientRepository.saveClientMeasurements(id:any(named:'id'), measurements: any(named: 'measurements'),),).called(1);
      verifyNoMoreInteractions(mockClientRepository);
    });

  });

}