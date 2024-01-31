import 'package:auto_route/auto_route.dart';
import 'package:employee_management/core/feature/data/models/client_model.dart';

import '../../../core/app_router.dart';
import '../../../core/base_state.dart';
import '../../../core/view/widgets/custom_list_view_builder.dart';
import '../../../export.dart';
import 'cubit.dart';

@RoutePage()
class ClientPage extends StatelessWidget {
  final SearchController searchController = SearchController();
  final screenCubit = sl<ClientCubit>()..getAll();

  ClientPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomAppBar(title: 'Clients', searchController: searchController),
      body: BlocBuilder<ClientCubit, BaseState<List<ClientModel>>>(
        bloc: screenCubit,
        builder: (BuildContext context, BaseState<List<ClientModel>> state) {
          switch (state.status) {
            case RxStatus.Loading:
              return const Center(child: CircularProgressIndicator());
            case RxStatus.Error:
              return state.errorMessage!.text.bold.red500.makeCentered();
            case RxStatus.Empty:
              return LocaleKeys.no_data.tr().text.bold.makeCentered();
            default:
              return buildBody(state.data!);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushRoute(MaterialDetailsRoute()),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildBody(List<ClientModel> data) {
    return CustomListViewBuilder(
      itemCount: data.length,
      footer: 40.heightBox,
      itemBuilder: (BuildContext context, int index) {
        final item = data[index];
        return ListTile(
          title: item.name?.text.bold.xl.make(),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              item.name.toString().text.make(),
              item.phone.toString().text.make(),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.edit).onTap(() async {
                context.pushRoute(ClientDetailsRoute(item: item));
              }).px8(),
              const Icon(Icons.delete).onTap(() async {
                await screenCubit.delete(item.id);
              }),
            ],
          ),
          onTap: () => context.pushRoute(ClientDetailsRoute(item: item)),
        ).card.make();
      },
    ).px8().py8();
  }
}
