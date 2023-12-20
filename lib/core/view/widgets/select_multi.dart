import 'package:flutter_new_template/export.dart';

import '../../../main.dart';

// select all or multi or non & all is auto selected when selecting the rest
class SelectMulti<T> extends StatefulWidget {
  const SelectMulti(
      {super.key,
      required this.onChange,
      this.initialSelection,
      required this.choices,
      this.endPadding = 8.0,
      this.enableAll = true});

  final Function(List<T> selected) onChange;
  final List<T>? initialSelection;
  final List<T> choices;
  final bool enableAll;
  final double endPadding;

  @override
  State<SelectMulti<T>> createState() => _SelectMultiState<T>();
}

class _SelectMultiState<T> extends State<SelectMulti<T>> {
  Set<T> selectedList = {};

  @override
  void initState() {
    selectedList = (widget.initialSelection ?? []).toSet();
    super.initState();
  }

  void updateListLogic(int index, List<T> choices) {
    T _selectedOne = choices[index];
    // all is clicked chose all or clear all
    if (widget.enableAll) {
      if (index == 0) {
        selectedList =
            (!selectedList.contains(_selectedOne) ? choices : <T>[]).toSet();
      } else {
        selectedList.contains(_selectedOne)
            ? selectedList.remove(_selectedOne)
            : selectedList.add(_selectedOne);
        bool isAllSelected = selectedList.length == choices.length - 1 &&
            !selectedList.contains(choices[0]);
        isAllSelected
            ? selectedList.add(choices[0])
            : selectedList.remove(choices[0]);
      }
    } else {
      selectedList.contains(_selectedOne)
          ? selectedList.remove(_selectedOne)
          : selectedList.add(_selectedOne);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isEn() ? Alignment.centerRight : Alignment.centerLeft,
      child: Wrap(
        children: [
          for (var index = 0; index < widget.choices.length; index++)
            Padding(
              padding: EdgeInsetsDirectional.only(
                  end: index != widget.choices.length ? widget.endPadding : 0),
              child: ChoiceChip(
                onSelected: (isSelected) {
                  // update logic
                  updateListLogic(index, widget.choices);
                  // change UI
                  setState(() {});
                  // Notify parent
                  widget.onChange(selectedList.toList());
                },
                selected: selectedList.contains(widget.choices[index]),
                label: getName(widget.choices[index]).tr().text.make(),
              ),
            ),
        ],
      ),
    );
  }
}
