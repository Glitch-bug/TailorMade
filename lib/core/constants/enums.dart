import 'package:hive/hive.dart';

part 'enums.g.dart';

@HiveType(typeId:2)
enum Gender {
  @HiveField(0)
  male,
  
  @HiveField(1)
  female;


  String get value =>
      switch (this) { Gender.female => "female", Gender.male => "male" };

  String get title =>
      switch (this) { Gender.female => "Female", Gender.male => "Male" };

  static fromValue(String value) {
    switch (value) {
      case "female":
        return Gender.female;
      case "male":
        return Gender.male;
    }
  }

  static fromTitle(String value) {
    switch (value) {
      case "Male":
        return Gender.male;

      case "Female":
        return Gender.female;
    }
  }
}