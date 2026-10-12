import 'package:hive_ce/hive_ce.dart';
import 'package:tailor_made/core/constants/measurement_forms.dart';
import 'dart:math';

part 'enums.g.dart';


mixin DropdownEntry {
  String get title;

  dynamic get value;
}

@HiveType(typeId:2)
enum Gender with DropdownEntry {
  @HiveField(0) male,
  
  @HiveField(1) female;

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

  static Gender? fromValue(String value) {
    switch (value.toLowerCase()) {
      case "female":
        return Gender.female;
      case "male":
        return Gender.male;
      default:
        return null;
    }
  }

  static Gender? fromTitle(String value) {
    switch (value) {
      case "Male":
        return Gender.male;
      case "Female":
        return Gender.female;
      default: 
        return null;
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


enum Avatar {

  kofi(gender: Gender.male),
  ato(gender: Gender.male),
  kwame(gender: Gender.male),
  kweku(gender: Gender.male),
  nii(gender: Gender.male),
  sena(gender: Gender.male),
  yaw(gender: Gender.male),
  kwadjo(gender: Gender.male),

  ama(gender: Gender.female),
  abena(gender: Gender.female),
  adwoa(gender: Gender.female),
  afi(gender: Gender.female),
  akosua(gender: Gender.female),
  baaba( gender: Gender.female),
  kakra(gender: Gender.female),
  nana(gender: Gender.female),
  panin(gender: Gender.female);

  final Gender gender;

  const Avatar({required this.gender});

  static Avatar random(Gender gender) {
    List<Avatar> group = values.where((a) => a.gender == gender).toList();
    final rand = Random();
    return group[rand.nextInt(group.length)];
  }

  String get path => switch(this) {
    Avatar.abena => "assets/images/abena.svg",
    Avatar.adwoa => "assets/images/adwoa.svg",
    Avatar.afi => "assets/images/afi.svg",
    Avatar.akosua => "assets/images/akosua.svg",
    Avatar.ama => "assets/images/ama.svg",
    Avatar.ato => "assets/images/ato.svg",
    Avatar.baaba => "assets/images/baaba.svg",
    Avatar.kakra => "assets/images/kakra.svg",
    Avatar.kofi => "assets/images/kofi.svg",
    Avatar.kwadjo => "assets/images/kwadjo.svg",
    Avatar.kwame => "assets/images/kwame.svg",
    Avatar.kweku => "assets/images/kweku.svg",
    Avatar.nana => "assets/images/nana.svg",
    Avatar.nii => "assets/images/nii.svg",
    Avatar.panin => "assets/images/panin.svg",
    Avatar.sena => "assets/images/sena.svg",
    Avatar.yaw => "assets/images/yaw.svg"
  };

}