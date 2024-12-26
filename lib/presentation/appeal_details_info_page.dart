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
  Map<String, dynamic>? selectedAppealType = {};

  @override
  Widget build(BuildContext context) {
    return AppWidget(
        // subHeading: languageId == "hi" ? 'विकल्प चुनें' : 'Select Option',
        subHeading: widget.appealType["title"][languageId],
        onPressed: selectedAppealType != null
            ? () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AppealDocumentsChecklist(
                          document: selectedAppealType!,
                          subHeading: selectedAppealType!["title"][languageId],
                          index: 0,
                        )));
              }
            : null,
        children: [
          ...widget.appealType["appeal_sub_type"]
              .map((type) => CustomSelectionTile(
                    title: (type['title'][languageId]!),
                    isSelected: selectedAppealType?["code"] == type['code'],
                    onTap: () {
                     
                      setState(() {
                        selectedAppealType = type;
                      });
                    },
                    width: MediaQuery.of(context).size.width / 2,
                  )),
        ]);
  }
}
