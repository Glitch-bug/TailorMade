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
      var bip = ClientModel(
        id: uuid.v4(),
        firstName: firstName,
        lastName: lastName,
        email: email,
        address: address,
        phoneNumber: phoneNumber,
        gender: gender,
        dateAdded: DateTime.now(),
      );

      await clientLocalDataSource.addClient(client:ClientModel(
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
      List<Client> clients = clientLocalDataSource.getClients().map((client) => client.toEntity()).toList();
      return right(clients);
    } on LocalStorageException catch (e){
      return left(Failure(e.message));
    }
    
  }


  @override 
  Future<Either<Failure, void>> eraseClient({required String id}) async {
    try {
      await clientLocalDataSource.eraseClient(id: id);
      return right(null);
    }on LocalStorageException catch (e){
      return left(Failure(e.message));
    }
  } 

  @override 
  Future<Either<Failure, void>> saveClientMeasurements({required String id, required Map<String, dynamic> measurements}) async {
    try {
      await clientLocalDataSource.saveClientMeasurements(id: id, measurements: measurements);
      return right(null);
    } on LocalStorageException catch (e) {
      return left(Failure(e.message));
    }

  }

  @override 
  Future<Either<Failure, void>> editClientMeasurements({required String id, required Map<String, dynamic>? measurements}) async {
    try {
      await clientLocalDataSource.editClientMeasurements(id: id, measurements: measurements);
      return right(null);
    } on LocalStorageException catch(e) {
      return left(Failure(e.message));
    }
  }



  
}