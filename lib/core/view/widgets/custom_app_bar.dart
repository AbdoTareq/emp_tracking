import 'package:auto_route/auto_route.dart';

import '../../../export.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.searchList,
    this.searchController,
  });

  final SearchController? searchController;
  final String title;
  final List<dynamic>? searchList;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        iconTheme: const IconThemeData(color: kWhiteColor),
        title: title.tr().text.xl.white.bold.make(),
        leading: context.router.canPop()
            ? const BackButton(color: kWhiteColor)
            : null,
        actions: [
          searchList == null
              ? Container()
              : SearchAnchor(
                  searchController: searchController,
                  builder: (context, SearchController searchController) =>
                      IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            searchController.openView();
                          }),
                  viewHintText: 'Start typing to filter',
                  suggestionsBuilder:
                      (context, SearchController searchController) =>
                          searchList!
                              .where((element) =>
                                  element.title.contains(searchController.text))
                              .map((e) => ListTile(
                                  title: e.title.tr().text.bold.xl.make(),
                                  onTap: () {
                                    searchController.closeView('');
                                    // pushNewScreen(context, screen: PostDetailsView(e));
                                  })),
                )
        ]);
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
