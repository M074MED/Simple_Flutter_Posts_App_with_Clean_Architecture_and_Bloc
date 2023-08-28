import '../../strings/failures.dart';

import 'failure.dart';

class OfflineFailure extends Failure {
  @override
  List<Object?> get props => [];
  
  @override
  String get message => OFFLINE_FAILURE_MESSAGE;
}