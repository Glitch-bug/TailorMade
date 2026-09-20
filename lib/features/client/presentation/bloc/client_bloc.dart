import 'package:tailor_made/core/constants/enums.dart';
import 'package:tailor_made/features/client/domain/entities/client.dart';
import 'package:tailor_made/features/client/domain/usecases/save_client.dart';
import 'package:tailor_made/features/client/domain/usecases/fetch_clients.dart';
import 'package:tailor_made/features/client/domain/usecases/erase_client.dart';
import 'package:tailor_made/features/client/domain/usecases/edit_client.dart';
import 'package:tailor_made/features/client/domain/usecases/save_client_measurements.dart';
import 'package:tailor_made/features/client/domain/usecases/edit_client_measurements.dart';
import 'package:tailor_made/core/utils/input_converter.dart';
import 'package:tailor_made/core/usecase/usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'client_event.dart';
part 'client_state.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  final SaveClient _saveClient;
  final FetchClients _fetchClients;
  final EraseClient _eraseClient;
  final EditClient _editClient;
  final SaveClientMeasurements _saveMeasurements;
  final EditClientMeasurements _editClientMeasurements;
  final InputConverter _inputConverter;
  ClientBloc(
      {required SaveClient saveClient,
      required FetchClients fetchClients,
      required EraseClient eraseClient,
      required SaveClientMeasurements saveMeasurements,
      required EditClient editClient,
      required EditClientMeasurements editClientMeasurements,
      required InputConverter inputConverter})
      : _fetchClients = fetchClients,
        _saveClient = saveClient,
        _eraseClient = eraseClient,
        _saveMeasurements = saveMeasurements,
        _editClient = editClient,
        _editClientMeasurements = editClientMeasurements,
        _inputConverter = inputConverter,
        super(ClientInitial()) {
    on<ClientEvent>((event, emit) => emit(ClientLoading()));
    on<ClientSave>(_onClientSave);
    on<ClientFetchAll>(_onClientsFetch);
    on<ClientErase>(_onClientErase);
    on<ClientMeasurementsSave>(_onClientMeasurementsSave);
    on<ClientEdit>(_onClientEdit);
    on<ClientMeasurementsEdit>(_onClientMeasurementsEdit);
    on<ClientReset>(_onClientReset);
  }


  void _onClientReset(ClientReset event, Emitter<ClientState> emit) {
    emit(ClientInitial());
  }
  Future<void> _onClientSave(
    ClientSave event,
    Emitter<ClientState> emit,
  ) async {
    final genderResult = _inputConverter.stringToGender(event.gender);

    final Gender? gender = genderResult.fold(
      (l) {
        emit(ClientFailure(l.message));
        return null;
      },
      (r) => r,
    );
    if (gender == null) return;

    final res = await _saveClient(ClientParams(
      firstName: event.firstName,
      lastName: event.lastName,
      gender: gender,
      phoneNumber: event.phoneNumber,
      email: event.email,
      address: event.address,
    ));

    res.fold(
      (l) => emit(ClientFailure(l.message)),
      (r) => emit(ClientSaveSuccess()),
    );
  }

  Future<void> _onClientsFetch(
    ClientFetchAll event,
    Emitter<ClientState> emit,
  ) async {
  
    final res = await _fetchClients(NoParams());

    res.fold(
      (l) => emit(ClientFailure(l.message)),
      (r) => emit(ClientDisplaySuccess(r)),
    );
  }

  Future<void> _onClientErase(
    ClientErase event,
    Emitter<ClientState> emit,
  ) async {
    final res = await _eraseClient(IdParams(id: event.id));

    res.fold(
      (l) => emit(ClientFailure(l.message)),
      (r) => emit(ClientDeleteSucces()),
    );
  }

  Future<void> _onClientMeasurementsSave(
    ClientMeasurementsSave event,
    Emitter<ClientState> emit,
  ) async {
    final res = await _saveMeasurements(
        MeasurementParams(id: event.id, measurements: event.measurements));

    res.fold((l) => emit(ClientFailure(l.message)),
        (r) => emit(ClientMeasurementsSaveSuccess()));
  }

  Future<void> _onClientEdit(
    ClientEdit event,
    Emitter<ClientState> emit,
  ) async {
    final genderResult = _inputConverter.stringToGender(event.gender);
    final Gender? gender = genderResult.fold((l) {
      emit(ClientFailure(l.message));
      return null;
    }, (r) => r);

    if (gender == null) return;

    final res = await _editClient(
      ClientEditParams(
        id: event.id,
        firstName: event.firstName,
        lastName: event.lastName,
        address: event.address,
        gender: gender,
        phoneNumber: event.phoneNumber,
        email: event.email,
      ),
    );

    res.fold((l) => emit(ClientFailure(l.message)),
        (r) => emit(ClientEditSuccess()));
  }

  Future<void> _onClientMeasurementsEdit(
    ClientMeasurementsEdit event,
    Emitter<ClientState> emit,
  ) async {
    final res = await _editClientMeasurements(
        EditMeasurementParams(id: event.id, measurements: event.measurements));

    res.fold((l) => emit(ClientFailure(l.message)),
        (r) => emit(ClientMeasurementsEditSuccess()));
  }
}
