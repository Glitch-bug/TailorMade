import 'package:fpdart/fpdart.dart';
import 'package:tailor_made/features/client/domain/repositories/client_repository.dart';
import 'package:tailor_made/core/usecase/usecase.dart';
import 'package:tailor_made/core/error/failures.dart';

class EditClientMeasurements implements UseCase<void,EditMeasurementParams> {
  final ClientRepository clientRepository;
  const EditClientMeasurements(this.clientRepository);

  @override 
  Future <Either<Failure, void>> call(EditMeasurementParams params) async {
    return clientRepository.editClientMeasurements(id: params.id, measurements: params.measurements);
  }
}

class EditMeasurementParams {
  String id;
  Map <String, dynamic>? measurements;

  EditMeasurementParams({required this.id, required this.measurements});
}