import 'package:coin_ticker/models/api_model.dart';
import 'package:coin_ticker/utils/service_dispatcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class INetworkService implements IService {
  Uri getUri(String localPath, Map<String, Object> parameters);
  Future<ApiModel> getData(Uri uri);
  //TODO: add generic getData w/ decode function as parameter
}

//TODO: rename to ApiService
class NetworkService implements INetworkService {
  final String baseUrl;

  static final _cache = <String, NetworkService>{};

  NetworkService._internal(this.baseUrl);

  factory NetworkService({required String baseUrl}) {
    return _cache.putIfAbsent(baseUrl, () => NetworkService._internal(baseUrl));
  }

  @override
  Uri getUri(String localPath, Map<String, Object> parameters) {
    var parametersString =
        parameters.entries.map((e) => '${e.key}=${e.value}').toList().join('&');

    return Uri.parse('$baseUrl/$localPath?$parametersString');
  }

  @override
  Future<ApiModel> getData(Uri uri) async {
    try {
      print(uri);
      final result = await http.get(uri);
      print(result.body);
      final response = jsonDecode(result.body);

      return ApiModel(
        code: result.statusCode,
        response: response,
      );
    } catch (e) {
      print(e);
      return ApiModel(code: 500, errorMessage: e.toString());
    }
  }
}
