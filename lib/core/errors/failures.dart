import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

abstract class Failures {
  final String errorMessage;

  Failures({required this.errorMessage});
}

class ServerFailure extends Failures {
  ServerFailure({required super.errorMessage});
  factory ServerFailure.fromDioException(DioException dioError ) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(errorMessage: 'Connection timeout');
      case DioExceptionType.sendTimeout:
        return ServerFailure(errorMessage: 'Send timeout');
      case DioExceptionType.receiveTimeout:
        return ServerFailure(errorMessage: 'Receive timeout');
      case DioExceptionType.badResponse:
       return ServerFailure.fromBadResponse(dioError.response!.statusCode!, dioError.message!);
      case DioExceptionType.cancel:
        return ServerFailure(errorMessage: 'Request cancelled');
      default:
        return ServerFailure(errorMessage: 'Unexpected error occurred');
    }
  }

  factory ServerFailure.fromBadResponse(int statusCode, String message) {
    if (statusCode == 404) {
      return ServerFailure(errorMessage: 'Resource not found');
    } else if (statusCode == 500) {
      return ServerFailure(errorMessage: 'Internal server error');
    } else if (statusCode == 403) {
      return ServerFailure(errorMessage: 'Forbidden access');
    } else if (statusCode == 401) {
      return ServerFailure(errorMessage: 'Unauthorized access');
    } else {
      return ServerFailure(errorMessage: 'Server error $statusCode: $message');
    }
  }
}

class CacheFailure extends Failures {
  CacheFailure({required super.errorMessage});
  factory CacheFailure.fromDioException(DioException e) {
    return CacheFailure(errorMessage: e.message ?? 'Cache error occurred');
  }
}
void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

