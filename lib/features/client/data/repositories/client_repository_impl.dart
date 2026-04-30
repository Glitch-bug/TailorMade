import 'package:tailor_made/features/client/domain/repositories/client_repository.dart';
import 'package:tailor_made/features/client/data/datasources/client_local_datasource.dart';
import 'package:tailor_made/core/error/exceptions.dart';
import 'package:tailor_made/features/client/data/models/client_model.dart';
import 'package:tailor_made/features/client/domain/entities/client.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tailor_made/core/error/failures.dart';

class ClientRepositoryImpl implements ClientRepository {
  final ClientLocalDataSource clientLocalDataSource; 
  const ClientRepositoryImpl(this.clientLocalDataSource);

  @override 
  Future<Either<Failure, void>> addClient({required Client client})async{
    try {
      await clientLocalDataSource.saveClient(client:ClientModel.fromEntity(client));
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