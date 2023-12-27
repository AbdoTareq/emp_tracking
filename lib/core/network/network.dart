import 'package:dio/dio.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter_new_template/core/error/exceptions.dart';
import 'package:requests_inspector/requests_inspector.dart';

import '../../export.dart';

final _baseUrl = 'https://jsonplaceholder.typicode.com/';

class Network {
  final dio = Dio(BaseOptions(
      connectTimeout: Duration(seconds: 1000),
      receiveTimeout: Duration(seconds: 1000),
      validateStatus: (_) => true))
    ..interceptors.add(RequestsInspectorInterceptor());

  Map<String, String?> headers = {
    'Accept': 'application/json',
    'locale': isEn() ? 'en' : 'ar',
    "Keep-Alive": "timeout=12",
    'Authorization': GetStorage().hasData("token")
        ? 'Bearer ${GetStorage().read("token")}'
        : null,
  };

  Future<http.Response> req(
      Future<http.Response> Function() requestType) async {
    final response = await requestType();
    if (response.statusCode! > 210 || response.statusCode! < 200) {
      logger.i(response.data);
      throw ServerException(message: response.data);
    }
    // success
    return response;
  }

  String _getParamsFromBody(dynamic body) {
    String params = '';
    for (var i = 0; i < body?.keys.length; i++) {
      params += '${List.from(body?.keys)[i]}=${List.from(body?.values)[i]}';
      if (i != body!.keys.length - 1) {
        params += '&';
      }
    }
    return params;
  }

  Future<http.Response> post(String endPoint, dynamic body,
      {bool isParamData = false, String? baseUrl}) async {
    return req(() {
      return dio.post(
          (baseUrl ?? _baseUrl) +
              endPoint +
              (isParamData ? _getParamsFromBody(body) : ''),
          data: isParamData ? {} : body,
          options: Options(headers: headers));
    });
  }

  Future<http.Response> put(
    String endPoint,
    dynamic body,
  ) {
    return req(() {
      return dio.put(_baseUrl + endPoint,
          data: body, options: Options(headers: headers));
    });
  }

  Future<http.Response> delete(
    String endPoint,
    dynamic body,
  ) {
    return req(() {
      return dio.delete(_baseUrl + endPoint,
          data: body, options: Options(headers: headers));
    });
  }

  Future<http.Response> get(String endPoint, dynamic body, {String? baseUrl}) {
    return req(() {
      return dio.get((baseUrl ?? _baseUrl) + endPoint,
          options: Options(headers: headers));
    });
  }

  downloadFileFromUrl(String url, String savePath) async {
    await dio.download(url, savePath, onReceiveProgress: (received, total) {});
    print("File is saved to download folder.");
  }
}
