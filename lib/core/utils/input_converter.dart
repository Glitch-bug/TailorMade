import 'package:fpdart/fpdart.dart';
import 'package:tailor_made/core/constants/enums.dart';
import 'package:tailor_made/core/constants/strings.dart';
import 'package:tailor_made/core/error/failures.dart';

class InputConverter {

  Either<Failure, Gender> stringToGender(String str){
    try {
      final gender = Gender.fromValue(str);
      if (gender != null){
        return Right(gender);
      }else {
        throw const FormatException(AppStrings.invalidGender);
      }

    } on FormatException catch(e) {
      return Left(InvalidInputFailure(e.toString()));
    }

  }

}


class InvalidInputFailure extends Failure {
  @override 
  const InvalidInputFailure([super.message = AppStrings.invalidGender]);
}