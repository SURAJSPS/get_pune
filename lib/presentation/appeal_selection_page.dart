import 'package:flutter/material.dart';

import 'package:pune_gst/widgets/app_widget.dart';
import 'package:pune_gst/presentation/appeal_details_info_page.dart';
import 'package:pune_gst/widgets/card_tile.dart';
import 'package:pune_gst/widgets/custom_app_bar.dart';

class AppealSelectionPage extends StatefulWidget {
  const AppealSelectionPage({super.key});

  @override
  State<AppealSelectionPage> createState() => _AppealSelectionPageState();
}

class _AppealSelectionPageState extends State<AppealSelectionPage> {
  String? selectedAppealType;


  final appealTypes = [
    {
      'code': 'gat_appeal',
      'title_en': 'GST Appeal',
      'title_hi': 'जीएसटी अपील',
      "data":{
      "document_checklist":[ 
      {
        "id": 1,
        "hi": {
          "title":
          "फॉर्म जीएसटी-एपीएल-01, तथ्यों के विवरण और अपील के आधार के साथ",
        },
        "en": {
          "title":
          "Form GST-APL 01 along with Statement of facts and Grounds of Appeal",
        },
        "required": true
      },
      {
        "id": 2,
        "hi": {
          "title":
          "ओआईओ (ऑर्डर-इन-ओरिजिनल) की स्व-सत्यापित प्रति कोर्ट फी�� स्टैम्प के साथ",
        },
        "en": {
          "title":
          "Self-Attested Copy of OIO (Order-in-Original) along with Court fee Stamp",
        },
        "required": true
      },
      {
        "id": 3,
        "hi": {
          "title": "कारण बताओ नोटिस (एससीएन) की स्व-सत्यापित प्रति",
        },
        "en": {
          "title": "Self-Attested Copy of Show Cause Notice (SCN)",
        },
        "required": true
      },
      {
        "id": 4,
        "hi": {
          "title":
          "अपील अवधि के बाद दायर की गई अपील में देरी के लिए माफ़ी पत्र",
        },
        "en": {
          "title":
          "Letter of Condonation of delay in-case appeal filed after appeal period",
        },
        "required": false
      },
      {
        "id": 5,
        "hi": {
          "title": "प्री-डिपॉज़िट की चालान कॉपी",
        },
        "en": {
          "title": "Challan Copy of Pre-Deposit",
        },
        "required": false
      },
      {
        "id": 6,
        "hi": {
          "title": "कोई अन्य प्रासंगिक दस्तावेज़",
        },
        "en": {
          "title": "Any other relevant document",
        },
        "required": false
      }
    ],
      "related_sections": """* Section 107. Appeals to Appellate Authority.-

(1) Any person aggrieved by any decision or order passed under this Act or the State Goods and Services Tax Act or the Union Territory Goods and Services Tax Act by an adjudicating authority may appeal to such Appellate Authority as may be prescribed within three months from the date on which the said decision or order is communicated to such person.

(2) The Commissioner may, on his own motion, or upon request from the Commissioner of State tax or the Commissioner of Union territory tax, call for and examine the record of any proceedings in which an adjudicating authority has passed any decision or order under this Act or the State Goods and Services Tax Act or the Union Territory Goods and Services Tax Act, for the purpose of satisfying himself as to the legality or propriety of the said decision or order and may, by order, direct any officer subordinate to him to apply to the Appellate Authority within six months from the date of communication of the said decision or order for the determination of such points arising out of the said decision or order as may be specified by the Commissioner in his order.

(3) Where, in pursuance of an order under sub-section (2), the authorised officer makes an application to the Appellate Authority, such application shall be dealt with by the Appellate Authority as if it were an appeal made against the decision or order of the adjudicating authority and such authorised officer were an appellant and the provisions of this Act relating to appeals shall apply to such application.

(4) The Appellate Authority may, if he is satisfied that the appellant was prevented by sufficient cause from presenting the appeal within the aforesaid period of three months or six months, as the case may be, allow it to be presented within a further period of one month.

(5) Every appeal under this section shall be in such form and shall be verified in such manner as may be prescribed.

(6) No appeal shall be filed under sub-section (1), unless the appellant has paid-

(a) in full, such part of the amount of tax, interest, fine, fee and penalty arising from the impugned order, as is admitted by him; and

(b) a sum equal to ten per cent. of the remaining amount of tax in dispute arising from the said order, 1[subject to a maximum of 3[twenty] crore rupees], in relation to which the appeal has been filed.

2[Provided that no appeal shall be filed against an order under sub-section (3) of section 129, unless a sum equal to twenty-five per cent. of the penalty has been paid by the appellant.]

(7) Where the appellant has paid the amount under sub-section (6), the recovery proceedings for the balance amount shall be deemed to be stayed.

(8) The Appellate Authority shall give an opportunity to the appellant of being heard.

(9) The Appellate Authority may, if sufficient cause is shown at any stage of hearing of an appeal, grant time to the parties or any of them and adjourn the hearing of the appeal for reasons to be recorded in writing:

Provided that no such adjournment shall be granted more than three times to a party during hearing of the appeal.

(10) The Appellate Authority may, at the time of hearing of an appeal, allow an appellant to add any ground of appeal not specified in the grounds of appeal, if it is satisfied that the omission of that ground from the grounds of appeal was not wilful or unreasonable.

(11) The Appellate Authority shall, after making such further inquiry as may be necessary, pass such order, as it thinks just and proper, confirming, modifying or annulling the decision or order appealed against but shall not refer the case back to the adjudicating authority that passed the said decision or order:

Provided that an order enhancing any fee or penalty or fine in lieu of confiscation or confiscating goods of greater value or reducing the amount of refund or input tax credit shall not be passed unless the appellant has been given a reasonable opportunity of showing cause against the proposed order:

Provided further that where the Appellate Authority is of the opinion that any tax has not been paid or short-paid or erroneously refunded, or where input tax credit has been wrongly availed or utilised, no order requiring the appellant to pay such tax or input tax credit shall be passed unless the appellant is given notice to show cause against the proposed order and the order is passed within the time limit specified under section 73 or section 74 4[or section 74A].

(12) The order of the Appellate Authority disposing of the appeal shall be in writing and shall state the points for determination, the decision thereon and the reasons for such decision.

(13) The Appellate Authority shall, where it is possible to do so, hear and decide every appeal within a period of one year from the date on which it is filed:

Provided that where the issuance of order is stayed by an order of a court or Tribunal, the period of such stay shall be excluded in computing the period of one year.

(14) On disposal of the appeal, the Appellate Authority shall communicate the order passed by it to the appellant, respondent and to the adjudicating authority.

(15) A copy of the order passed by the Appellate Authority shall also be sent to the jurisdictional Commissioner or the authority designated by him in this behalf and the jurisdictional Commissioner of State tax or Commissioner of Union Territory Tax or an authority designated by him in this behalf.

(16) Every order passed under this section shall, subject to the provisions of section 108 or section 113 or section 117 or section 118 be final and binding on the parties.""",
      }


    },
    {
      'code': 'service_tex_appeal',
      'title_en': 'Service Tax Appeal',
      'title_hi': 'सेवा कर अपील',  
        "data":{
      "document_checklist":[ 
      {
        "id": 1,
        "hi": {
          "title":
          "फॉर्म एसटी-4, तथ्यों के विवरण और अपील के आधार के साथ",
        },
        "en": {
          "title":
          "Form ST-4 along with Statement of facts and Grounds of Appeal",
        },
        "required": true
      },
      {
        "id": 2,
        "hi": {
          "title":
          "ओआईओ (ऑर्डर-इन-ओरिजिनल) की स्व-सत्यापित प्रति कोर्ट फी�� स्टैम्प के साथ",
        },
        "en": {
          "title":
          "Self-Attested Copy of OIO (Order-in-Original) along with Court fee Stamp",
        },
        "required": true
      },
      {
        "id": 3,
        "hi": {
          "title": "कारण बताओ नोटिस (एससीएन) की स्व-सत्यापित प्रति",
        },
        "en": {
          "title": "Self-Attested Copy of Show Cause Notice (SCN)",
        },
        "required": true
      },
      {
        "id": 4,
        "hi": {
          "title":
          "अपील अवधि के बाद दायर की गई अपील में देरी के लिए माफ़ी पत्र",
        },
        "en": {
          "title":
          "Letter of Condonation of delay in-case appeal filed after appeal period",
        },
        "required": false
      },
      {
        "id": 5,
        "hi": {
          "title": "प्री-डिपॉज़िट की चालान कॉपी",
        },
        "en": {
          "title": "Challan Copy of Pre-Deposit",
        },
        "required": false
      },
      {
        "id": 6,
        "hi": {
          "title": "कोई अन्य प्रासंगिक दस्तावेज़",
        },
        "en": {
          "title": "Any other relevant document",
        },
        "required": false
      }
    ],
      "related_sections": "GST Appeal Related Sections",
      }


    },
    {
      'code': 'central_excise_appeal',
      'title_en': 'Central Excise Appeal',
      'title_hi': 'केंद्रीय उत्पाद शुल्क अपील',
        "data":{
      "document_checklist":[ 
      {
        "id": 1,
        "hi": {
          "title":
          "फॉर्म ईए-1, तथ्यों के विवरण और अपील के आधार के साथ",
        },
        "en": {
          "title":
          "Form EA-1 along with Statement of facts and Grounds of Appeal",
        },
        "required": true
      },
      {
        "id": 2,
        "hi": {
          "title":
          "ओआईओ (ऑर्डर-इन-ओरिजिनल) की स्व-सत्यापित प्रति कोर्ट फी�� स्टैम्प के साथ",
        },
        "en": {
          "title":
          "Self-Attested Copy of OIO (Order-in-Original) along with Court fee Stamp",
        },
        "required": true
      },
      {
        "id": 3,
        "hi": {
          "title": "कारण बताओ नोटिस (एससीएन) की स्व-सत्यापित प्रति",
        },
        "en": {
          "title": "Self-Attested Copy of Show Cause Notice (SCN)",
        },
        "required": true
      },
      {
        "id": 4,
        "hi": {
          "title":
          "अपील अवधि के बाद दायर की गई अपील में देरी के लिए माफ़ी पत्र",
        },
        "en": {
          "title":
          "Letter of Condonation of delay in-case appeal filed after appeal period",
        },
        "required": false
      },
      {
        "id": 5,
        "hi": {
          "title": "प्री-डिपॉज़िट की चालान कॉपी",
        },
        "en": {
          "title": "Challan Copy of Pre-Deposit",
        },
        "required": false
      },
      {
        "id": 6,
        "hi": {
          "title": "कोई अन्य प्रासंगिक दस्तावेज़",
        },
        "en": {
          "title": "Any other relevant document",
        },
        "required": false
      }
    ],
      "related_sections": "GST Appeal Related Sections",
      }


    },
    {
      'code': 'customs_appeal',
      'title_en': 'Customs Appeal',
      'title_hi': 'सीमा शुल्क अपील',
       "data":{
      "document_checklist":[ 
      {
        "id": 1,
        "hi": {
          "title":
          "फॉर्म सीए-1, तथ्यों के विवरण और अपील के आधार के साथ",
        },
        "en": {
          "title":
          "Form CA-1 along with Statement of facts and Grounds of Appeal",
        },
        "required": true
      },
      {
        "id": 2,
        "hi": {
          "title":
          "ओआईओ (ऑर्डर-इन-ओरिजिनल) की स्व-सत्यापित प्रति कोर्ट फी�� स्टैम्प के साथ",
        },
        "en": {
          "title":
          "Self-Attested Copy of OIO (Order-in-Original) along with Court fee Stamp",
        },
        "required": true
      },
      {
        "id": 3,
        "hi": {
          "title": "कारण बताओ नोटिस (एससीएन) की स्व-सत्यापित प्रति",
        },
        "en": {
          "title": "Self-Attested Copy of Show Cause Notice (SCN)",
        },
        "required": true
      },
      {
        "id": 4,
        "hi": {
          "title":
          "अपील अवधि के बाद दायर की गई अपील में देरी के लिए माफ़ी पत्र",
        },
        "en": {
          "title":
          "Letter of Condonation of delay in-case appeal filed after appeal period",
        },
        "required": false
      },
      {
        "id": 5,
        "hi": {
          "title": "प्री-डिपॉज़िट की चालान कॉपी",
        },
        "en": {
          "title": "Challan Copy of Pre-Deposit",
        },
        "required": false
      },
      {
        "id": 6,
        "hi": {
          "title": "कोई अन्य प्रासंगिक दस्तावेज़",
        },
        "en": {
          "title": "Any other relevant document",
        },
        "required": false
      }
    ],
      "related_sections": "GST Appeal Related Sections",
      }


    }
  ];

  @override
  Widget build(BuildContext context) {
    return AppWidget( subHeading:languageId == "hi" ? 'अपील प्रकार चुनें' : 'Select Appeal Type', onPressed: selectedAppealType != null
            ? () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>  AppealDetailsInfoPage( appealType: appealTypes.firstWhere((type) => type['code'] == selectedAppealType)["data"] as Map<String, dynamic> ),
          ),
                );
              }
            : null, children: [  ...appealTypes.map((type) => CustomSelectionTile(
                            title: ( type['title_$languageId'] as String ),

                            isSelected: selectedAppealType == type['code'],
                            onTap: () {
                              setState(() {
                                selectedAppealType = type['code'] as String;
                              });
                            },
                            width: MediaQuery.of(context).size.width / 2,
                          ))]);
  }

  
}






