import 'package:tailor_made/features/client/domain/entities/client.dart';
import 'package:tailor_made/core/constants/enums.dart';
import 'package:tailor_made/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ClientRepository {
  Future<Either<Failure, List<Client>>> getClients();

  Future<Either<Failure,void>> addClient({ 
    required String firstName, 
    required String lastName,
    required String phoneNumber,
    required Gender gender,
    required String email,
    required String address,
  });
}