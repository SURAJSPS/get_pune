import 'package:flutter/material.dart';

class DropDownWidget extends StatelessWidget {
  final List<dynamic> items;
  final String hint;
  final String title;
  final Map<String, dynamic>? value;
  final void Function(Map<String, dynamic>? value) onChanged;
  const DropDownWidget(this.items,
      {super.key,
      required this.onChanged,
      this.value,
      required this.hint,
      this.title = ""});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Text(title,
        //     style: TextStyle(
        //         fontSize: 16,
        //         fontWeight: FontWeight.w500,
        //         color: Theme.of(context).primaryColor)),
        // const SizedBox(
        //   height: 10,
        // ),
        DropdownButton<Map<String, dynamic>>(
          borderRadius: BorderRadius.circular(12),
          dropdownColor: Colors.white,
          elevation: 2,
          hint: Text(
            hint,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          value: items.contains(value) ? value : null,
          isExpanded: true,
          items: items.map((entry) {
            return DropdownMenuItem<Map<String, dynamic>>(
              value: entry,
              child: Text(
                entry['name'] as String,
                maxLines: 1,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
