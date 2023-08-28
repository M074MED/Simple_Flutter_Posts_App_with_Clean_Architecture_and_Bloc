import '../../strings/failures.dart';

import 'failure.dart';

class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
  
  @override
  String get message => SERVER_FAILURE_MESSAGE;
}