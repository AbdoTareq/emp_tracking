import 'package:auto_route/auto_route.dart';
import 'package:employee_management/core/app_router.dart';
import 'package:employee_management/export.dart';
import 'package:employee_management/features/employee/presentation/employee_cubit.dart';
import 'package:employee_management/features/employee/presentation/employee_state.dart';

@RoutePage()
class EmployeePage extends StatelessWidget {
  final SearchController searchController = SearchController();
  final screenCubit = sl<EmployeeCubit>()..getAll();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => screenCubit,
      child: Scaffold(
        appBar: CustomAppBar(
            title: 'Employees', searchController: searchController),
        body: BlocConsumer<EmployeeCubit, EmployeeState>(
          bloc: screenCubit,
          listener: (BuildContext context, EmployeeState state) {
            if (state.error != null) {
              showWarningDialog(text: state.error);
            }
          },
          builder: (BuildContext context, EmployeeState state) {
            if (state.isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            return buildBody(state);
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.pushRoute(EmployeeDetailsRoute()),
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Widget buildBody(EmployeeState state) {
    return state.data.isEmpty
        ? no_data.tr().text.bold.xl.makeCentered().p8()
        : ListView.separated(
            separatorBuilder: (BuildContext context, int index) => 4.heightBox,
            itemCount: state.data.length,
            itemBuilder: (BuildContext context, int index) {
              final item = state.data[index];
              return ListTile(
                title: item.name?.text.bold.xl.make(),
                subtitle: item.jobTitle?.text.bold.xl.make(),
                onTap: () =>
                    context.pushRoute(EmployeeDetailsRoute(employee: item)),
              ).card.make();
            },
          ).px8().py8();
  }
}
