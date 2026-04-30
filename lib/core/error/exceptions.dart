

class ServerException implements Exception {
  final String message;
  ServerException(this.message);

}

class LocalStorageException implements Exception {
  final String message;
  const LocalStorageException(this.message);

}