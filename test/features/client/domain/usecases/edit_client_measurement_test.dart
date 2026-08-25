import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tailor_made/features/client/domain/usecases/edit_client_measurements.dart';
import 'package:tailor_made/core/error/failures.dart';
import '../../../../helpers/mock_repositories.dart';

void main(){
  late EditClientMeasurements usecase;
  late MockClientRepository mockClientRepository;

  setUp((){
    mockClientRepository = MockClientRepository();
    usecase = EditClientMeasurements(mockClientRepository);
  });

  void arrangeReturnNull(){
    when(() => mockClientRepository.editClientMeasurements(id: any(named: 'id'), measurements: any(named: 'measurements'))).thenAnswer((_) async => const Right(null));
  }

  void arrangeReturnFailure(){
    when(() => mockClientRepository.editClientMeasurements(id: any(named: 'id'), measurements: any(named: 'measurements'))).thenAnswer((_) async => const Left(LocalStorageFailure()));
  }

  final editClientMeasurementParams = EditMeasurementParams(
    id: '1',
    measurements: {'red': 'herring'},
  );


  group('Should return',(){
    test(' null on success',()async{
      arrangeReturnNull();

      final result = await usecase(editClientMeasurementParams);

      expect(result, const Right(null));

      verify(() => mockClientRepository.editClientMeasurements(id: any(named:'id'), measurements: any(named: 'measurements'))).called(1);
      verifyNoMoreInteractions(mockClientRepository);
    });

    test(' Failure upon failure',()async{
      arrangeReturnFailure();

      final result = await usecase(editClientMeasurementParams);
      expect(result, const Left(LocalStorageFailure()));

      verify(() => mockClientRepository.editClientMeasurements(id: any(named: 'id'), measurements: any(named: 'measurements'))).called(1);
      verifyNoMoreInteractions(mockClientRepository);
    });
  });

}