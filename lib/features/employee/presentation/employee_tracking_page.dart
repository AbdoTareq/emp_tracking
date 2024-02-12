import 'package:employee_management/core/feature/data/models/employee_model.dart';
import 'package:employee_management/core/location_manager.dart';
import '../../../core/app_router.dart';
import '../../../core/view/widgets/custom_list_view_builder.dart';
import '../../../export.dart';
import 'employee_cubit.dart';

@RoutePage()
class EmployeeTrackingPage extends StatelessWidget {
  final screenCubit = sl<EmployeeCubit>()..getAll();

  EmployeeTrackingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Tracking'),
      drawer: const AppDrawer(),
      body: 'text'.tr().text.bold.xl.make().p8(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          sl<LocationManager>().listen();
        },
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
