import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tailor_made/features/client/data/models/client_model.dart';

final serviceLocator = GetIt.instance;


Future<void> initDependencies() async {
  String hivePath = (await getApplicationDocumentsDirectory()).path;
  Hive.init(hivePath);

  Hive.registerAdapter(ClientModelAdapter());

}