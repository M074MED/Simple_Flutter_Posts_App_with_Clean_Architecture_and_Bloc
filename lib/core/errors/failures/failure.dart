import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  String get message;
}