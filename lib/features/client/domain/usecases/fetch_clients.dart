import 'package:fpdart/fpdart.dart';
import 'package:tailor_made/core/usecase/usecase.dart';
import 'package:tailor_made/features/client/domain/entities/client.dart';
import 'package:tailor_made/features/client/domain/repositories/client_repository.dart';
import 'package:tailor_made/core/error/failures.dart';


class FetchClients implements UseCase<List<Client>, NoParams> {
  final ClientRepository clientRepository;
  const FetchClients(this.clientRepository);

  @override 
  Future<Either<Failure, List<Client>>> call(NoParams params) async {
    return await clientRepository.getClients();
  }
}