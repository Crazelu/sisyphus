class ApiResponse {
  final Map<String, dynamic> body;
  final bool hasError;
  final String? errorMessage;

  const ApiResponse({
    required this.body,
    this.hasError = false,
    this.errorMessage,
  });
}
