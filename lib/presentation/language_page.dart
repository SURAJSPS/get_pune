import 'package:flutter/material.dart';
import 'package:pune_gst/core/config/config_reader.dart';
import 'package:pune_gst/presentation/appeal_page.dart';
import 'package:pune_gst/widgets/app_widget.dart';
import 'package:pune_gst/widgets/card_tile.dart';
import 'package:pune_gst/widgets/custom_app_bar.dart';
import 'package:audioplayers/audioplayers.dart';

class LanguageSelector extends StatefulWidget {
  const LanguageSelector({super.key});

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  String selectedLanguage = 'English';
  final player = AudioPlayer();
  bool _mounted = true;

  @override
  void initState() {
    super.initState();
    _mounted = true;
  }

  @override
  void dispose() {
    _mounted = false;
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppWidget(
        showDisclaimer: true,
        isAppBar: false,
        appName: "VIDHAAN",
        heading:
            "Central Goods and Services Tax, Appeals-II Commissionerate Pune\nकेंद्रीय वस्तु एवं सेवा कर, अपील-II आयुक्तालय, पुणे",
        subHeading: 'Choose Your Language',
        cardHeading: 'Choose Your Language',
        cardSubHeading: 'अपनी भाषा चुनें',
        onPressed: () {


        },
        children: [

        ]);
  }


}
