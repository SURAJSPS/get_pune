// import 'package:flutter/material.dart';
// import 'package:pune_gst/core/config/config_reader.dart';
// import 'package:pune_gst/presentation/appeal_page.dart';
// import 'package:pune_gst/widgets/app_widget.dart';
// import 'package:pune_gst/widgets/card_tile.dart';
// import 'package:pune_gst/widgets/custom_app_bar.dart';
// import 'package:audioplayers/audioplayers.dart';
//
// class LanguageSelector extends StatefulWidget {
//   const LanguageSelector({super.key});
//
//   @override
//   State<LanguageSelector> createState() => _LanguageSelectorState();
// }
//
// class _LanguageSelectorState extends State<LanguageSelector> {
//   String selectedLanguage = 'English';
//   final player = AudioPlayer();
//   bool _mounted = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _mounted = true;
//   }
//
//   @override
//   void dispose() {
//     _mounted = false;
//     player.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AppWidget(
//         showDisclaimer: true,
//         isAppBar: false,
//         appName: "VIDHAAN",
//         heading:
//             "Central Goods and Services Tax, Appeals-II Commissionerate Pune\nकेंद्रीय वस्तु एवं सेवा कर, अपील-II आयुक्तालय, पुणे",
//         subHeading: 'Choose Your Language',
//         cardHeading: 'Choose Your Language',
//         cardSubHeading: 'अपनी भाषा चुनें',
//         onPressed: () {
//           closeAudio();
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => const AppealPage()),
//           );
//         },
//         children: [
//           ...config["language"].map((lang) => CustomSelectionTile(
//                 title: lang['name']!,
//                 isSelected: languageId == lang['code'],
//                 onTap: () {
//                   setState(() {
//                     languageId = lang['code']!;
//                     selectedLanguage = lang['name']!;
//                   });
//                   playAudio();
//                 },
//                 width: MediaQuery.of(context).size.width / 2,
//               )),
//         ]);
//   }
//
//   void playAudio() async {
//     if (!_mounted) return;
//
//     try {
//       await player.play(AssetSource("audio/$languageId.mp3"));
//     } catch (e) {
//       debugPrint('Error playing audio: $e');
//     }
//   }
//
//   void closeAudio() {
//     if (!_mounted) return;
//     player.pause();
//   }
// }

import 'package:flutter/material.dart';
import 'package:pune_gst/core/config/config_reader.dart';
import 'package:pune_gst/presentation/appeal_page.dart';
import 'package:pune_gst/widgets/app_widget.dart';
import 'package:pune_gst/widgets/card_tile.dart';
import 'package:pune_gst/widgets/custom_app_bar.dart';
import 'package:audioplayers/audioplayers.dart';

import '../widgets/dropdown_widget.dart';

class LanguageSelector extends StatefulWidget {
  const LanguageSelector({super.key});

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {

  Map<String, dynamic>? selection = {};
  Map<String, dynamic>? commissioners = {};
  Map<String, dynamic>? divisions = {};
  Map<String, dynamic>? section = {};
  Map<String, dynamic>? address = {};




  @override
  Widget build(BuildContext context) {
    return AppWidget(
        isEnable: false,
        showDisclaimer: true,
        isAppBar: false,
        appName: "DISHA",
        heading:
        "Central Goods and Services Tax, Appeals-II Commissionerate Pune\nकेंद्रीय वस्तु एवं सेवा कर, अपील-II आयुक्तालय, पुणे",
        // subHeading: '',
        // cardHeading: '',

        onPressed: () {},
        children: [
          DropDownWidget(
            hint: "Select Formation",
            value: selection,
            (config['formation'] as Map<String, dynamic>)
                .map((key, value) => MapEntry(key, value)),
            onChanged: (value) {
              setState(() {
                selection = value;
                commissioners = null;
                divisions = null;
                section = null;
                address = null;
              });
            },
          ),
          if (selection?.isNotEmpty ?? false) ...[
            DropDownWidget(
              hint: "Select Commissionerate",
              value: commissioners,
              Map.fromEntries((selection?['commissionerates'] as List)
                  .map((value) => MapEntry(value['id'] as String, value))),
              onChanged: (value) {
                setState(() {
                  commissioners = value;
                  divisions = null;
                  section = null;
                  address = null;
                });
              },
            ),
          ],
          if (commissioners?.isNotEmpty ?? false) ...[
            DropDownWidget(
              hint: "Select Section",
              value: divisions,
              Map.fromEntries((commissioners?['divisions'] as List)
                  .map((value) => MapEntry(value['id'] as String, value))),
              onChanged: (value) {
                setState(() {
                  divisions = value;
                  section = null;
                  address = null;
                });
              },
            ),
          ],
          if (divisions?.isNotEmpty ?? false) ...[
            DropDownWidget(
              hint: "Select Section",
              value: section,
              Map.fromEntries((divisions?['ranges'] as List)
                  .map((value) => MapEntry(value['id'] as String, value))),
              onChanged: (value) {
                setState(() {
                  section = value;
                });
              },
            ),
          ],

          if (section?.isNotEmpty ?? false) ...[
            SizedBox(height: 20),
            Text(section?['addresses'].first["name"])
          ]
        ]);
  }
}
