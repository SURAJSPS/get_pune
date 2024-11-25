import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pune_gst/presentation/appeal_details_page.dart';
import 'package:pune_gst/presentation/appeal_document_checklist.dart';
import 'package:pune_gst/widgets/app_widget.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/card_tile.dart';

class AppealDetailsInfoPage extends StatefulWidget {
  final Map<String, dynamic> appealType;
  const AppealDetailsInfoPage({super.key, required this.appealType});

  @override
  State<AppealDetailsInfoPage> createState() => _AppealDetailsInfoPageState();
}

class _AppealDetailsInfoPageState extends State<AppealDetailsInfoPage> {
  String? selectedAppealType;

  final appealTypes = [
    {
      'code': 'gat_appeal',
      'title_en': 'Document Required For Filing GST Appeal',
      'title_hi': 'जीएसटी अपील दस्तावेज़ आवश्यक',
    },
    {
      'code': 'service_tex_appeal',
      'title_en': 'Reverent Sections and Rules Related to GST Appeals',
      'title_hi': 'जीएसटी अपील से संबंधित धाराएं और नियम',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return AppWidget(
        subHeading: languageId == "hi" ? 'अिकल्प चुनें' : 'Select Option',
        onPressed: selectedAppealType != null
            ? () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AppealDocumentsChecklist(

                      index: appealTypes.indexOf(appealTypes.firstWhere((type) => type['code'] == selectedAppealType)),
                        document: widget.appealType,
                        subHeading: appealTypes.firstWhere((type) => type['code'] == selectedAppealType)['title_$languageId']!)));
              }
            : null,
        children: [
          ...appealTypes.map((type) => CustomSelectionTile(
                title: (type['title_$languageId']!),
                isSelected: selectedAppealType == type['code'],
                onTap: () {
                  setState(() {
                    selectedAppealType = type['code'];
                  });
                },
                width: MediaQuery.of(context).size.width / 2,
              )),
        ]);
  }
}
