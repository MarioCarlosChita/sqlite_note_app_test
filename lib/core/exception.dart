
import 'package:flutter/services.dart';

abstract class AppException implements Exception{
   final String message;
   AppException({required this.message});
}
class InsertErrorException extends AppException{
   InsertErrorException({required super.message});
}
class QueryErrorException extends AppException{
  QueryErrorException({required super.message});
}

