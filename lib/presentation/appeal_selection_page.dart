import 'package:flutter/material.dart';
import 'package:pune_gst/presentation/appeal_document_checklist.dart';

import 'package:pune_gst/widgets/app_widget.dart';
import 'package:pune_gst/presentation/appeal_details_info_page.dart';
import 'package:pune_gst/widgets/card_tile.dart';
import 'package:pune_gst/widgets/custom_app_bar.dart';

class AppealSelectionPage extends StatefulWidget {
  final Map<String, dynamic> appealTypes;
  const AppealSelectionPage({super.key, required this.appealTypes});

  @override
  State<AppealSelectionPage> createState() => _AppealSelectionPageState();
}

class _AppealSelectionPageState extends State<AppealSelectionPage> {
  Map<String, dynamic>? selectedAppealType = {};

  @override
  Widget build(BuildContext context) {
    return AppWidget(
        subHeading:
            languageId == "hi" ? 'अपील प्रकार चुनें' : 'Select Appeal Type',
        onPressed: selectedAppealType != null
            ? () {
                if (selectedAppealType?["type"] == "table") {
                  return Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AppealDocumentsChecklist(
                          document: selectedAppealType!,
                          subHeading: selectedAppealType!["title"]
                              [languageId])));
                }

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        AppealDetailsInfoPage(appealType: selectedAppealType!),
                  ),
                );
              }
            : null,
        children: [
          ...widget.appealTypes[widget.appealTypes["code"]]
              .map((type) => CustomSelectionTile(
                    title: (type['title'][languageId] as String),

                    isSelected: selectedAppealType?["code"] == type['code'],
                    // isSelected: false,
                    onTap: () {
                      setState(() {
                        selectedAppealType = type;
                      });
                    },
                    width: MediaQuery.of(context).size.width / 2,
                  ))
        ]);
  }
}
