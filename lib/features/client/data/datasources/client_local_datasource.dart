import 'package:tailor_made/features/client/data/models/client_model.dart';
import 'package:tailor_made/core/error/exceptions.dart';
import 'package:hive/hive.dart';

abstract class ClientLocalDataSource {
  Future<void> saveClient({required ClientModel client});
  List<ClientModel> fetchClients();
}


class ClientLocalDataSourceImpl implements ClientLocalDataSource {
  final Box<ClientModel> box;
  ClientLocalDataSourceImpl(this.box);

  @override
  Future<void> saveClient({required ClientModel client})async{
    try {
      await box.put(client.id, client);
    } catch (e) {
      throw LocalStorageException(e.toString());
    }
  }
  
  @override
  List<ClientModel> fetchClients(){
    try {
      List<ClientModel> clients = box.values.toList();
      return clients;
    } catch (e) {
      throw LocalStorageException(e.toString());
    }
  }
}