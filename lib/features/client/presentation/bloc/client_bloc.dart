import 'package:tailor_made/features/client/domain/entities/client.dart';
import 'package:tailor_made/features/client/domain/usecases/save_client.dart';
import 'package:tailor_made/features/client/domain/usecases/fetch_clients.dart';
import 'package:tailor_made/features/client/domain/usecases/erase_client.dart';
import 'package:tailor_made/features/client/domain/usecases/edit_client.dart';
import 'package:tailor_made/features/client/domain/usecases/save_client_measurements.dart';
import 'package:tailor_made/features/client/domain/usecases/edit_client_measurements.dart';
import 'package:tailor_made/core/usecase/usecase.dart';
import 'package:tailor_made/core/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'client_event.dart';
part 'client_state.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  final SaveClient _saveClient;
  final FetchClients _fetchClients;
  final EraseClient _eraseClient;
  final EditClient _editClient;
  final SaveClientMeasurements _saveMeasurements;
  final EditClientMeasurements _editClientMeasurements;
  ClientBloc({
    required SaveClient saveClient,
    required FetchClients fetchClients,
    required EraseClient eraseClient,
    required SaveClientMeasurements saveMeasurements,
    required EditClient editClient,
    required EditClientMeasurements editClientMeasurements,
  })  : _fetchClients = fetchClients,
        _saveClient = saveClient,
        _eraseClient = eraseClient,
        _saveMeasurements = saveMeasurements,
        _editClient = editClient,
        _editClientMeasurements = editClientMeasurements,
        super(ClientInitial()) {
    on<ClientEvent>((event, emit) => emit(ClientLoading()));
    on<ClientSave>(_onClientSave);
    on<ClientFetchAllClients>(_onClientsFetch);
    on<ClientErase>(_onClientErase);
    on<ClientMeasurementsSave>(_onClientMeasurementsSave);
    on<ClientEdit>(_onClientEdit);
    on<ClientMeasurementsEdit>(_onClientMeasurementsEdit);
  }

  void _onClientSave(
    ClientSave event,
    Emitter<ClientState> emit,
  ) async {
    final res = await _saveClient(
      ClientParams(
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

  void _onClientErase(
    ClientErase event,
    Emitter<ClientState> emit,
  ) async {
    final res = await _eraseClient(
      IdParams(
        id: event.id
      )
    );

    res.fold(
      (l) => emit(ClientFailure(l.message)),
      (r) => emit(ClientDeleteSucces()),
    );

  }

  void _onClientMeasurementsSave(
    ClientMeasurementsSave event,
    Emitter<ClientState> emit,
  ) async {
    final res = await _saveMeasurements(
      MeasurementParams(
        id: event.id,
        measurements: event.measurements
      )
    );

    res.fold(
      (l) => emit(ClientFailure(l.message)),
      (r) => emit(ClientMeasurementsSaveSuccess())
    );
  }


  void _onClientEdit(
    ClientEdit event,
    Emitter<ClientState> emit,
  ) async {
    final res = await _editClient(
      ClientEditParams(
        id: event.id,
        firstName: event.firstName,
        lastName: event.lastName,
        address: event.address, 
        gender: event.gender,
        phoneNumber: event.phoneNumber,
        email: event.email,
      )
    );
    
    res.fold(
      (l) => emit(ClientFailure(l.message)),
      (r) => emit (ClientEditSuccess())
    );


  }

  void _onClientMeasurementsEdit (
    ClientMeasurementsEdit event,
    Emitter<ClientState> emit,
  )  async {

    final res = await _editClientMeasurements(
      EditMeasurementParams(
        id: event.id,
        measurements: event.measurements
      )
    );

    res.fold(
      (l) => emit(ClientFailure(l.message)),
      (r) => emit(ClientMeasurementsEditSuccess())
    );

  }
}
