import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tailor_made/core/constants/enums.dart';
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


  String hivePath = (await getApplicationDocumentsDirectory()).path;
  Hive.init(hivePath);

  Hive.registerAdapter(GenderAdapter());
  Hive.registerAdapter(ClientModelAdapter());

  Box<ClientModel> clientBox = await Hive.openBox<ClientModel>('clients');

  serviceLocator.registerLazySingleton(() => clientBox);

  Uuid uuid = const Uuid();

  serviceLocator.registerLazySingleton(() => uuid);

  _initClient();
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