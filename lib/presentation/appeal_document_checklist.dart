import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:expansion_tile_group/expansion_tile_group.dart';
import 'package:flutter/material.dart';
import 'package:pune_gst/core/app_util.dart';
import 'package:pune_gst/widgets/app_widget.dart';
import 'package:pune_gst/widgets/custom_app_bar.dart';
import 'package:pune_gst/widgets/pdf_widget.dart';

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

          if (document["code"] == "flow_chart") ...[
            Image.asset(document["data"][languageId]),
          ],

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image.asset("assets/images/map_pune.jpg", fit: BoxFit.fill),
        ),
        Expanded(
          child: Column(
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
              ExpansionTileGroup(
                toggleType: ToggleType.expandOnlyCurrent,
                children: [
                  ...?document["data"]
                      .map((data) => _buildJurisdiction(data, context))
                ],
              )
            ],
          ),
        )
      ], 
    
    );
  }

  _buildJurisdiction(Map<String, dynamic> data, BuildContext context) {
    return ExpansionTileItem(
      border: Border.all(color: Colors.transparent),
      title: Text.rich(TextSpan(children: [
        TextSpan(
            text: "#",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
        TextSpan(
            text: data[languageId]["heading"],
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
      ])),
      children: [
        Text.rich(
            TextSpan(children: [
              if (data[languageId]["subtitle"] != null) ...[
               
                TextSpan(
                    text: data[languageId]["subtitle"],
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: 16, color: Colors.blueAccent))
              ]
            ]),
            textAlign: TextAlign.justify,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 18,
                )),
      ],
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            child: Image.asset("assets/images/doc.png", fit: BoxFit.fitWidth),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ...?widget.document["questions"].asMap().entries.map((entry) {
                final index = entry.key;
                final question = entry.value["question"][languageId];

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: _buildAppeal(
                      context, (index + 1).toString(), question, index),
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
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          alignment: Alignment.topLeft,
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
              return Wrap(
                children: [
                  Text(
                    animatedText,
                    // textAlign: TextAlign.justify,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 18,
                          wordSpacing: -.05,
                        ),
                  ),
                  if (AppUtil.checkPdfPath(title)) ...[
                    SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PDFWidget(path: AppUtil.pdfPath(title))));
                      },
                      child: Text(
                        AppUtil.pdfText(title, languageId),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: 12,
                              color: Colors.blue,
                              wordSpacing: -.05,
                            ),
                      ),
                    ),
                  ]
                ],
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        

        Expanded(
          child: Image.asset("assets/images/timeline.jpg", fit: BoxFit.fill),
        ),
        Expanded(
          child: Center(
            child: ExpansionTileGroup(
                spaceBetweenItem: 10,
                toggleType: ToggleType.expandOnlyCurrent,
                children: [
                  ...?document["questions"].map((question) => ExpansionTileItem(
                        expandedAlignment: Alignment.centerLeft,
                        textColor: Colors.black,
                        border: Border.all(
                          color: Colors.transparent,
                        ),
                        title: Text(
                          question[languageId]["question"],
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w400),
                        ),
                        children: [
                          Wrap(
                            children: [
                              Text(
                                question[languageId]["answer"] ?? "",
                                style: TextStyle(
                                    fontSize: 17, color: Colors.blueAccent),
                              ),
                              SizedBox(width: 10),
                              InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: Center(
                                                  child: Text(
                                                question[languageId]
                                                    ["question"],
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              content: Container(
                                                constraints: BoxConstraints(
                                                    minWidth: 300,
                                                    maxWidth: 600),
                                                child: _buildTimeline(
                                                    context, question),
                                              ),
                                            ));
                                  },
                                  child: Text("Read More...",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue)))
                            ],
                          ),
                        ],
                      ))
                ]),
          ),
        )
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
                .copyWith(fontWeight: FontWeight.bold, fontSize: 16)),
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



return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image.asset("assets/images/rules.jpg", fit: BoxFit.fill),
        ),
        Expanded(
          child: ExpansionTileGroup(
            toggleType: ToggleType.expandOnlyCurrent,
            children: [
              ...?document["questions"]
                  .map((question) => _buildTaxAppeal(context, question))
            ],
          ),
        ),
      ],
    );

    // return Wrap(
    //   spacing: 10,
    //   runSpacing: 10,
    //   children: [
    //     ...?document["questions"].map((question) => Padding(
    //           padding: const EdgeInsets.symmetric(vertical: 10.0),
    //           child: _buildTaxAppeal(context, question),
    //         ))
    //   ],
    // );
  }

  Widget _buildTaxAppeal(BuildContext context, Map<String, dynamic> question) {
    if (question[languageId] == null) return SizedBox.shrink();
    return ExpansionTileItem(
        border: Border.all(color: Colors.transparent),
        title: Text(question[languageId]["heading"],
            textAlign: TextAlign.justify,
            style: TextStyle()
                .copyWith(fontWeight: FontWeight.w900, fontSize: 20)),
        
        children: [
          
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
