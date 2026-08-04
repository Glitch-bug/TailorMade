import 'package:tailor_made/core/usecase/usecase.dart';
import 'package:tailor_made/core/constants/enums.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tailor_made/core/error/failures.dart';
import 'package:tailor_made/features/client/domain/repositories/client_repository.dart';

class EditClient implements UseCase<void, ClientEditParams> {
  final ClientRepository clientRepository;
  const EditClient(this.clientRepository);

  @override 
  Future<Either<Failure, void>> call(ClientEditParams params) async {
    return await clientRepository.editClient(id: params.id, firstName: params.firstName, lastName: params.lastName, address: params.address, email: params.email, phoneNumber: params.phoneNumber, gender: params.gender);
  }

}

class ClientEditParams {
  final String id;
  final String firstName;
  final String lastName;
  final String address;
  final Gender gender;
  final String email;
  final String phoneNumber;
  const ClientEditParams({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.email,
    required this.gender,
    required this.phoneNumber
  });
}