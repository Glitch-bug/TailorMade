import 'package:tailor_made/core/usecase/usecase.dart';
import 'package:tailor_made/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tailor_made/features/client/domain/repositories/client_repository.dart';

class SaveClientMeasurements implements UseCase<void, MeasurementParams>{
  final ClientRepository clientRepository;
  const SaveClientMeasurements(this.clientRepository);

  @override 
  Future<Either<Failure, void>> call(MeasurementParams params) async {
    return await clientRepository.saveClientMeasurements(id: params.id, measurements: params.measurements);
  }


}

class MeasurementParams {
  final String id;
  final Map<String, dynamic> measurements;

  MeasurementParams({required this.id, required this.measurements});

}