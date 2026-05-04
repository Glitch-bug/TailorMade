import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tailor_made/features/client/data/models/client_model.dart';
import 'package:tailor_made/features/client/data/datasources/client_local_datasource.dart';
import 'package:tailor_made/features/client/domain/repositories/client_repository.dart';
import 'package:tailor_made/features/client/data/repositories/client_repository_impl.dart';
import 'package:tailor_made/features/client/domain/usecases/save_client.dart';
import 'package:tailor_made/features/client/domain/usecases/fetch_clients.dart';
import 'package:tailor_made/features/client/presentation/bloc/client_bloc.dart';
import 'package:uuid/uuid.dart';

final serviceLocator = GetIt.instance;


Future<void> initDependencies() async {
  _initClient();

  String hivePath = (await getApplicationDocumentsDirectory()).path;
  Hive.init(hivePath);

  Hive.registerAdapter(ClientModelAdapter());

  Box hiveBox = await Hive.openBox('clients');

  Uuid uuid = const Uuid();

  serviceLocator.registerLazySingleton(() => uuid);
  serviceLocator.registerLazySingleton(() => hiveBox);

}

void _initClient() {
  
  serviceLocator 
    //LocalDataSource
    ..registerFactory<ClientLocalDataSource>(
      () => ClientLocalDataSourceImpl(
        serviceLocator(),
      )
    )

    //Repository
    ..registerFactory<ClientRepository>(
      () => ClientRepositoryImpl(
        serviceLocator(),
        serviceLocator(),
      )
    )

    //Usecases
    ..registerFactory(
      () => SaveClient(
        serviceLocator()
      )
    )

    ..registerFactory(
      () => FetchClients(
        serviceLocator()
      )
    )

    //bloc 
    ..registerLazySingleton(
      () => ClientBloc(
        saveClient: serviceLocator(),
        fetchClients: serviceLocator()
      )
    );
}