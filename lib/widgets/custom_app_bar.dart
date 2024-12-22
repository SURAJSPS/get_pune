import 'package:flutter/material.dart';
import '../constants/app_translations.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleKey;
  final bool showLanguageSwitch;
  final ValueChanged<bool>? onLanguageChanged;
  final List<Widget>? additionalActions;
  final bool showHomeButton;
  final VoidCallback? onBackPressed;

  const CustomAppBar({
    super.key,
    required this.titleKey,
    this.showLanguageSwitch = true,
    this.onLanguageChanged,
    this.additionalActions,
    this.showHomeButton = true,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
      ),
    
      actions: [
        
        if (additionalActions != null) ...additionalActions!,
        if (showHomeButton)
          IconButton(
            icon: const Icon(Icons.home, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/',
                (route) => false,
              );
            },
          ),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}


String languageId="en";