import 'package:tailor_made/features/client/domain/entities/client.dart';
import 'package:tailor_made/features/client/domain/usecases/save_client.dart';
import 'package:tailor_made/features/client/domain/usecases/fetch_clients.dart';
import 'package:tailor_made/core/usecase/usecase.dart';
import 'package:tailor_made/core/error/failures.dart';
import 'package:tailor_made/core/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'client_event.dart';
part 'client_state.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  final SaveClient _saveClient;
  final FetchClients _fetchClients;
  ClientBloc({
    required SaveClient saveClient,
    required FetchClients fetchClients,
  })  : _fetchClients = fetchClients,
        _saveClient = saveClient,
        super(ClientInitial()) {
    on<ClientEvent>((event, emit) => emit(ClientLoading()));
    on<ClientSave>((event, emit) {});
    on<ClientFetchAllClients>((event, emit) {});
  }

  void _onClientSave(
    ClientSave event,
    Emitter<ClientState> emit,
  ) async {
    final res = await _saveClient(ClientParams(
        firstName: event.firstName,
        lastName: event.lastName,
        gender: event.gender,
        phoneNumber: event.phoneNumber,
        email: event.email,
        address: event.address));

    res.fold(
      (l) => emit(ClientFailure(l.message)),
      (r) => emit(ClientSaveSuccess()),
    );
  }

  void _onClientsFetch(
    ClientFetchAllClients event,
    Emitter<ClientState> emit,
  )async{
    final res = await _fetchClients(
      NoParams()
    );

    res.fold(
      (l) => emit(ClientFailure(l.message)),
      (r) => emit(ClientDisplaySuccess(r)),
    );
  }
}
