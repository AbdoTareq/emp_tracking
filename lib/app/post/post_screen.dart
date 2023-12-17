import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_new_template/app/post/post_cubit.dart';
import 'package:flutter_new_template/app/post/post_state.dart';

import '../../export.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final screenCubit = PostCubit();
  final SearchController searchController = SearchController();

  @override
  void initState() {
    screenCubit.loadInitialData();
    screenCubit.getMoreListener();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Theme.of(context).textTheme.headlineSmall!.backgroundColor,
      drawer: AppDrawer(),
      appBar: CustomAppBar(
        title: 'Posts',
        searchList: screenCubit.state.data,
        searchController: searchController,
      ),
      body: BlocBuilder<PostCubit, PostState>(
        bloc: screenCubit,
        builder: (BuildContext context, PostState state) {
          if (state.error != null) {
            return state.error.toString().text.bold.xl.makeCentered().p8();
          }
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            controller: screenCubit.scrollController,
            itemCount: state.data!.length,
            itemBuilder: (BuildContext context, int index) {
              final post = state.data![index];
              return ListTile(
                title: post.title.text.bold.xl.make(),
                subtitle:
                    '${post.body.substring(0, 100)} ...'.text.bold.xl.make(),
              ).p4();
            },
          ).hFull(context);
        },
      ),
    );
  }
}
