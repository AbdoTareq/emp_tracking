import 'package:flutter/material.dart';

class SingleSelectBottomSheet extends StatelessWidget {
  const SingleSelectBottomSheet({
    Key? key,
    required this.title,
    required this.choices,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final void Function(int)? onTap;
  final List<String> choices;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(title),
            Expanded(
              child: ListView.builder(
                itemCount: choices.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      onTap!(index);
                      return;
                    },
                    title: Text(choices[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
