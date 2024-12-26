import 'package:flutter/material.dart';
import 'package:pune_gst/widgets/app_widget.dart';

class AppealDetailsPage extends StatefulWidget {
  final String name;
  const AppealDetailsPage({super.key, required this.name});

  @override
  State<AppealDetailsPage> createState() => _AppealDetailsPageState();
}

class _AppealDetailsPageState extends State<AppealDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(widget.name));
  }
}

class JurisdictionPage extends StatelessWidget {
  final String subHeading;

  const JurisdictionPage({super.key, required this.subHeading});

  @override
  Widget build(BuildContext context) {
    return AppWidget(isEnable: false, subHeading: subHeading, children: [
      Center(
          child: Text(
        "CGST Pune-II Commissionerate",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      )),
      
      _buildSubTitle("DIVISION-I SHIVAJI NAGAR"),
      _buildSubTitle("DIVISION-II SWARGATE"),
      _buildSubTitle("DIVISION-III DECCAN"),
      _buildSubTitle("DIVISION-IV KOTHRUD"),
      _buildSubTitle("DIVISION-V KHADAKWASLA"),
      _buildSubTitle("DIVISION-VI HADAPSAR"),
      _buildSubTitle("DIVISION-VII KATRAJ"),
      _buildSubTitle("SOLAPUR DIVISION"),
      _buildSubTitle("BARAMATI DIVISION"),
      Center(
          child: Text(
        "&",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      )),
      Center(
          child: Text(
        "Customs Commissionerate Pune",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      )),
    ]);
  }

  Widget _buildSubTitle(String subTitle) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
          child: Text(
        subTitle,
        style: TextStyle(fontSize: 14),
      )),
    );
  }
}






//
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