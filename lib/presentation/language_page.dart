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
import 'package:pune_gst/file_reader.dart' show ExcelService;
import 'package:pune_gst/presentation/image_card.dart';
import 'package:pune_gst/widgets/app_widget.dart';

import '../json.dart';
import '../widgets/dropdown_widget.dart';

late Map<String, dynamic>? sheetData;

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
  bool isCCO = false;

  @override
  Widget build(BuildContext context) {
    return AppWidget(
        isEnable: false,
        showDisclaimer: true,
        isAppBar: false,
        appName: "DISHA",
        // isAppName: false,
        heading:
            "Central Goods and Services Tax & Customs, Pune Zone\nकेंद्रीय वस्तु एवं सेवा कर और सीमा शुल्क, पुणे क्षेत्र",
        // subHeading: '',
        // cardHeading: '',

        onPressed: () {},
        children: [
          // TextButton(
          //     onPressed: ()async {
          //   final data=  await  ExcelService.readExcelFile().then((value){
          //     ExcelService.jsonStructureCre(value);
          //   });
          //   print(data);
          //       // ExcelService.jsonStructureCre(jsonData);
          //     },
          //     child: Text("getData")),
          // TextButton(
          //     onPressed: () {
          //       if (sheetData != null) {
          //         // JsonCreator.createJson(sheetData!);
          //       }
          //     },
          //     child: Text("Convert Data")),
          if (data["formations"] != null)
            DropDownWidget(
              title: "Formation",
              data["formations"]?.map((formation) => formation).toList() ?? [],
              hint: "Select Formation",
              value: selection,
              // (config['formation'] as Map<String, dynamic>)
              //     .map((key, value) => MapEntry(key, value)),
              onChanged: (value) {
                setState(() {
                  selection = value;
                  isCCO = false;
                  commissioners = null;
                  divisions = null;
                  section = null;
                  address = null;

                  if (value != null && value["id"] == "cco") {
                    isCCO = true;
                    // selection=null;
                    commissioners = value['commissionerates'].first;
                  }
                });
              },
            ),
          if ((selection?.isNotEmpty ?? false) && isCCO == false) ...[
            DropDownWidget(
              title: "Commissionerate",
              hint: "Select Commissionerate",
              value: commissioners,
              selection?['commissionerates'] as List,
              // Map.fromEntries((selection?['commissionerates'] as List)
              //     .map((value) => MapEntry(value['id'] as String, value))),
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
              title: "Section",
              hint: "Select Section",
              value: divisions,
              commissioners?['divisions'] as List,
              // Map.fromEntries((commissioners?['divisions'] as List)
              //     .map((value) => MapEntry(value['id'] as String, value))),
              onChanged: (value) {
                setState(() {
                  divisions = value;
                  section = null;
                  address = null;
                });
              },
            ),
          ],
          if ((divisions?.isNotEmpty ?? false) &&
              divisions?['ranges'][0]["name"] != "") ...[
            DropDownWidget(
              title: "Section",
              hint: "Select Section",
              value: section,
              divisions?['ranges'] as List,
              // Map.fromEntries((divisions?['ranges'] as List)
              //     .map((value) => MapEntry(value['id'] as String, value))),
              onChanged: (value) {
                setState(() {
                  section = value;
                });
              },
            ),
          ],
          if ((section?.isNotEmpty ?? false)) ...[
            SizedBox(height: 20),
            Center(
              child: Text(
                "✯ Address ✯",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                section?['addresses'],
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo),
              ),
            ),
            if (section?['addresses'] != null &&
                (section?['addresses'] as String).contains("411001")) ...[
              Center(
                child: ImageCard(
                  address: divisions?['ranges'][0]['addresses'],
                ),
              )
            ]
          ],
          if (divisions != null &&
              divisions!.isNotEmpty &&
              divisions?['ranges'][0]["name"] == "") ...[
            SizedBox(height: 20),
            Center(
              child: Text(
                "✯ Address ✯",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            Center(
                child: Text(
              divisions?['ranges'][0]['addresses'],
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo),
            )),
            if (divisions?['ranges'][0]['addresses'] != null &&
                (divisions?['ranges'][0]['addresses'] as String)
                    .contains("411001")) ...[
              Center(
                child: ImageCard(
                  address: divisions?['ranges'][0]['addresses'],
                ),
              )
            ]
          ]
        ]);
  }
}
