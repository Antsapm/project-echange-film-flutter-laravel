import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String? value;
  final String? label;
  final String? placeholder;
  final List<dynamic>? items;
  final Function(String?) onChanged;

  CustomDropdown({
    required this.value,
    required this.items,
    required this.label,
    required this.placeholder,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showMenu(
          context: context,
          position: RelativeRect.fromLTRB(0, 0, 0, 0),
          items: items!.map((item) {
            return PopupMenuItem<String>(
              value: item!['id'].toString(),
              child: Text(item!['label'].toString()),
            );
          }).toList(),
        ).then((selectedValue) {
          if (selectedValue != null) {
            onChanged(selectedValue);
          }
        });
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontSize: 20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(value ?? placeholder.toString()),
            const Icon(
              Icons.arrow_drop_down,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
