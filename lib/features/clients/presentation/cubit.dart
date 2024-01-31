import 'package:employee_management/core/feature/data/models/client_model.dart';

import '../../../core/base_state.dart';
import '../../../export.dart' hide MaterialState;
import '../domain/usecases/usecases.dart';

class ClientCubit extends Cubit<BaseState<List<ClientModel>>> {
  final ClientUseCase usecase;

  ClientCubit({required this.usecase})
      : super(const BaseState<List<ClientModel>>(status: RxStatus.Loading));

  Future<void> getAll() async {
    try {
      emit(state.copyWith(status: RxStatus.Loading));
      final res = await usecase.getAll();
      res.fold(
          (l) => logger.i(l),
          (r) => r.listen((event) {
                emit(
                  state.copyWith(
                    status: event.isEmpty ? RxStatus.Empty : RxStatus.Success,
                    data: event,
                  ),
                );
              }));
    } catch (error) {
      emit(state.copyWith(
          status: RxStatus.Error, errorMessage: error.toString()));
    }
  }

  save(ClientModel? item, List<String> textControllers) async {
    /// add all item properties as not to reset any property
    final isCreate = item?.id == null;
    final savedItem = ClientModel(
      id: item?.id,
      isDeleted: item?.isDeleted,
      name: textControllers[0],
      phone: textControllers[1],
    );
    final res = await (isCreate ? _create(savedItem) : _update(savedItem));
    return res.fold((l) => showSimpleDialog(text: l),
        (r) => r is ClientModel ? r : 'Success');
  }

  _create(ClientModel item) async => usecase.create(item);

  _update(ClientModel item) async => usecase.update(item);

  // TODO employee should delete his items only
  delete(String? id) async =>
      handleRequest(() async => await usecase.delete(id ?? ''));
}
