import 'package:dio/dio.dart';
import '../../export.dart';
import '../error/exceptions.dart';
import '../error/failures.dart';
import 'network.dart';
import 'network_info.dart';

class BaseRequests {
  final NetworkInfo networkInfo;
  final Network network;

  BaseRequests({required this.networkInfo, required this.network});

  Future<Either<Failure, ServerResponse>> basePost() async =>
      _handleNetworkError(network.post);

  Future<Either<Failure, ServerResponse>> basePut() async =>
      _handleNetworkError(network.put);

  Future<Either<Failure, ServerResponse>> baseDelete(
          String endPoint, Map<String, dynamic> body) async =>
      _handleNetworkError(network.delete);

  Future<Either<Failure, ServerResponse>> baseGet(
    String endPoint, {
    String? baseUrl,
    String? cashName,
    bool refreshFromServer = false,
    dynamic body,
  }) async =>
      _handleNetworkError(network.get);

  Future<Either<Failure, ServerResponse>> _handleNetworkError(
      Future<Response> Function() request) async {
    if (await networkInfo.isConnected) {
      try {
        final res = await request();
        return Right(ServerResponse(data: res.data));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
