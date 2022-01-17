import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{
  @override
  List<Object?> get props => const<dynamic>[];
}

// General failures
class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

class LogicalFailure extends Failure {}

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

String failureToMessage(Failure failure) {
  switch(failure.runtimeType) {
    case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
    case CacheFailure:
      return CACHE_FAILURE_MESSAGE;
    default:
      return 'Unexpected error';
  }
}
