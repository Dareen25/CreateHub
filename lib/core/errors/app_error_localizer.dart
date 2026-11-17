import 'app_error.dart';

extension AppErrorLocalization on AppError {
  String localize() => switch (this) {
    ConnectionTimeoutError() => 'Connection timed out. Check your internet.',
    RequestTimeoutError() => 'The request timed out. Please try again.',
    NetworkError() => 'Network error. Check your connection.',
    NotFoundError() => 'The requested item could not be found.',
    ServiceDisabled() => 'This service is currently unavailable.',
    PermissionDenied() => 'Permission was denied.',
    PermissionDeniedForever() => 'Permission is disabled in system settings.',
    ServerError() => 'The server could not complete the request.',
    ApiMessageError(message: final message) => message,
    UnknownError() => 'Something went wrong. Please try again.',
    LocalStorageError(key: final key) => key == null
        ? 'Secure storage failed.'
        : 'No saved value exists for $key.',
  };
}
