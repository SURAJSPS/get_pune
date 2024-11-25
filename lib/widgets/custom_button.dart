import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final String? textHindi;
  final VoidCallback onPressed;
  final bool isEnabled;
  final bool isHindi;
  final double? width;
  final Color? backgroundColor;

  const CustomButton({
    super.key,
    required this.text,
    this.textHindi,
    required this.onPressed,
    this.isEnabled = true,
    this.isHindi = false,
    this.width=100,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ??  Colors.red,
        minimumSize: Size(width ?? double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: isEnabled ? 2 : 0,
        disabledBackgroundColor: Colors.grey[300],
      ),
      child: Text(
        isHindi ? textHindi ?? '' : text,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
} 