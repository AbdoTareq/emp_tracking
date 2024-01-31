import '../../../export.dart';

/// a ListView.builder with a header which can scroll result = (Column([header, listListView.builder(shrinkWrap: true)])) but better in performance as it doesn't render all children at once it
class CustomListViewBuilder extends StatelessWidget {
  CustomListViewBuilder({
    Key? key,
    this.itemCount = 3,
    required this.itemBuilder,
    this.header,
    this.footer,
    this.separatorWidget,
  }) : super(key: key);

  final int itemCount;
  final Widget? Function(BuildContext, int) itemBuilder;
  final Widget? header;
  final Widget? separatorWidget;

  /// usually added for floatingActionButton hiding last list element
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) =>
          separatorWidget ?? 4.heightBox,
      itemCount: itemCount + 2,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return header ?? Container();
        } else if (index == itemCount + 1) {
          return footer ?? Container();
        } else {
          return itemBuilder(context, index - 1);
        }
      },
    );
  }
}
