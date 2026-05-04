import 'package:hive/hive.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tailor_made/core/constants/enums.dart';
import 'package:tailor_made/core/utils/uuid_converter.dart';
import 'package:tailor_made/features/client/domain/entities/client.dart';
import 'package:uuid/uuid.dart';

part 'client_model.g.dart';
part 'client_model.freezed.dart';

@freezed
@HiveType(typeId: 1)
class ClientModel with _$ClientModel {
  const ClientModel._();
  
  const factory ClientModel({
    @HiveField(0) required String id,
    @HiveField(1) required String firstName,
    @HiveField(2) required String lastName,
    @HiveField(3) required String phoneNumber,
    @HiveField(4) required Gender gender,
    @HiveField(5) required String email,
    @HiveField(6) required String address,
    @HiveField(7) required DateTime dateAdded,
  }) = _ClientModel;

  factory ClientModel.fromJson(Map<String, dynamic> json) =>
      _$ClientModelFromJson(json);

  factory ClientModel.fromEntity(Client client) {
    return ClientModel(
      id: client.id,
      firstName: client.firstName,
      lastName: client.lastName,
      phoneNumber: client.phoneNumber,
      gender: client.gender,
      email: client.email,
      address: client.address,
      dateAdded: client.dateAdded,
    );
  }

  Client toEntity() => Client(
        id: id,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        gender: gender,
        email: email,
        address: address,
        dateAdded: dateAdded,
      );
}
