import 'package:equatable/equatable.dart';

class Result<T> extends Equatable {
  final T value;
  final bool isError;
  final Error error;

  bool get isSuccess => !isError;

  Result(this.isError, this.error, this.value);

  Result.error([Error error])
      : this.error = error ?? UnknownError(),
        isError = true,
        value = null;

  Result.ok(this.value)
      : isError = false,
        error = null;

  @override
  List<Object> get props => [value, isError, error];
}

class UnknownError extends Error {
  final Object message;

  UnknownError([this.message]);
}

class DatabaseError extends Error {
  final Object message;

  DatabaseError([this.message]);
}

abstract class NetworkError extends Error {
  final int statusCode;
  final String message;

  NetworkError._(this.statusCode, this.message);

  factory NetworkError([int statusCode, String message]) {
    switch (statusCode) {
      case 500:
        return ServerError(message);
      case 401:
        return AuthenticationError(message);
      case 400:
        return BadRequestError(message);
      case 409:
        return ConflictError(message);
      default:
        throw ArgumentError.value(statusCode, 'statusCode', '${statusCode ?? 'null'} is not a valid statusCode');
    }
  }
}

class ServerError extends NetworkError {
  ServerError([String message]) : super._(500, message);
}

class AuthenticationError extends NetworkError {
  AuthenticationError([String message]) : super._(401, message);
}

class BadRequestError extends NetworkError {
  BadRequestError([String message]) : super._(400, message);
}

class ConflictError extends NetworkError {
  ConflictError([String message]) : super._(409, message);
}
