import 'dart:convert';
import 'package:sissyphus/models/api_response.dart';
import 'package:sissyphus/utils/app_strings.dart';
import 'package:sissyphus/utils/logger.dart';
import 'package:http/http.dart' as http;

class HttpService {
  late final _logger = Logger(HttpService);

  Future<ApiResponse> get({required String path}) async {
    final fullPath = AppStrings.baseUrl + path;
    _logger.log(fullPath);
    final response = await http.get(Uri.parse(fullPath));

    _logger.log("Got response -> ${response.statusCode} ${response.body}");

    final responseBody = jsonDecode(response.body);
    Map<String, dynamic> json;

    if (responseBody is List) {
      json = {"data": responseBody};
    } else {
      json = responseBody as Map<String, dynamic>;
    }

    return ApiResponse(
      body: json,
      hasError: response.statusCode != 200,
    );
  }
}
