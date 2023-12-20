import 'package:dio/dio.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter_new_template/core/error/exceptions.dart';
import 'package:requests_inspector/requests_inspector.dart';

import '../export.dart' hide MultipartFile, FormData;

final _baseUrl = 'https://jsonplaceholder.typicode.com/';

class Network {
  final String endPoint;
  final dynamic body;

  // good practice to make one connection to server available to the app as we don't want to create a new connection every time we make server call

  Network({required this.endPoint, this.body});
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

  String _getParamsFromBody() {
    String params = '';
    for (var i = 0; i < body?.keys.length; i++) {
      params += '${List.from(body?.keys)[i]}=${List.from(body?.values)[i]}';
      if (i != body!.keys.length - 1) {
        params += '&';
      }
    }
    return params;
  }

  Future<http.Response> post(
      {bool isParamData = false, String? baseUrl}) async {
    return req(() {
      return dio.post(
          (baseUrl ?? _baseUrl) +
              endPoint +
              (isParamData ? _getParamsFromBody() : ''),
          data: isParamData ? {} : body,
          options: Options(headers: headers));
    });
  }

  Future<http.Response> put() {
    return req(() {
      return dio.put(_baseUrl + endPoint,
          data: body, options: Options(headers: headers));
    });
  }

  Future<http.Response> delete() {
    return req(() {
      return dio.delete(_baseUrl + endPoint,
          data: body, options: Options(headers: headers));
    });
  }

  Future<http.Response> get({String? baseUrl}) {
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
