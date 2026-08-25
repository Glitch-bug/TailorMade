import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure([this.message = "An unexpected error occurred"]);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}


class ServerFailure extends Failure {
  const ServerFailure([super.message = "An unexpected server error occurred"]);
}

class LocalStorageFailure extends Failure {
  @override
  const LocalStorageFailure([super.message = "An unexpected local storage error occurred"]);


}