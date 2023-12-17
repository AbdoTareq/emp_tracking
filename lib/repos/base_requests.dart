import 'package:dio/dio.dart';

import '../export.dart';

class BaseRequests {
  GetStorage box = GetStorage();
  Future<Either<Failure, ServerResponse>> basePost(
      String endPoint, dynamic body,
      {String? baseUrl}) async {
    Network network = Network(endPoint: endPoint, body: body);
    try {
      var res = await network.post(baseUrl: baseUrl);
      try {
        return Right(ServerResponse.fromJson(res.data));
      } catch (e) {
        return Right(ServerResponse(data: res.data));
      }
    } on Exception catch (e) {
      return Left(Failure(message: e.toString()).handleNetworkError(e));
    }
  }

  Future<Either<Failure, ServerResponse>> baseUpload(
      String endPoint, FormData formData) async {
    Network network = Network(endPoint: endPoint, body: formData);
    try {
      var res = await network.post();
      return Right(ServerResponse.fromJson(res.data));
    } on Exception catch (e) {
      return Left(Failure(message: e.toString()).handleNetworkError(e));
    }
  }

  Future<Either<Failure, ServerResponse>> basePut(
      String endPoint, Map<String, dynamic> body) async {
    Network network = Network(endPoint: endPoint, body: body);
    try {
      var res = await network.put();
      return Right(ServerResponse.fromJson(res.data));
    } on Exception catch (e) {
      return Left(Failure(message: e.toString()).handleNetworkError(e));
    }
  }

  Future<Either<Failure, ServerResponse>> baseDelete(
      String endPoint, Map<String, dynamic> body) async {
    Network network = Network(endPoint: endPoint, body: body);
    try {
      var res = await network.delete();
      return Right(ServerResponse.fromJson(res.data));
    } on Exception catch (e) {
      return Left(Failure(message: e.toString()).handleNetworkError(e));
    }
  }

  Future<Either<Failure, ServerResponse>> baseGet(
    String endPoint, {
    String? baseUrl,
    String? cashName,
    bool refreshFromServer = false,
    dynamic body,
  }) async {
    try {
      if (box.hasData(cashName.toString()) && !refreshFromServer) {
        return Right(ServerResponse.fromJson(box.read(cashName.toString())));
      } else {
        Network network = Network(endPoint: endPoint, body: body);
        var res = await network.get(baseUrl: baseUrl);
        if (cashName != null) {
          if (res.data != null) {
            if (res.data.runtimeType == List) {
              if ((res.data as List).isNotEmpty) {
                box.write(cashName, res.data);
              }
            } else
              box.write(cashName, res.data);
          }
        }
        return Right(ServerResponse(data: res.data));
      }
    } catch (e) {
      return Left(Failure(message: e.toString()).handleNetworkError(e));
    }
  }
}
