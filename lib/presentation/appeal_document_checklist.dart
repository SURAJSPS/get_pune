import 'package:flutter/material.dart';
import 'package:pune_gst/widgets/app_widget.dart';
import 'package:pune_gst/widgets/custom_app_bar.dart';

class AppealDocumentsChecklist extends StatelessWidget {
  final Map<String, dynamic> document;
  final String subHeading;
  final int index;

  const AppealDocumentsChecklist(
      {super.key,
      required this.document,
      required this.subHeading,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return AppWidget(
        isFullWidth: true,
        isEnable: false,
        subHeading: subHeading,
        children: [
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
        ]);
  }
}

class FAQWidget extends StatelessWidget {
  final Map<String, dynamic> document;
  const FAQWidget({super.key, required this.document});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ...?document["questions"].map((question) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildFAQ(
                      context,
                      document["leading_text"][languageId]["question"],
                      question["question"][languageId]),
                  SizedBox(height: 5),
                  _buildFAQ(
                      context,
                      document["leading_text"][languageId]["answer"],
                      question["answer"][languageId]),
                ],
              ),
            ))
      ],
    );
  }

  Widget _buildFAQ(BuildContext context, String leading, String title) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            flex: 2,
            child: Text("$leading : ",
                textAlign: TextAlign.justify,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 18, fontWeight: FontWeight.bold))),
        Expanded(
            flex: 11,
            child: Text(title,
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 18,
                    ))),
      ],
    );
  }
}

class AppealWidget extends StatelessWidget {
  final Map<String, dynamic> document;
  const AppealWidget({super.key, required this.document});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [

        ...?document["questions"].asMap().entries.map((entry) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildAppeal(context, (entry.key + 1).toString(),
                      entry.value["question"][languageId]),
                ],
              ),
            )),
        if (document["note"] != null) ...[
          SizedBox(height: 20),
          Center(
            child: Text(document["note"][languageId],
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
          )
        ]
      ],
    );
  }

  Widget _buildAppeal(BuildContext context, String leading, String title) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Text("$leading :",
                textAlign: TextAlign.justify,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 18))),
        Expanded(
            flex: 14,
            child: Text(title,
                textAlign: TextAlign.justify,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontSize: 18))),
      ],
    );
  }
}

class TimelineWidget extends StatelessWidget {
  final Map<String, dynamic> document;
  const TimelineWidget({super.key, required this.document});

  @override
  Widget build(BuildContext context) {
    print(document["questions"]);
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
    print(question);
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
        ...question[languageId]["data"].map((data) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(data["subheading"],
                    textAlign: TextAlign.justify,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(height: 5),
                ...data["body"].map(
                  (body) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: Text(body,
                          textAlign: TextAlign.justify,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 16,
                                  ))),
                ),
                SizedBox(height: 5),
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
              ],
            ))
      ],
    );
  }
}
