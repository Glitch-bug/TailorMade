import 'dart:io';
import 'package:hive_ce/hive_ce.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tailor_made/core/constants/enums.dart';
import 'package:tailor_made/features/client/data/models/client_model.dart';

import '../../../../fixtures/fixtures.dart';
void main() {
  late Box<ClientModel> box;
  late Directory tempDir;

  setUp(() async {
    box = await Hive.openBox<ClientModel>('clients');
  });

  setUpAll(() async {
    tempDir = await Directory.systemTemp.createTemp('hive_test_');
    Hive.init(tempDir.path);
    Hive.registerAdapter(ClientModelAdapter());
    Hive.registerAdapter(GenderAdapter());
  });


  tearDown(() async {
    await Hive.deleteFromDisk();
  });


  test('write and read back preserves measurements as Map<String, dynamic>', () async {
    final model = ClientModel.fromEntity(clientMeasurements);


    await box.put(model.id, model);
    final result = box.get(model.id);

    expect(result, isNotNull);
    expect(result!.measurements, isA<Map<String, dynamic>>());
    expect(result.measurements!["bust"], 31);
  });

  test('write and read back preserves gender enum', () async {
    final model = ClientModel.fromEntity(client);

    await box.put(model.id, model);
    final result = box.get(model.id);

    expect(result!.gender, Gender.male);
  });
}