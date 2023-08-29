class CustomException implements Exception {
  final _message;
  final _prefix;

  CustomException([this._message, this._prefix]);

  String toString() {
    //return "$_prefix$_message";
    return "$_message";
  }
}

class FetchDataException extends CustomException {
  String message;
  FetchDataException([this.message = ""]) : super(message, "Error During Communication: ");
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([message]) : super(message, "Bearer Token is wrong or expired");
}

class InvalidInputException extends CustomException {
  InvalidInputException([String message = ""]) : super(message, "Invalid Input: ");
}

class TimeoutException extends CustomException {
  TimeoutException([String message = ""]) : super(message, "Timeout,please try again");
}
