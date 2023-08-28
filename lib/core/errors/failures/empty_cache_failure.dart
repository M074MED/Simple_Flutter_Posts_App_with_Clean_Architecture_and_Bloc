import '../../strings/failures.dart';
import 'failure.dart';

class EmptyCacheFailure extends Failure {
  @override
  List<Object?> get props => [];
  
  @override
  String get message => EMPTY_CACHE_FAILURE_MESSAGE;
}