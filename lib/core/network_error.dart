import 'package:equatable/equatable.dart';

class NetworkError extends Equatable {
  final int statusCode;
  final String message;

  const NetworkError([this.statusCode = 0, this.message = 'Unknown Error']);

  const NetworkError.couldNotConnect([this.statusCode = 1, this.message = 'Could Not Connect']);

  @override
  List<Object> get props => [statusCode, message];

  @override
  String toString() => 'NetworkError($statusCode, $message)';
}
