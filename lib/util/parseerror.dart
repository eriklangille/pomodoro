class ParseError {


  static ErrorMessage registerError(String code) {
    String _message = code;
    String _type = "";
    switch(code) {
      case 'ERROR_WEAK_PASSWORD':
        _message = "Password should be at least 6 characters.";
        _type = "password";
        break;
      case 'ERROR_EMAIL_ALREADY_IN_USE':
        _message = "This email is already taken.";
        _type = "username";
        break;
      case 'ERROR_INVALID_EMAIL':
        _message = "This is not a valid email address.";
        _type = "username";
        break;
    }
    return ErrorMessage(message: _message, type: _type);
  }
}

class ErrorMessage {
  final String message;
  final String type;

  ErrorMessage({this.message, this.type});
}