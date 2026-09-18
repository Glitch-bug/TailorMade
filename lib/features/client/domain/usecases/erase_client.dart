import 'package:equatable/equatable.dart';
import 'package:tailor_made/core/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tailor_made/core/error/failures.dart';
import 'package:tailor_made/features/client/domain/repositories/client_repository.dart';


class EraseClient implements UseCase<void, IdParams> {
  final ClientRepository clientRepository;
  const EraseClient(this.clientRepository);

  @override
  Future<Either<Failure, void>> call(IdParams params) async {
    return await clientRepository.eraseClient(id: params.id);
  }
}


class IdParams extends Equatable {
  final String id;
  const IdParams({
    required this.id
  });

  @override
  List<Object> get props => [id];
}