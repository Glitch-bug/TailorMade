part of 'client_bloc.dart';

@immutable 
sealed class ClientEvent {}

final class ClientSave extends ClientEvent {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String gender;
  final String address;

  ClientSave({
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.phoneNumber,
    required this.email,
    required this.address,
  });
}

final class ClientEdit extends ClientEvent {
  final String id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String gender;
  final String address;

  ClientEdit({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.phoneNumber,
    required this.email,
    required this.address,
  });
}

final class ClientFetchAll extends ClientEvent{}

final class ClientErase extends ClientEvent{
  final String id;

  ClientErase({
    required this.id
  });
}

final class ClientMeasurementsSave extends ClientEvent{
  final String id;
  final Map<String, dynamic> measurements;

  ClientMeasurementsSave({
      required this.id,
      required this.measurements,
    });
}

final class ClientMeasurementsEdit extends ClientEvent {
  final String id;
  final Map<String, dynamic>? measurements;

  ClientMeasurementsEdit({
    required this.id,
    required this.measurements,
  });
}