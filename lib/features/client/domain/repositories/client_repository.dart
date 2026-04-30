import 'package:tailor_made/features/client/domain/entities/client.dart';
import 'package:tailor_made/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ClientRepository {
  Future<Either<Failure, List<Client>>> getClients();

  Future<Either<Failure,void>> addClient({required Client client});
}