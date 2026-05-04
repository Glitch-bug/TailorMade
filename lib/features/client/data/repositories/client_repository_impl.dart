import 'package:tailor_made/features/client/domain/repositories/client_repository.dart';
import 'package:tailor_made/features/client/data/datasources/client_local_datasource.dart';
import 'package:tailor_made/core/error/exceptions.dart';
import 'package:tailor_made/features/client/data/models/client_model.dart';
import 'package:tailor_made/features/client/domain/entities/client.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tailor_made/core/error/failures.dart';
import 'package:tailor_made/core/constants/enums.dart';
import 'package:uuid/uuid.dart';

class ClientRepositoryImpl implements ClientRepository {
  final ClientLocalDataSource clientLocalDataSource; 
  final Uuid uuid;
  const ClientRepositoryImpl(this.clientLocalDataSource, this.uuid);

  @override 
  Future<Either<Failure, void>> addClient({required String firstName, required String lastName, required String phoneNumber, required Gender gender, required String email, required String address})async{
    try {
      await clientLocalDataSource.saveClient(client:ClientModel(
        id: uuid.v4(),
        firstName: firstName,
        lastName: lastName,
        email: email,
        address: address,
        phoneNumber: phoneNumber,
        gender: gender,
        dateAdded: DateTime.now(),
      ));
      return right(null);
    } on LocalStorageException catch (e){
      return left(Failure(e.message));
    }
  }
   

  @override 
  Future<Either<Failure, List<Client>>> getClients()async{
    try {
      List<Client> clients = clientLocalDataSource.fetchClients().map((client) => client.toEntity()).toList();
      return right(clients);
    } on LocalStorageException catch (e){
      return left(Failure(e.message));
    }
    
  }
  
}