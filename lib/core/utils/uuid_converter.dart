import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

class UuidConverter implements JsonConverter <UuidValue, String> {
  const UuidConverter();

  @override
  UuidValue fromJson(String json) => UuidValue.withValidation(json);

  @override 
  String toJson(UuidValue object) => object.uuid;
}