import 'package:flutter/material.dart';
import 'package:pune_gst/core/config/config_reader.dart';
import 'package:pune_gst/presentation/appeal_details_page.dart';
import 'package:pune_gst/presentation/appeal_document_checklist.dart';
import 'package:pune_gst/presentation/appeal_selection_page.dart';
import 'package:pune_gst/widgets/custom_app_bar.dart';
import 'package:pune_gst/widgets/card_tile.dart';
import 'package:pune_gst/widgets/app_widget.dart';

class AppealPage extends StatefulWidget {
  const AppealPage({super.key});

  @override
  State<AppealPage> createState() => _AppealPageState();
}

class _AppealPageState extends State<AppealPage> {
  Map<String, dynamic>? selectedAppealAuthority;

  @override
  Widget build(BuildContext context) {
    return AppWidget(
        subHeading: languageId == "hi" ? 'विकल्प चुनें' : 'Select Option',
        onPressed: selectedAppealAuthority != null
            ? () {
                if (selectedAppealAuthority?["code"] == "flow_chart") {
                 
                  return Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AppealDocumentsChecklist(
                      subHeading: "Appeal Flowchart",
                      document: selectedAppealAuthority!,
                    ),
                  ));
                }

                if (selectedAppealAuthority?["code"] != "jurisdiction") {
                  final data = config["dashboard"]["data"].firstWhere((type) =>
                      type['code'] == selectedAppealAuthority?["code"]);

                  if (data != null) {
                    return Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            AppealSelectionPage(appealTypes: data),
                      ),
                    );
                  }
                } else {
                  return Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => JurisdictionPage(
                      subHeading: config["dashboard"]["data"].firstWhere(
                              (type) =>
                                  type['code'] ==
                                  selectedAppealAuthority?["code"])['title']
                          [languageId] as String,
                    ),
                  ));
                }
              }
            : null,
        children: [
          ...config["dashboard"]["data"].map((type) => CustomSelectionTile(
                title: type['title'][languageId] as String,
                isSelected: selectedAppealAuthority?["code"] == type['code'],
                onTap: () {
                  selectedAppealAuthority = type;
                  setState(() {});
                },
                width: MediaQuery.of(context).size.width / 2,
              )),
        ]);
  }
}
