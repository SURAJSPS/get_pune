import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:expansion_tile_group/expansion_tile_group.dart';
import 'package:flutter/material.dart';
import 'package:pune_gst/widgets/app_widget.dart';
import 'package:pune_gst/widgets/custom_app_bar.dart';

class AppealDocumentsChecklist extends StatelessWidget {
  final Map<String, dynamic> document;
  final String subHeading;

  const AppealDocumentsChecklist(
      {super.key, required this.document, required this.subHeading});

  @override
  Widget build(BuildContext context) {
    return AppWidget(
        isFullWidth: true,
        isEnable: false,
        subHeading: subHeading,
        children: [
          if (document["code"] == "jurisdiction") ...[
            JurisdictionWidget(document: document),
          ],
          if (document["code"] == "appeal") ...[
            AppealWidget(document: document),
          ],
          if (document["code"] == "faq") ...[
            FAQWidget(document: document),
          ],
          if (document["code"] == "timeline") ...[
            TimelineWidget(document: document),
          ],
          if (document["code"] == "tax_appeal") ...[
            TaxAppealWidget(document: document),
          ],
          if (document["type"] == "table") ...[
            TableWidget(document: document),
          ],
        ]);
  }
}

class TableWidget extends StatelessWidget {
  final Map<String, dynamic> document;
  const TableWidget({super.key, required this.document});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/appellate.jpg"),
            fit: BoxFit.fitWidth,
            colorFilter: ColorFilter.mode(
              Colors.white.withValues(alpha: 0.80),
              BlendMode.lighten,
            ),
          ),
        ),
        child: DataTable(
          dataTextStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          headingTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          columnSpacing: 10,
          horizontalMargin: 10,
          border: TableBorder.all(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
          columns: [
            DataColumn(label: Text(document["data"][languageId]["h3"])),
            DataColumn(label: Text(document["data"][languageId]["h1"])),
            DataColumn(label: Text(document["data"][languageId]["h2"])),
          ],
          rows: <DataRow>[
            ...document["data"][languageId]["1h"].asMap().entries.map((e) =>
                _buildDataRow((e.key + 1).toString(), e.value,
                    document["data"][languageId]["2h"][e.key])),
          ],
        ),
      ),
    );
  }

  _buildDataRow(String i, String orderPassedBy, String appellateAuthority) {
    return DataRow(cells: [
      DataCell(Center(child: Text(i))),
      _buildDataCell(orderPassedBy),
      _buildDataCell(appellateAuthority)
    ]);
  }

  _buildDataCell(String text) {
    return DataCell(Text(text));
  }
}

class JurisdictionWidget extends StatelessWidget {
  final Map<String, dynamic> document;
  const JurisdictionWidget({super.key, required this.document});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        if (document["subHeading"] != null) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text(document["subHeading"][languageId],
                textAlign: TextAlign.justify,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
        ],
        ...?document["data"].map((data) => _buildJurisdiction(data, context))
      ],
    );
  }

  _buildJurisdiction(Map<String, dynamic> data, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 20,
              child: Text("#",
                  textAlign: TextAlign.justify,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 18, fontWeight: FontWeight.bold))),
          Flexible(
              // flex: 11,
              child: Text.rich(
                  TextSpan(children: [
                    TextSpan(
                        text: data[languageId]["heading"],
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    if (data[languageId]["subtitle"] != null) ...[
                      TextSpan(
                          text: "\n",
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 18,
                                  )),
                      TextSpan(
                          text: data[languageId]["subtitle"],
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 16,
                                  ))
                    ]
                  ]),
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 18,
                      ))),
        ],
      ),
    );
  }
}

class FAQWidget extends StatefulWidget {
  final Map<String, dynamic> document;
  const FAQWidget({super.key, required this.document});

  @override
  State<FAQWidget> createState() => _FAQWidgetState();
}

