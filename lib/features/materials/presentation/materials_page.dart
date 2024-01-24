import 'package:auto_route/auto_route.dart';
import 'package:employee_management/core/app_router.dart';
import 'package:employee_management/core/base_state.dart';
import 'package:employee_management/core/view/widgets/custom_list_view_builder.dart';
import 'package:employee_management/export.dart';
import 'package:employee_management/features/materials/data/models/material_model.dart';

import 'material_cubit.dart';

@RoutePage()
class MaterialsPage extends StatelessWidget {
  final SearchController searchController = SearchController();
  final screenCubit = sl<MaterialCubit>()..getAll();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomAppBar(title: 'Materials', searchController: searchController),
      body: BlocBuilder<MaterialCubit, BaseState<List<MaterialModel>>>(
        bloc: screenCubit,
        builder: (BuildContext context, BaseState<List<MaterialModel>> state) {
          switch (state.status) {
            case RxStatus.Loading:
              return Center(child: CircularProgressIndicator());
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
        child: Icon(Icons.add),
      ),
    );
  }

  Widget buildBody(List<MaterialModel> data) {
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
              item.stock.toString().text.make(),
              item.description.toString().text.make(),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.edit).onTap(() async {
                context.pushRoute(MaterialDetailsRoute(item: item));
              }).px8(),
              Icon(Icons.delete).onTap(() async {
                await screenCubit.delete(item.id);
              }),
            ],
          ),
          onTap: () => context.pushRoute(MaterialDetailsRoute(item: item)),
        ).card.make();
      },
    ).px8().py8();
  }
}
