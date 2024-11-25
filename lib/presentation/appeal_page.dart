import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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

  final appealTypes = [
    {
      'code': 'apple',
      'title_en': 'Appeal Related Query',
      'title_hi': 'अपील संबंधित प्रश्न',
      'icon': CupertinoIcons.gear_alt_fill,
    },
    {
      'code': 'jurisdiction',
      'title_en': 'Jurisdiction Details',
      'title_hi': 'क्षेत्राधिकार विवरण',
      'icon': CupertinoIcons.money_dollar_circle_fill,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return AppWidget(
        subHeading: languageId == "hi" ? 'विकल्प चुनें' : 'Select Option',
        onPressed: selectedAppealType != null
            ? () {
                if (selectedAppealType != "jurisdiction") {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AppealSelectionPage(),
                    ),
                  );
                } else {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => JurisdictionPage(
                      subHeading: appealTypes.firstWhere((type) => type['code'] == selectedAppealType)['title_$languageId'] as String,
                    ),
                  ));
                }
              }
            : null,
        children: [
          ...appealTypes.map((type) => CustomSelectionTile(
                title: type['title_$languageId'] as String,
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
