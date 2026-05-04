part of 'client_bloc.dart';

@immutable 
sealed class ClientEvent {}

final class ClientSave extends ClientEvent {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final Gender gender;
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


final class ClientFetchAllClients extends ClientEvent{}