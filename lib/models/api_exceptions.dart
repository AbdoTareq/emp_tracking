class ApiException implements Exception {
  final String url;
  final String message;
  final int? statusCode;

  ApiException({
    required this.url,
    required this.message,
    this.statusCode,
  });

  /// IMPORTANT NOTE
  /// here you can take advantage of toString() method to display the error for user
  /// lets make an example
  /// so in onError method when you make api you can just user apiExceptionInstance.toString() to get the error message from api
  @override
  toString() {
    String result = '';

    if (result.isEmpty) {
      result +=
          message; // message is the (dio error message) so usualy its not user friendly
    }

    return result;
  }
}
