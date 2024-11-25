import 'package:flutter/material.dart';
import 'package:pune_gst/widgets/app_widget.dart';
import 'package:pune_gst/widgets/custom_app_bar.dart';

class AppealDocumentsChecklist extends StatefulWidget {
  final Map<String, dynamic> document;
  final String subHeading;
  final int index;

  const AppealDocumentsChecklist(
      {super.key,
      required this.document,
      required this.subHeading,
      required this.index});

  @override
  State<AppealDocumentsChecklist> createState() =>
      _AppealDocumentsChecklistState();
}

class _AppealDocumentsChecklistState extends State<AppealDocumentsChecklist> {
  @override
  Widget build(BuildContext context) {
    return AppWidget(isEnable: false, subHeading: widget.subHeading, children: [
      if (widget.index == 0) ...[
        ...widget.document["document_checklist"]
            .asMap()
            .entries
            .map((entry) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${entry.key + 1} : ",
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.indigo.shade600.withOpacity(.9)),
                          // style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                      Expanded(
                        flex: 12,
                        child: Text(
                          entry.value[languageId]["title"],
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                    ],
                  ),
                ))
      ] else ...[
        Center(
            child: Text(
          "CGST Act, 2017",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        )),
        SizedBox(
          height: 20,
        ),
        Text(widget.document["related_sections"]),
        SizedBox(
          height: 30,
        ),
        Center(
            child: Text(
              "CGST Rules, 2017",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
        SizedBox(
          height: 20,
        ),
        Center(
            child: Text(
          """Rule 108. Appeal to the Appellate Authority.-

(1) An appeal to the Appellate Authority under sub-section (1) of section 107 shall be filed in FORM GST APL-01, along with the relevant documents, 2[electronically], and a provisional acknowledgement shall be issued to the appellant immediately.

3[Provided that an appeal to the Appellate Authority may be filed manually in FORM GST APL-01, along with the relevant documents, only if-

(i) the Commissioner has so notified, or

(ii) the same cannot be filed electronically due to non-availability of the decision or order to be appealed against on the common portal,

and  in  such  case,  a  provisional  acknowledgement  shall  be  issued  to  the appellant immediately.]

(2) The grounds of appeal and the form of verification as contained in FORM GST APL-01 shall be signed in the manner specified in rule 26.

(3) 1[ Where the decision or order appealed against is uploaded on the common portal, a final acknowledgment, indicating appeal number, shall be issued in FORM GST APL-02 by the Appellate Authority or an officer authorised by him in this behalf and the date of issue of the provisional acknowledgment shall be considered as the date of filing of appeal:

Provided that where the decision or order appealed against is not uploaded on the common portal, the appellant shall submit a self-certified copy of the said decision or order within a period of seven days from the date of filing of FORM GST APL-01 and a final acknowledgment, indicating appeal number, shall be issued in FORM GST APL-02 by the Appellate Authority or an officer authorised by him in this behalf, and the date of issue of the provisional acknowledgment shall be considered as the date of filing of appeal: 

Provided further that where the said self-certified copy of the decision or order is not submitted within a period of seven days from the date of filing of FORM GST APL-01, the date of submission of such copy shall be considered as the date of filing of appeal.]

Explanation. -For the provisions of this rule, the appeal shall be treated as filed only when the final acknowledgement, indicating the appeal number, is issued.""",

        )),
        SizedBox(
          height: 20,
        ),
        Center(
            child: Text(
          """[Rule 109. Application to the Appellate Authority.-

(1) An application to the Appellate Authority under sub-section (2) of section 107 shall be filed in FORM GST APL-03, along with the relevant documents, 2[electronically] or otherwise as may be notified by the Commissioner and a provisional acknowledgment shall be issued to the appellant immediately.

3[Provided that an appeal to the Appellate Authority may be filed manually in FORM GST APL-03, along with the relevant documents, only if-

(i) the Commissioner has so notified, or

(ii) the same cannot be filed electronically due to non-availability of the decision or order to be appealed against on the common portal,

and in such case, a provisional acknowledgement shall be issued to the appellant immediately.]

(2) Where the decision or order appealed against is uploaded on the common portal, a final acknowledgment, indicating appeal number, shall be issued in FORM GST APL-02 by the Appellate Authority or an officer authorised by him in this behalf and the date of issue of the provisional acknowledgment shall be considered as the date of filing of appeal under sub-rule (1):

Provided that where the decision or order appealed against is not uploaded on the common portal, the appellant shall submit a self-certified copy of the said decision or order within a period of seven days from the date of filing of FORM GST APL-03 and a final acknowledgment, indicating appeal number, shall be issued in FORM GST APL-02 by the Appellate Authority or an officer authorised by him in this behalf, and the date of issue of the provisional acknowledgment shall be considered as the date of filing of appeal:

Provided further that where the said self-certified copy of the decision or order is not submitted within a period of seven days from the date of filing of FORM GST APL-03, the date of submission of such copy shall be considered as the date of filing of appeal.]""" )),SizedBox(
          height: 20,
        ),
        Center(
            child: Text(
          """Provided further that where the said self-certified copy of the decision or order is not submitted within a period of seven days from the date of filing of FORM GST APL-03, the date of submission of such copy shall be considered as the date of filing of appeal.]""" )),
      ]
    ]);
  }
}
