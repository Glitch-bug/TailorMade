import 'dart:convert';
import 'dart:io';

import 'package:tailor_made/core/constants/enums.dart';
import 'package:tailor_made/core/extensions/datetime_extension.dart';
import 'package:tailor_made/features/client/data/models/client_model.dart';
import 'package:tailor_made/features/client/domain/entities/client.dart';

final clients = [
  Client(
      id: '1',
      firstName: 'Kobby',
      lastName: 'Yiadom',
      phoneNumber: '0555598580',
      address: 'Kpone Shanghai',
      gender: Gender.male,
      email: 'kobby@gmail.com',
      dateAdded: DateTime.now().format()),
  Client(
      id: '2',
      firstName: 'Kofi',
      lastName: 'Yiadom',
      phoneNumber: '0666698580',
      address: 'Tema C7',
      gender: Gender.male,
      email: 'kofi@gmail.com',
      dateAdded: DateTime.now().format()),
  Client(
      id: '3',
      firstName: 'KM',
      lastName: 'Yiadom',
      phoneNumber: '0777798580',
      address: 'Accra, Airport Residential',
      gender: Gender.male,
      email: 'km@gmail.com',
      dateAdded: DateTime.now().format()),
];

final client = clients.first;


final clientModels = [
  ClientModel(
      id: '1',
      firstName: 'Kobby',
      lastName: 'Yiadom',
      phoneNumber: '0555598580',
      address: 'Kpone Shanghai',
      gender: Gender.male,
      email: 'kobby@gmail.com',
      dateAdded: DateTime.now().format()),
  ClientModel(
      id: '2',
      firstName: 'Kofi',
      lastName: 'Yiadom',
      phoneNumber: '0666698580',
      address: 'Tema C7',
      gender: Gender.male,
      email: 'kofi@gmail.com',
      dateAdded: DateTime.now().format()),
  ClientModel(
      id: '3',
      firstName: 'KM',
      lastName: 'Yiadom',
      phoneNumber: '0777798580',
      address: 'Accra, Airport Residential',
      gender: Gender.male,
      email: 'km@gmail.com',
      dateAdded: DateTime.now().format()),
];

final clientMeasurements = Client(
      id: '2',
      firstName: 'Kofi',
      lastName: 'Yiadom',
      phoneNumber: '0666698580',
      address: 'Tema C7',
      gender: Gender.male,
      email: 'kofi@gmail.com',
      dateAdded: DateTime.now().format(),
      measurements: json.decode(fixture("measurements.json")),
    );

final clientModelMeasurements = ClientModel(
      id: '2',
      firstName: 'Kofi',
      lastName: 'Yiadom',
      phoneNumber: '0666698580',
      address: 'Tema C7',
      gender: Gender.male,
      email: 'kofi@gmail.com',
      dateAdded: DateTime.now().format(),
      measurements: json.decode(fixture("measurements.json")),
    );

final clientModel = clientModels.last;

const String errorMessage = "An unexpected local storage error occured";

String fixture(String name) => File('test/fixtures/$name').readAsStringSync();