import 'package:fpdart/fpdart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tailor_made/core/constants/strings.dart';
import 'package:tailor_made/core/utils/input_converter.dart';
import 'package:tailor_made/core/constants/enums.dart';
void main() {
  late InputConverter inputConverter;


  setUp((){
    inputConverter = InputConverter();
  });


  group('stringToGender', (){
    test('should return a Gender when the string represents a Gender', () async {
      const str = 'female';

      final result = inputConverter.stringToGender(str);

      expect(result, const Right(Gender.female));

    });

    test('should return a Failure when the string does not represent a Gender', () async {
      const str = 'slug';

      final result = inputConverter.stringToGender(str);

      expect(result, Left(InvalidInputFailure(const FormatException(AppStrings.invalidGender).toString())));
    });


    test('should return a Gender when the string represents a Gender (title case)', () async {
      const str = 'Female';

      final result = inputConverter.stringToGender(str);

      expect(result, const Right(Gender.female));

    });

  });
}