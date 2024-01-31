import 'package:auto_route/auto_route.dart';
import 'package:employee_management/core/base_state.dart';
import 'package:employee_management/core/feature/data/models/employee_model.dart';
import '../../../core/app_router.dart';
import '../../../core/view/widgets/custom_list_view_builder.dart';
import '../../../export.dart';
import 'employee_cubit.dart';

@RoutePage()
class EmployeePage extends StatelessWidget {
  final SearchController searchController = SearchController();
  final screenCubit = sl<EmployeeCubit>()..getAll();

  EmployeePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomAppBar(title: 'Employees', searchController: searchController),
      drawer: const AppDrawer(),
      body: BlocConsumer<EmployeeCubit, BaseState<List<EmployeeModel>>>(
        bloc: screenCubit,
        listener: (BuildContext context, BaseState<List<EmployeeModel>> state) {
          if (state.errorMessage != null) {
            showWarningDialog(text: state.errorMessage);
          }
        },
        builder: (BuildContext context, BaseState<List<EmployeeModel>> state) {
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
        onPressed: () => context.pushRoute(EmployeeDetailsRoute()),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildBody(List<EmployeeModel> data) {
    return data.isEmpty
        ? LocaleKeys.no_data.tr().text.bold.xl.makeCentered().p8()
        : CustomListViewBuilder(
            footer: 40.heightBox,
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              final item = data[index];
              return ListTile(
                title: item.name?.text.bold.xl.make(),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    item.jobTitle.toString().text.make(),
                    item.email.toString().text.make(),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.copy).onTap(() async {
                      await Clipboard.setData(
                          ClipboardData(text: item.id ?? ''));
                      await showSuccessSnack(text: 'Copied Successfully');
                    }).px8(),
                    const Icon(Icons.delete).onTap(() async {
                      await screenCubit.delete(item.id);
                    }),
                  ],
                ),
                onTap: () =>
                    context.pushRoute(EmployeeDetailsRoute(employee: item)),
              ).card.make();
            },
          ).px8().py8();
  }
}
