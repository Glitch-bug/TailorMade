import 'package:tailor_made/core/usecase/usecase.dart';
import 'package:tailor_made/features/client/domain/entities/client.dart';
import 'package:tailor_made/features/client/domain/repositories/client_repository.dart';
import 'package:tailor_made/core/error/failures.dart';
import 'package:tailor_made/core/constants/enums.dart';
import 'package:fpdart/fpdart.dart';


class SaveClient implements UseCase<void, ClientParams> {
  final ClientRepository clientRepository;
  SaveClient(this.clientRepository);

  @override 
  Future<Either<Failure, void>> call(ClientParams params) async{
    return await clientRepository.addClient(firstName: params.firstName, lastName: params.lastName, phoneNumber: params.phoneNumber, gender: params.gender, email: params.email, address: params.address,);
  }



}

class ClientParams {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final Gender gender;
  final String email;
  final String address;

  const ClientParams({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.gender,
    required this.email,
    required this.address,
  });
}