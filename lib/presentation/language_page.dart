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
        isAppBar: false,
        appName: "VIDHAAN",
        heading:
            "Central Goods and Services Tax, Appeals-II Commissionerate Pune\nकेंद्रीय वस्तु एवं सेवा कर, अपील-II आयुक्तालय, पुणे",
        subHeading: 'Choose Your Language',
        cardHeading: 'Choose Your Language',
        cardSubHeading: 'अपनी भाषा चुनें',
        onPressed: () {
          closeAudio();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AppealPage()),
          );
        },
        children: [
          ...config["language"].map((lang) => CustomSelectionTile(
                title: lang['name']!,
                isSelected: languageId == lang['code'],
                onTap: () {
                  setState(() {
                    languageId = lang['code']!;
                    selectedLanguage = lang['name']!;
                  });
                  playAudio();
                },
                width: MediaQuery.of(context).size.width / 2,
              )),
        ]);
  }

  void playAudio() async {
    if (!_mounted) return;

    try {
      await player.play(AssetSource("audio/${languageId}.mp3"));
    } catch (e) {
      debugPrint('Error playing audio: $e');
    }
  }

  void closeAudio() {
    if (!_mounted) return;
    player.pause();
  }
}
