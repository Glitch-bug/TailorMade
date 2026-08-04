import 'package:tailor_made/features/client/data/models/client_model.dart';
import 'package:tailor_made/core/error/exceptions.dart';
import 'package:tailor_made/core/constants/strings.dart';
import 'package:hive/hive.dart';

abstract class ClientLocalDataSource {
  Future<void> addClient({required ClientModel client});
  Future<void> editClient({required ClientModel client});
  List<ClientModel> getClients();
  Future<void> eraseClient({required String id});
  Future<void> saveClientMeasurements({required String id, required Map<String, dynamic> measurements});
  Future<void> editClientMeasurements({required String id, required Map<String, dynamic>? measurements});
}


class ClientLocalDataSourceImpl implements ClientLocalDataSource {
  final Box<ClientModel> box;
  ClientLocalDataSourceImpl(this.box);

  @override
  Future<void> addClient({required ClientModel client})async{
    try {
      await box.put(client.id, client);
    } catch (e) {
      throw LocalStorageException(e.toString());
    }
  }

  @override 
  Future<void> editClient({required ClientModel client}) async {
    try {
      ClientModel? oldClient = box.get(client.id);
      if (oldClient != null) {
        box.put(client.id, client.copyWith(dateAdded: oldClient.dateAdded, measurements: oldClient.measurements));
      } else {
        throw Exception("The specified client does not exist");
      }
    } catch (e) {
      throw LocalStorageException(e.toString());
    }
  }

  
  
  @override
  List<ClientModel> getClients(){
    try {
      List<ClientModel> clients = box.values.toList();
      return clients;
    } catch (e) {
      throw LocalStorageException(e.toString());
    }
  }

  @override 
  Future<void> eraseClient({required String id})async{
    try {
      await box.delete(id);
    } catch(e) {
      throw LocalStorageException(e.toString());
    }
  }

  @override 
  Future<void> editClientMeasurements({required String id, required Map<String, dynamic>? measurements}) async {
    try {
      ClientModel? client = box.get(id);
      if (client != null){
        client = client.copyWith(
          measurements: measurements
        );
        await box.put(client.id, client);
      } else {
        throw LocalStorageException(AppStrings.clientNotFound);
      }
    } catch(e){
      throw LocalStorageException(e.toString());
    }
  }

  @override
  Future<void> saveClientMeasurements({required String id, required Map<String, dynamic> measurements}) async {
    try {
      ClientModel? client = box.get(id);
      if (client != null){
        client = client.copyWith(
          measurements: measurements
        );
        await box.put(client.id, client);
      }  else {
        throw LocalStorageException(AppStrings.clientNotFound);
      }
    } catch(e){
      throw LocalStorageException(e.toString());
    }
  }


}