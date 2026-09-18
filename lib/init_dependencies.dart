import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tailor_made/core/constants/enums.dart';
import 'package:tailor_made/core/utils/input_converter.dart';
import 'package:tailor_made/features/client/data/models/client_model.dart';
import 'package:tailor_made/features/client/data/datasources/client_local_datasource.dart';
import 'package:tailor_made/features/client/domain/usecases/erase_client.dart';
import 'package:tailor_made/features/client/domain/repositories/client_repository.dart';
import 'package:tailor_made/features/client/data/repositories/client_repository_impl.dart';
import 'package:tailor_made/features/client/domain/usecases/save_client.dart';
import 'package:tailor_made/features/client/domain/usecases/edit_client.dart';
import 'package:tailor_made/features/client/domain/usecases/save_client_measurements.dart';
import 'package:tailor_made/features/client/domain/usecases/edit_client_measurements.dart';
import 'package:tailor_made/features/client/domain/usecases/fetch_clients.dart';
import 'package:tailor_made/features/client/presentation/bloc/client_bloc.dart';

import 'package:uuid/uuid.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  String hivePath = (await getApplicationDocumentsDirectory()).path;
  Hive.init(hivePath);

  Hive.registerAdapter(GenderAdapter());
  Hive.registerAdapter(ClientModelAdapter());

  Box<ClientModel> clientBox = await Hive.openBox<ClientModel>('clients');

  sl.registerLazySingleton(() => clientBox);

  Uuid uuid = const Uuid();

  sl.registerLazySingleton(() => uuid);

  sl.registerLazySingleton(() => InputConverter());

  _initClient();
}

void _initClient() {
  sl
    //LocalDataSource
    ..registerLazySingleton<ClientLocalDataSource>(() => ClientLocalDataSourceImpl(
          sl(),
        ))

    //Repository
    ..registerLazySingleton<ClientRepository>(() => ClientRepositoryImpl(
          sl(),
          sl(),
        ))

    //Usecases
    ..registerLazySingleton(() => SaveClient(sl()))
    ..registerLazySingleton(() => FetchClients(sl()))
    ..registerLazySingleton(() => EraseClient(sl()))
    ..registerLazySingleton(() => SaveClientMeasurements(sl()))
    ..registerLazySingleton(() => EditClientMeasurements(sl()))
    ..registerLazySingleton(() => EditClient(sl()))
    

    //bloc
    ..registerFactory(() => ClientBloc(
          saveClient: sl(),
          fetchClients: sl(),
          eraseClient: sl(),
          saveMeasurements: sl(),
          editClient: sl(),
          editClientMeasurements: sl(),
          inputConverter: sl(),
        ));
}
