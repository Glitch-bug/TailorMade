import 'package:tailor_made/core/constants/enums.dart';
import 'package:equatable/equatable.dart';

class Client extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final Gender gender;
  final String email;
  final String address;
  final DateTime dateAdded;
  final Map<String, dynamic>? measurements;

  Client({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.gender,
    required this.email,
    required this.address,
    required this.dateAdded,
    this.measurements,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, firstName, lastName, phoneNumber, gender, email, address, dateAdded, measurements];
}