import 'package:equatable/equatable.dart';
import 'package:tailor_made/core/constants/strings.dart';
abstract class Failure extends Equatable {
  final String message;
  const Failure([this.message = AppStrings.failure]);

  @override
  List<Object?> get props => [message];
}


class ServerFailure extends Failure {
  const ServerFailure([super.message = AppStrings.serverFailure]);
}

class LocalStorageFailure extends Failure {
  @override
  const LocalStorageFailure([ super.message = AppStrings.localStorageFailure]);


}