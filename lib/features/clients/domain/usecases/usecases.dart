import '../../../../core/feature/data/models/client_model.dart';
import '../../../../core/feature/domain/usecases/usecases.dart';

class ClientUseCase extends UseCase<ClientModel> {
  ClientUseCase(
      {required super.repository,
      required super.instance,
      required super.collectionName});
}
