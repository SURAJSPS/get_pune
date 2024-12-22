import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pune_gst/core/config/config_reader.dart';
import 'package:pune_gst/presentation/appeal_details_page.dart';
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
  String? selectedAppealType;



  @override
  Widget build(BuildContext context) {
    return AppWidget(
        subHeading: languageId == "hi" ? 'विकल्प चुनें' : 'Select Option',
        onPressed: selectedAppealType != null
            ? () {
                if (selectedAppealType != "jurisdiction") {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>  AppealSelectionPage(
                        appealTypes: config["dashboard"]["data"][0]
                      ),
                    ),
                  );
                } else {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => JurisdictionPage(

                      subHeading: config["dashboard"]["data"].firstWhere((type) => type['code'] == selectedAppealType)['title'][languageId] as String,
                    ),
                  ));
                }
              }
            : null,
        children: [
          ...config["dashboard"]["data"].map((type) => CustomSelectionTile(
                title: type['title'][languageId] as String,
                isSelected: selectedAppealType == type['code'],
                onTap: () {
                  setState(() {
                    selectedAppealType = type['code'] as String?;
                  });
                },
                width: MediaQuery.of(context).size.width / 2,
              )),
        ]);
  }
}
