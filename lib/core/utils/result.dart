/// Lightweight success/failure wrapper used by use cases so the
/// presentation layer never has to catch raw exceptions.
sealed class Result<T> {
  const Result();

  const factory Result.success(T data) = Success<T>;
  const factory Result.failure(String message) = Failure<T>;
}

class Success<T> extends Result<T> {
  const Success(this.data);
  final T data;
}

class Failure<T> extends Result<T> {
  const Failure(this.message);
  final String message;
}