class _FAQWidgetState extends State<FAQWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Image.asset("assets/images/faq.png", fit: BoxFit.fill),
        ),
        Expanded(
            child: ExpansionTileGroup(
                spaceBetweenItem: 10,
                toggleType: ToggleType.expandOnlyCurrent,
                children: [
              ...?widget.document["questions"].map((question) =>
                  ExpansionTileItem(
                    textColor: Colors.black,
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                    title: Text(
                      question["question"][languageId],
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                    children: [
                      Text(
                        question["answer"][languageId],
                        style:
                            TextStyle(fontSize: 16, color: Colors.blueAccent),
                      ),
                    ],
                  ))
            ])

            // child: Wrap(
            //   children: [
            //     ...?widget.document["questions"].map((question) => Padding(
            //           padding: const EdgeInsets.symmetric(vertical: 10.0),
            //           child: Column(
            //             mainAxisSize: MainAxisSize.min,
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //             children: [
            //               // _buildFAQ(context, question["question"][languageId],
            //               //     question["answer"][languageId]),
            //               // SizedBox(height: 5),
            //               // _buildFAQ(
            //               //     context,
            //               //     question["question"][languageId],
            //               //     question["answer"][languageId]),
            //             ],
            //           ),
            //         ))
            //   ],
            // ),
            ),
      ],
    );
  }

  // Widget _buildFAQ(BuildContext context, String question, String answer) {
  //   return ExpansionTile(
  //     dense: true,
  //     tilePadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
  //     textColor: Colors.black,
  //     backgroundColor: const Color.fromARGB(255, 251, 251, 251),
  //     childrenPadding: EdgeInsets.symmetric(horizontal: 20),
  //     shape: RoundedRectangleBorder(
  //       side: BorderSide.none,
  //     ),
  //     title: Text(question,style: TextStyle(fontSize: 14,)),
  //     children: [
  //       Text(answer,
  //           style:
  //               Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 12)),
  //     ],
  //   );

  // }
}

class AppealWidget extends StatefulWidget {
  final Map<String, dynamic> document;
  const AppealWidget({super.key, required this.document});

  @override
  State<AppealWidget> createState() => _AppealWidgetState();
}

class _AppealWidgetState extends State<AppealWidget>
    with TickerProviderStateMixin {
  // Add controller map for multiple texts
  final Map<int, AnimationController> _controllers = {};
  final Map<int, Animation<int>> _typingAnimations = {};

  @override
  void initState() {
    super.initState();
    // Initialize controllers for each text item
    widget.document["questions"].asMap().forEach((index, _) {
      _controllers[index] = AnimationController(
        duration: Duration(milliseconds: 2000),
        vsync: this,
      );
      _typingAnimations[index] = StepTween(
        begin: 0,
        end: widget.document["questions"][index]["question"][languageId].length,
      ).animate(_controllers[index]!);

      // Start animation with a delay based on index
      Future.delayed(Duration(milliseconds: 300), () {
        _controllers[index]?.forward();
      });
    });
  }

  @override
  void dispose() {
    _controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            child: Image.asset("assets/images/doc.png", fit: BoxFit.fitWidth),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ...?widget.document["questions"].asMap().entries.map((entry) {
                final index = entry.key;
                final question = entry.value["question"][languageId];

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildAppeal(
                          context, (index + 1).toString(), question, index),
                    ],
                  ),
                );
              }),
              if (widget.document["note"] != null) ...[
                SizedBox(height: 20),
                Center(
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        widget.document["note"][languageId],
                        textAlign: TextAlign.justify,
                        textStyle:
                            Theme.of(context).textTheme.bodySmall!.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                        speed: Duration(milliseconds: 50),
                      ),
                    ],
                    isRepeatingAnimation: false,
                  ),
                )
              ]
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAppeal(
      BuildContext context, String leading, String title, int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 40,
          child: Text(
            "→",
            textAlign: TextAlign.justify,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  height: 0,
                ),
          ),
        ),
        Flexible(
          child: AnimatedBuilder(
            animation: _typingAnimations[index]!,
            builder: (context, child) {
              String animatedText = title.substring(
                0,
                _typingAnimations[index]!.value,
              );
              return Text(
                animatedText,
                // textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 18,
                      wordSpacing: -.05,
                    ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class TimelineWidget extends StatelessWidget {
  final Map<String, dynamic> document;
  const TimelineWidget({super.key, required this.document});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ...?document["questions"].map((question) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              child: _buildTimeline(context, question),
            ))
      ],
    );
  }

  Widget _buildTimeline(BuildContext context, Map<String, dynamic> question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(question[languageId]["heading"],
            textAlign: TextAlign.justify,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontWeight: FontWeight.bold, fontSize: 18)),
        SizedBox(height: 15),
        Text(question[languageId]["subheading"],
            textAlign: TextAlign.justify,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontWeight: FontWeight.bold, fontSize: 18)),
        SizedBox(height: 5),
        Text(question[languageId]["body"],
            textAlign: TextAlign.justify,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontSize: 16, fontStyle: FontStyle.italic)),
      ],
    );
  }
}

