import 'package:flutter/material.dart';
import 'package:pune_gst/core/config/config_reader.dart';
import 'package:pune_gst/presentation/appeal_document_checklist.dart';
import 'package:pune_gst/widgets/app_widget.dart';
import 'package:pune_gst/widgets/card_tile.dart';
import 'package:pune_gst/widgets/custom_app_bar.dart';

class JurisdictionPage extends StatefulWidget {
  final String subHeading;

  const JurisdictionPage({super.key, required this.subHeading});

  @override
  State<JurisdictionPage> createState() => _JurisdictionPageState();
}

class _JurisdictionPageState extends State<JurisdictionPage> {
  Map<String, dynamic> jurisdiction = {};

  @override
  Widget build(BuildContext context) {
    return AppWidget(
        
        subHeading: widget.subHeading,
        onPressed: jurisdiction.isNotEmpty
            ? () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AppealDocumentsChecklist(
                        document: jurisdiction,
                        subHeading: jurisdiction["heading"][languageId])));
              }
            : null,
        children: [

...config["jurisdiction"].map((data) => CustomSelectionTile(

            title: data["heading"][languageId] as String,
            isSelected: jurisdiction["id"] == data["id"],
            onTap: () {
              jurisdiction = data;
              setState(() {});
            },
            width: MediaQuery.of(context).size.width / 2,
          ),
          
        )
      ],
    );
  }
}







// class AppealDocumentsChecklist extends StatefulWidget {
//   final Map<String, dynamic> document;
//   final String subHeading;
//   final int index;
//
//   const AppealDocumentsChecklist(
//       {super.key,
//         required this.document,
//         required this.subHeading,
//         required this.index});
//
//   @override
//   State<AppealDocumentsChecklist> createState() =>
//       _AppealDocumentsChecklistState();
// }
//
// class _AppealDocumentsChecklistState extends State<AppealDocumentsChecklist> {
//   @override
//   Widget build(BuildContext context) {
//     return AppWidget(isEnable: false, subHeading: widget.subHeading, children: [
//
//       Center(
//           child: Text(
//             "CGST Act, 2017",
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           )),
//     ]);
//   }
// }