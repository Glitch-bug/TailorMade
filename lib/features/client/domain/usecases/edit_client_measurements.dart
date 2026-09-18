import 'package:fpdart/fpdart.dart';
import 'package:tailor_made/features/client/domain/repositories/client_repository.dart';
import 'package:tailor_made/core/usecase/usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:tailor_made/core/error/failures.dart';

class EditClientMeasurements implements UseCase<void,EditMeasurementParams> {
  final ClientRepository clientRepository;
  const EditClientMeasurements(this.clientRepository);

  @override 
  Future <Either<Failure, void>> call(EditMeasurementParams params) async {
    return clientRepository.editClientMeasurements(id: params.id, measurements: params.measurements);
  }
}

class EditMeasurementParams extends Equatable {
  final String id;
  final Map <String, dynamic>? measurements;

  const EditMeasurementParams({required this.id, required this.measurements});

  @override 
  List<Object?> get props => [id, measurements];
}