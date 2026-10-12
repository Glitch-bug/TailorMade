import 'package:equatable/equatable.dart';
import 'package:hive_ce/hive_ce.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tailor_made/core/constants/enums.dart';
import 'package:tailor_made/features/client/domain/entities/client.dart';
// import 'package:equatable/equatable.dart';
// part 'client_model.freezed.dart';
part 'client_model.g.dart';


@freezed
@HiveType(typeId: 1) 
class ClientModel extends Equatable {
  
    @HiveField(0) final String id;
    @HiveField(1) final String firstName;
    @HiveField(2) final String lastName;
    @HiveField(3) final String phoneNumber;
    @HiveField(4) final Gender gender;
    @HiveField(5) final String email;
    @HiveField(6) final String address;
    @HiveField(7) final DateTime dateAdded;
    @HiveField(8) final Map<String, dynamic>? measurements;
    @HiveField(9) final String? avatar;

    const ClientModel({
     required  this.id,
     required  this.firstName,
     required  this.lastName,
     required  this.phoneNumber,
     required  this.gender,
     required  this.email,
     required  this.address,
     required this.dateAdded,
      this.measurements,
      this.avatar,
     });


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
      measurements: client.measurements,
      avatar: client.avatar
    );
  }

  ClientModel copyWith({id, firstName, lastName, phoneNumber, gender, email, address, dateAdded, avatar, measurements}) => ClientModel(
    id: id ?? this.id,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    gender: gender ?? this.gender,
    email: email ?? this.email,
    address: address ?? this.address,
    dateAdded: dateAdded ?? this.dateAdded,
    measurements: measurements ?? this.measurements,
    avatar: avatar ?? this.avatar,
  );

  Client toEntity() => Client(
        id: id,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        gender: gender,
        email: email,
        address: address,
        dateAdded: dateAdded,
        avatar: avatar,
        measurements: measurements,
      );


  @override
  List<Object?> get props =>  [id, firstName, lastName, gender, phoneNumber, address, email, measurements, avatar];
}
