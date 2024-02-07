import 'package:employee_management/core/feature/data/models/attendance_model.dart';
import '../../../core/base_state.dart';
import '../../../core/view/widgets/custom_list_view_builder.dart';
import '../../../export.dart';

import 'cubit.dart';

@RoutePage()
class CheckInPage extends StatelessWidget {
  final screenCubit = sl<AttendanceCubit>()..getAll();

  CheckInPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Check In'),
      body: BlocBuilder<AttendanceCubit, BaseState<List<AttendanceModel>>>(
        bloc: screenCubit,
        builder:
            (BuildContext context, BaseState<List<AttendanceModel>> state) {
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
        onPressed: screenCubit.checkIn,
        child: const Icon(Icons.login),
      ),
    );
  }

  Widget buildBody(List<AttendanceModel> data) {
    return CustomListViewBuilder(
      itemCount: data.length,
      footer: 40.heightBox,
      itemBuilder: (BuildContext context, int index) {
        final item = data[index];
        return ListTile(
          title: item.name?.text.bold.xl.make(),
          subtitle: item.date.toString().text.make(),
        ).card.make();
      },
    ).px8().py8();
  }
}
