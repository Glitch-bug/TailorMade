import 'package:hive/hive.dart';
import 'package:tailor_made/core/constants/measurement_forms.dart';

part 'enums.g.dart';


mixin DropdownEntry {
  String get title;

  dynamic get value;
}

@HiveType(typeId:2)
enum Gender with DropdownEntry{
  @HiveField(0)
  male,
  
  @HiveField(1)
  female;

  @override
  String get value =>
      switch (this) { Gender.female => "female", Gender.male => "male" };

  @override
  String get title =>
      switch (this) { Gender.female => "Female", Gender.male => "Male" };
  
  Map<String, dynamic> get measurementForm =>
    switch (this) {
      Gender.female => forms.first,
      Gender.male => forms.last,
    };

  static fromValue(String value) {
    switch (value.toLowerCase()) {
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

enum AppState {
  list,
  saveClient,
  editMeasurements,
  saveMeasurements,
  measurements;
}

enum PanelState {
  editClient,
}