class TaxAppealWidget extends StatelessWidget {
  final Map<String, dynamic> document;
  const TaxAppealWidget({super.key, required this.document});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        ...?document["questions"].map((question) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: _buildTaxAppeal(context, question),
            ))
      ],
    );
  }

  Widget _buildTaxAppeal(BuildContext context, Map<String, dynamic> question) {
    if (question[languageId] == null) return SizedBox.shrink();
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(question[languageId]["heading"],
                textAlign: TextAlign.justify,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontWeight: FontWeight.w900, fontSize: 20)),
          ),
          SizedBox(height: 10),
          if (question[languageId]["data"] != null)
            ...question[languageId]["data"].map((data) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(data["subheading"],
                        textAlign: TextAlign.justify,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(height: 5),
                    ...data["body"].map(
                      (body) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: Text(body,
                              textAlign: TextAlign.justify,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontSize: 16,
                                  ))),
                    ),
                    SizedBox(height: 5),
                    if (data["body_footer"] != null) ...[
                      ...data["body_footer"].map((footer) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            child: Text(footer,
                                textAlign: TextAlign.justify,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        fontSize: 12,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold)),
                          ))
                    ]
                  ],
                ))
        ]);
  }
}
/*
"hi": {
                      "heading": "CGST अधिनियम, 2017",
                      "data": [
                        {
                          "subheading": "धारा 107. अपीलीय प्राधिकारी के समक्ष अपीलें।-",
                          "body": [
                            "(1) इस अधिनियम या राज्य वस्तु एवं सेवा कर अधिनियम या केंद्र शासित प्रदेश वस्तु एवं सेवा कर अधिनियम के तहत किसी निर्णायक प्राधिकारी द्वारा पारित किसी निर्णय या आदेश से पीड़ित कोई भ्यक्ति, उक्त निर्णय या आदेश के उसे संप्रेषित किए जाने की तारीख से तीन महीने के भीतर, ऐसे अपीलीय प्राधिकारी के पास अपील कर सकता है जैसा कि निर्धारित किया गया हो।",
                            "(2) आयुक्त स्वयं, या राज्य कर आयुक्त या केंद्र शासित प्रदेश कर आयुक्त के अनुरोध पर, किसी भी कार्यवाही के अभिलेखों को मंगा सकते हैं जिसमें किसी निर्णायक प्राधिकारी ने इस अधिनियम या राज्य वस्तु एवं सेवा कर अधिनियम या केंद्र शासित प्रदेश वस्तु एवं सेवा कर अधिनियम के तहत कोई निर्णय या आदेश पारित किया हो, ताकि वह उक्त निर्णय या आदेश की वैधता या उपयुक्तता से स्वयं को संतुष्ट कर सकें, और अपने आदेश द्वारा अपने अधीनस्थ किसी भी अधिकारी को निर्देश दे सकते हैं कि वह उक्त निर्णय या आदेश के संप्रेषण की तारीख से छह महीने के भीतर अपीलीय प्राधिकारी के पास आवेदन करे, ताकि उक्त निर्णय या आदेश से उत्पन्न ऐसे बिंदुओं का निर्धारण किया जा सके जैसा कि आयुक्त ने अपने आदेश में निर्दिष्ट किया हो।",
                            "(3) जहां, उप-धारा (2) के तहत एक आदेश के अनुपालन में, अधिकृत अधिकारी अपीलीय प्राधिकारी के पास आवेदन करता है, तो ऐसे आवेदन को अपीलीय प्राधिकारी द्वारा ऐसे माना जाएगा मानो वह निर्णायक प्राधिकारी के निर्णय या आदेश के विरुद्ध की गई अपील हो और ऐसे अधिकृत अधिकारी को अपीलकर्ता माना जाएगा और अपीलों से संबंधित इस अधिनियम के प्रावधान ऐसे आवेदन पर लागू होंगे।",
                            "(4) अपीलीय प्राधिकारी, यदि वह संतुष्ट है कि अपीलकर्ता पर्याप्त कारणों से उक्त तीन महीने या छह महीने की अवधि के भीतर अपील प्रस्तुत करने से वंचित था, तो वह इसे आगे एक महीने की अवधि के भीतर प्रस्तुत करने की अनुमति दे सकता है।",
                            "(5) इस धारा के तहत हर अपील ऐसे प्रपत्र में होगी और ऐसे तरीके से सत्यापित की जाएगी जैसा कि निर्धारित किया गया हो।",
                            "(6) उप-धारा (1) के तहत कोई अपील तब तक दाखिल नहीं की जाएगी जब तक कि अपीलकर्ता ने भुगतान नहीं किया हो-\n\n(क) पूर्णतः, उस राशि का वह भाग जिसमें कर, ब्याज, जुर्माना, शुल्क और दंड शामिल हैं जो विवादित आदेश से उत्पन्न होते हैं, जैसा कि उसके द्वारा स्वीकार किया गया है; और\n\n(ख) शेष विवादित कर राशि का दस प्रतिशत के बराबर राशि, जो उक्त आदेश से उत्पन्न होती है,\n\n1[अधिकतम 3[बीस] करोड़ रुपये तक], जिसके संबंध में अपील दायर की गई है।\n\n2[यह भी प्रदान किया गया है कि धारा 129 की उप-धारा (3) के तहत किसी आदेश के विरुद्ध तब तक कोई अपील दाखिल नहीं की जाएगी जब तक कि अपीलकर्ता द्वारा दंड का पच्चीस प्रतिशत के बराबर राशि का भुगतान नहीं किया गया हो।]",
                            "(7) जहां अपीलकर्ता ने उप-धारा (6) के तहत राशि का भुगतान किया है, शेष राशि के लिए वसूली कार्यवाही को रुका हुआ माना जाएगा।",
                            "(8) अपीलीय प्राधिकारी अपीलकर्ता को सुनवाई का अवसर देगा।",
                            "(9) अपील की सुनवाई के किसी भी चरण में, यदि पर्याप्त कारण प्रस्तुत किया जाता है, तो अपीलीय प्राधिकारी पक्षों या उनमें से किसी एक को समय दे सकता है और लिखित में कारणों को दर्ज करके अपील की सुनवाई को स्थगित कर सकता है:\n\nप्रदान किया गया है कि अपील की सुनवाई के दौरान किसी पक्ष को तीन बार से अधिक स्थगन नहीं दिया जाएगा।",
                            "(10) अपील की सुनवाई के समय, अपीलीय प्राधिकारी अपीलकर्ता को अपील के आधारों में निर्दिष्ट नहीं किए गए किसी भी आधार को जोड़ने की अनुमति दे सकता है, यदि वह संतुष्ट है कि अपील के आधारों से उस आधार का छोड़ना जानबूझकर या अनुचित नहीं था।",
                            "(11) अपीलीय प्राधिकारी, आवश्यक होने पर ऐसी आगे की जांच के बाद, जैसा कि वह उचित समझे, आदेश पारित करेगा, जैसा कि वह न्यायसंगत और उचित समझे, अपील किए गए निर्णय या आदेश की पुष्टि, संशोधन या रद्द करते हुए, लेकिन मामले को उस निर्णायक प्राधिकारी के पास वापस नहीं भेजेगा जिसने उक्त निर्णय या आदेश पारित किया था:\n\nप्रदान किया गया है कि जुर्माना या दंड को बढ़ाने या जब्ती के बदले में अधिक मूल्य के सामानों की जब्ती करने या धनवापसी या इनपुट टैक्स क्रेडिट की राशि को कम करने वाला कोई आदेश पारित नहीं किया जाएगा जब तक कि अपीलकर्ता को प्रस्तावित आदेश के विरुद्ध कारण बताने का उचित अवसर नहीं दिया गया हो:\n\nयह भी प्रदान किया गया है कि जहाँ अपीलीय प्राधिकारी की राय है कि कोई कर भुगतान नहीं किया गया है या कम भुगतान किया गया है या गलत तरीके से वापसी की गई है, या जहाँ इनपुट टैक्स क्रेडिट को गलत तरीके से लिया या उपयोग किया गया है, तब तक अपीलकर्ता को प्रस्तावित आदेश के विरुद्ध कारण बताने का नोटिस दिए बिना और आदेश धारा 73 या धारा 74 4[या धारा 74A] में निर्दिष्ट समय सीमा के भीतर पारित किए बिना, अपीलकर्ता को ऐसा कर या इनपुट टैक्स क्रेडिट भुगतान करने की आवश्यकता वाला कोई आदेश पारित नहीं किया जाएगा।",
                            "(12) अपील का निपटान करते हुए अपीलीय प्राधिकारी का आदेश लिखित में होगा और उसमें निर्धारण के बिंदु, उन पर निर्णय और ऐसे निर्णय के कारणों का उल्लेख होगा।",
                            "(13) अपीलीय प्राधिकारी, जहाँ तक संभव हो सके, अपील दायर किए जाने की तारीख से एक वर्ष की अवधि के भीतर हर अपील की सुनवाई और निर्णय करेगा:\n\nप्रदान किया गया है कि जहाँ किसी न्यायालय या अधिकरण के आदेश से आदेश के जारी होने पर रोक लगाई गई है, तो ऐसी रोक की अवधि एक वर्ष की अवधि की गणना में शामिल नहीं होगी।",
                            "(14) अपील के निपटान पर, अपीलीय प्राधिकारी द्वारा पारित आदेश को अपीलकर्ता, प्रतिवादी और निर्णायक प्राधिकारी को संप्रेषित किया जाएगा।",
                            "(15) अपीलीय प्राधिकारी द्वारा पारित आदेश की एक प्रति क्षेत्राधिकार आयुक्त या उनके द्वारा इस संबंध में नामित प्राधिकारी और क्षेत्राधिकार राज्य कर आयुक्त या केंद्र शासित प्रदेश कर आयुक्त या उनके द्वारा इस संबंध में नामित प्राधिकारी को भी भेजी जाएगी।",
                            "(16) इस धारा के तहत पारित प्रत्येक आदेश, धारा 108 या धारा 113 या धारा 117 या धारा 118 के प्रावधानों के अधीन, पक्षों पर अंतिम और बाध्यकारी होगा।"
                          ],
                          "body_footer": [
                            "* 1 जुलाई, 2017 से प्रभावी।",
                            "1. केंद्रीय वस्तु एवं सेवा कर (संशोधन) अधिनियम, 2018 (क्रमांक 31 का 2018) की धारा 25 द्वारा समाविष्ट - 1 फरवरी, 2019 से प्रभाव में।",
                            "2. अधिसूचना सं. 39/2021-सी.टी., दिनांक 21 दिसंबर, 2021 के माध्यम से वित्त अधिनियम, 2021 (क्रमांक 13 का 2021) की धारा 116 द्वारा 1 जनवरी, 2022 से समाविष्ट।",
                            "3. वित्त (संख्या 2) अधिनियम, 2024 (क्रमांक 15 का 2024) दिनांक 16.08.2024 की धारा 141 द्वारा 'पच्चीस' के स्थान पर 'बीस' प्रतिस्थापित।",
                            "4. वित्त (संख्या 2) अधिनियम, 2024 (क्रमांक 15 का 2024) दिनांक 16.08.2024 की धारा 141 द्वारा समाविष्ट।"
                          ]
                        }
                      ]
                    }
*/
