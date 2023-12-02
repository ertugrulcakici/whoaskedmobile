class NotLoggedInError extends Error {
  final String? message;

  NotLoggedInError([this.message]);

  @override
  String toString() => "Exception: $message";
}
