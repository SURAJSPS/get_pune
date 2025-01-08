import 'package:flutter/material.dart';
import 'package:pune_gst/core/app_util.dart';

class CustomSelectionTile extends StatelessWidget {
  final String title;

  final bool isSelected;
  final VoidCallback onTap;
  final double? width;

  const CustomSelectionTile({
    super.key,
    required this.title,

    required this.isSelected,
    required this.onTap,
     this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppUtil.isMobile()?MediaQuery.of(context).size.width:MediaQuery.of(context).size.width/2,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.only(bottom: 15),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: isSelected ? Colors.indigo.shade600.withOpacity(.9) : Colors.indigo.shade600.withOpacity(.2),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              if (isSelected)
                BoxShadow(
                  color: Colors.blue.withOpacity(0.3),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
            ],
          ),
          child: Row(
            children: [

              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              ),
              if (isSelected)
                const Icon(
                  Icons.check_circle,
                  color: Colors.white,
                ),
            ],
          ),
        ),
      ),
    );
  }
}