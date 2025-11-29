class Result<T, E> {
  const Result();

  factory Result.success(T data) => Success(data: data);
  factory Result.failure(E error) => Failure(error: error);

  bool get isSuccess => this is Success<T, E>;
  bool get isFailure => this is Failure<T, E>;

  R when<R>({
    required R Function(T data) success,
    required R Function(E error) failure,
  }) {
    if (this is Success<T, E>) {
      return success((this as Success<T, E>).data);
    } else {
      return failure((this as Failure<T, E>).error);
    }
  }
}

class Success<T, E> extends Result<T, E> {
  final T data;
  Success({required this.data});

  @override
  String toString() => 'Success(data: $data)';
}

class Failure<T, E> extends Result<T, E> {
  final E error;
  Failure({required this.error});

  @override
  String toString() => 'Failure(error: $error)';
}