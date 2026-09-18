import 'package:equatable/equatable.dart';
import 'package:tailor_made/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UseCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

class NoParams extends Equatable{

  @override 
  List<Object> get props => [];
  
}