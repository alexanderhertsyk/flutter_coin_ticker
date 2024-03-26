import 'package:coin_ticker/models/api_model.dart';
import 'package:coin_ticker/models/base_model.dart';
import 'package:coin_ticker/utils/service_dispatcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

typedef FromJson<T> = T Function(Map<String, dynamic> json);

abstract interface class IApiService implements IService {
  Uri getUri(String localPath, Map<String, Object> parameters);
  Future<ApiModel<dynamic>> getData(Uri uri);
  Future<ApiModel<T>> getParsedData<T extends BaseModel>(
      Uri uri, FromJson<T> fromJson);
}

class ApiService implements IApiService {
  final String baseUrl;

  static final _cache = <String, ApiService>{};

  ApiService._internal(this.baseUrl);

  factory ApiService({required String baseUrl}) {
    return _cache.putIfAbsent(baseUrl, () => ApiService._internal(baseUrl));
  }

  @override
  Uri getUri(String localPath, Map<String, Object> parameters) {
    var parametersString =
        parameters.entries.map((e) => '${e.key}=${e.value}').toList().join('&');

    return Uri.parse('$baseUrl/$localPath?$parametersString');
  }

  @override
  Future<ApiModel<dynamic>> getData(Uri uri) async {
    try {
      print(uri);
      final result = await http.get(uri);
      print(result.body);
      final decodedData = jsonDecode(result.body);

      return ApiModel(
        code: result.statusCode,
        response: decodedData,
      );
    } catch (e) {
      print(e);
      return ApiModel(code: 500, error: e.toString());
    }
  }

  @override
  Future<ApiModel<T>> getParsedData<T extends BaseModel>(
      Uri uri, FromJson<T> fromJson) async {
    try {
      print(uri);
      final result = await http.get(uri);
      print(result.body);
      final decodedData = jsonDecode(result.body);

      if (result.statusCode != 200) {
        return ApiModel<T>(
          code: result.statusCode,
          error: decodedData?['error'] ?? result.reasonPhrase,
        );
      }

      final responseMap = decodedData as Map<String, dynamic>;
      final T response = fromJson(responseMap);

      return ApiModel<T>(
        code: result.statusCode,
        response: response,
      );
    } catch (e) {
      print(e);
      return ApiModel<T>(code: 500, error: e.toString());
    }
  }
}
