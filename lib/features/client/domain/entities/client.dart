import 'package:tailor_made/core/constants/enums.dart';
import 'package:uuid/uuid.dart';

class Client {
  final String id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final Gender gender;
  final String email;
  final String address;
  final DateTime dateAdded;

  Client({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.gender,
    required this.email,
    required this.address,
    required this.dateAdded,
  });
}