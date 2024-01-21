import 'package:auto_route/auto_route.dart';
import 'package:employee_management/core/app_router.dart';
import 'package:employee_management/core/base_state.dart';
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
          CustomAppBar(title: 'Employees', searchController: searchController),
      body: BlocBuilder<MaterialCubit, BaseState<List<MaterialModel>>>(
        bloc: screenCubit,
        builder: (BuildContext context, BaseState<List<MaterialModel>> state) {
          switch (state.status) {
            case RxStatus.Loading:
              return Center(child: CircularProgressIndicator());
            case RxStatus.Error:
              return state.errorMessage!.text.bold.red500.makeCentered();
            case RxStatus.Empty:
              return LocaleKeys.no_data.text.bold.makeCentered();
            default:
              return buildBody(state.data!);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushRoute(EmployeeDetailsRoute()),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget buildBody(List<MaterialModel> data) {
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) => 4.heightBox,
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        final item = data[index];
        return ListTile(
          title: item.name?.text.bold.xl.make(),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              item.name.toString().text.make(),
              item.description.toString().text.make(),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.copy).onTap(() async {
                await Clipboard.setData(ClipboardData(text: item.id ?? ''));
                await showSuccessSnack(text: 'Copied Successfully');
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
