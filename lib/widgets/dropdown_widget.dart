
import 'package:flutter/material.dart';

class DropDownWidget extends StatelessWidget {
  final Map<String, dynamic> items;
  final String hint;
  final Map<String, dynamic>? value;
  final void Function(Map<String, dynamic>? value) onChanged;
  const DropDownWidget(this.items,
      {super.key, required this.onChanged, this.value, required this.hint});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Map<String, dynamic>>(
      borderRadius: BorderRadius.circular(12),


      elevation: 2,
      hint: Text(hint),
      value: items.keys.contains(value?['id']) ? value : null,
      isExpanded: true,
      items: items.entries.map((entry) {
        return DropdownMenuItem<Map<String, dynamic>>(
          value: entry.value,
          child: Text(
            entry.value['name'] as String,
            maxLines: 1,
            style: TextStyle(),
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
