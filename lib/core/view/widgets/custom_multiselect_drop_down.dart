import '../../../export.dart';

class CustomMultiselectDropDown extends StatefulWidget {
  final Function(List<String>) selectedList;
  final List<String> listOFStrings;

  CustomMultiselectDropDown(
      {required this.selectedList, required this.listOFStrings});

  @override
  createState() {
    return new _CustomMultiselectDropDownState();
  }
}

class _CustomMultiselectDropDownState extends State<CustomMultiselectDropDown> {
  List<String> listOFSelectedItem = [];
  String selectedText = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: ExpansionTile(
        iconColor: Colors.grey,
        title: (listOFSelectedItem.isEmpty ? "Select" : listOFSelectedItem[0])
            // .tr
            .tr()
            .text
            .bold
            .xl
            .make()
            .p8(),
        children: <Widget>[
          new ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.listOFStrings.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.only(bottom: 8.0),
                child: _ViewItem(
                    item: widget.listOFStrings[index],
                    selected: (val) {
                      selectedText = val;
                      if (listOFSelectedItem.contains(val)) {
                        listOFSelectedItem.remove(val);
                      } else {
                        listOFSelectedItem.add(val);
                      }
                      widget.selectedList(listOFSelectedItem);
                      setState(() {});
                    },
                    itemSelected: listOFSelectedItem
                        .contains(widget.listOFStrings[index])),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ViewItem extends StatelessWidget {
  String item;
  bool itemSelected;
  final Function(String) selected;

  _ViewItem(
      {required this.item, required this.itemSelected, required this.selected});

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: item.tr().text.bold.xl.make().p8(),
      value: itemSelected,
      dense: true,
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (val) {
        selected(item);
      },
      activeColor: Colors.blue,
    );
  }
}
