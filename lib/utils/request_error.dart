
enum RequestError {
  unauthorized, badRequest, serverError, unknown, noInternet, unauthenticated;

  String getErrorText() {
    switch (this) {
      case RequestError.unauthorized:
        return "You don't have permissions";
      case RequestError.badRequest:
        return "Invalid data";
      case RequestError.serverError:
        return "Server error";
      case RequestError.unknown:
        return "Unknown error has occurred";
      case RequestError.noInternet:
        return "Unable to reach server";
      case RequestError.unauthenticated:
        return "Invalid credentials";
    }
  }
}

extension IntToRequestError on int? {

  RequestError toRequestError() {
    switch (this) {
      case null: return RequestError.noInternet;
      case 401: return RequestError.unauthenticated;
      case 403: return RequestError.unauthorized;
      case 400: return RequestError.badRequest;
      case 500: return RequestError.serverError;
      default: return RequestError.unknown;
    }
  }

}
