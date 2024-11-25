import 'package:flutter/material.dart';
import 'package:pune_gst/presentation/appeal_page.dart';
import 'package:pune_gst/widgets/app_widget.dart';
import 'package:pune_gst/widgets/card_tile.dart';
import 'package:pune_gst/widgets/custom_app_bar.dart';


class LanguageSelector extends StatefulWidget {
  const LanguageSelector({super.key});

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  String selectedLanguage='English';
  final languages = [
    {'code': 'en', 'name': 'English'},
    {'code': 'hi', 'name': 'हिंदी'},
  ];

  @override
  Widget build(BuildContext context) {
    return AppWidget(
        isAppBar: false,
        heading:
            'Central Goods and Services Tax\nAppeals-II Commissionerate Pune',
        subHeading: 'Choose Your Language',
        cardHeading: 'Choose Your Language',
        cardSubHeading: 'अपनी भाषा चुनें',
        onPressed:
             () {
                Navigator.push(
                  context,
            MaterialPageRoute(
              builder: (context) => const AppealPage()
            ),
                );
              }
            ,
        children: [
          ...languages.map((lang) => CustomSelectionTile(
                title: lang['name']!,
                isSelected: languageId == lang['code'],
                onTap: () {
                  setState(() {
                    languageId = lang['code']!;
                    selectedLanguage = lang['name']!;
                  });
                },
                width: MediaQuery.of(context).size.width / 2,
              )),
        ]);
  }
}
