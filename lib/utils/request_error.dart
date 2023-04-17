
class RequestError {

  final String errorText;

  const RequestError(this.errorText);

  const RequestError.custom(this.errorText);

  factory RequestError.unauthorized() => const RequestError("You don't have permissions");
  factory RequestError.badRequest() => const RequestError("Invalid data");
  factory RequestError.serverError() => const RequestError("Server error");
  factory RequestError.unknown() => const RequestError("Unknown error has occurred");
  factory RequestError.noInternet() => const RequestError("Unable to sync data");
  factory RequestError.unauthenticated() => const RequestError("Invalid credentials");

  String getErrorText() => errorText;

}

extension IntToRequestError on int? {

  RequestError toRequestError() {
    switch (this) {
      case null: return RequestError.noInternet();
      case 401: return RequestError.unauthenticated();
      case 403: return RequestError.unauthorized();
      case 400: return RequestError.badRequest();
      case 500: return RequestError.serverError();
      default: return RequestError.unknown();
    }
  }

}
