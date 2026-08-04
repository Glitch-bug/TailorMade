part of 'client_bloc.dart';

@immutable 
sealed class ClientState {}

final class ClientInitial extends ClientState {}

final class ClientLoading extends ClientState {}

final class ClientFailure extends ClientState {
  final String error;
  ClientFailure(this.error);
}

final class ClientSuccess extends ClientState {}
final class ClientSaveSuccess extends ClientChangeSuccess {}

final class ClientDisplaySuccess extends ClientSuccess {
  final List<Client> clients;
  ClientDisplaySuccess(this.clients);
}

final class ClientDeleteSucces extends ClientChangeSuccess {}

final class ClientMeasurementsSaveSuccess extends ClientChangeSuccess {}

final class ClientMeasurementsEditSuccess extends ClientChangeSuccess {}

final class ClientEditSuccess extends ClientChangeSuccess {}

final class ClientChangeSuccess extends ClientSuccess {}