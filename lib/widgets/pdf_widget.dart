import 'package:flutter/material.dart';
import 'package:pune_gst/widgets/custom_app_bar.dart';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFWidget extends StatelessWidget {
  final String path;
  const PDFWidget({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleKey: 'PDF Viewer',
        showHomeButton: false,
      ),
      body: SfPdfViewer.asset(path),
    );
  }
}
