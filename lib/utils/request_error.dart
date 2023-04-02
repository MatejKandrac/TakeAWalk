
enum RequestError {
  unauthorized, badRequest, serverError, unknown, noInternet
}

extension IntToRequestError on int? {

  RequestError toRequestError() {
    switch (this) {
      case 403: return RequestError.unauthorized;
      case 400: return RequestError.badRequest;
      case 500: return RequestError.serverError;
      default: return RequestError.unknown;
    }
  }

}