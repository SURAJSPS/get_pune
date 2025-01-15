import 'package:flutter/material.dart';
import 'package:pune_gst/widgets/custom_app_bar.dart';
import 'package:pune_gst/widgets/custom_button.dart';
import 'package:marquee/marquee.dart';

class AppWidget extends StatelessWidget {
  final bool showDisclaimer;
  final String? heading;
  final bool? isAppBar;
  final bool? isFullWidth;
  final bool? isEnable;
  final String subHeading;
  final String? cardHeading;
  final String? cardSubHeading;
  final List<Widget> children;
  final Function()? onPressed;
  final String? appName;
  const AppWidget(
      {super.key,
      this.heading,
      this.isAppBar = true,
      this.isEnable = true,
      this.isFullWidth = false,
      this.showDisclaimer = false,
      required this.subHeading,
      this.cardHeading,
      this.cardSubHeading,
      required this.children,
      this.onPressed,
      this.appName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isAppBar == true
          ? CustomAppBar(titleKey: heading ?? '${DateTime.now()}')
          : null,
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade50, Colors.white],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: .0, vertical: 0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    SizedBox(
                      height: 120,
                      width: 120,
                      child: TweenAnimationBuilder(
                        tween: Tween<double>(begin: 0, end: 1),
                        duration: const Duration(milliseconds: 800),
                        builder: (context, double value, child) {
                          return Transform.scale(
                            scale: value,
                            child: Image.asset(
                              "assets/images/logo.png",
                              fit: BoxFit.fill,
                              // height: 200,
                              // width: 200,
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20),

                    if (appName != null) ...[
                      ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [
                            Color(0xFFFF9933),
                            Color(0xFFFFFFFF),
                            Color(0xFF138808)
                          ],
                        ).createShader(bounds),
                        child: Text(
                          appName!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Noto Sans",
                            fontSize: 64,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 3.0,
                                color: Colors.black.withOpacity(0.3),
                              ),
                            ],
                          ),
                        ),
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          children: _buildVidhaaTextSpans(),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],

                    Container(
                      width: isFullWidth == true
                          ? MediaQuery.of(context).size.width
                          : MediaQuery.of(context).size.width / 2,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: ShaderMask(
                                shaderCallback: (bounds) =>
                                    const LinearGradient(
                                  colors: [Colors.blue, Colors.purple],
                                ).createShader(bounds),
                                child: Text(
                                  subHeading,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            if (cardSubHeading != null) ...[
                              Center(
                                child: Text(
                                  cardSubHeading!,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                            ],
                            ...children,
                            const SizedBox(height: 20),
                            if (isEnable == true) ...[
                              Center(
                                child: CustomButton(
                                  text: languageId == "hi"
                                      ? 'जारी रखें'
                                      : 'Continue',
                                  textHindi: 'जारी रखें',
                                  isEnabled: onPressed != null,
                                  onPressed: onPressed ?? () {},
                                ),
                              ),
                            ]
                          ],
                        ),
                      ),
                    ),
                    if (heading != null) ...[
                      SizedBox(height: 40),
                      ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [Colors.blue, Colors.black, Colors.purple],
                        ).createShader(bounds),
                        child: Text(
                          heading!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: appName == null ? 40 : 10,
                      ),
                    ],
                    if (showDisclaimer == true) ...[
                      SizedBox(height: 40),
                      Text(
                        'Conceptualized & Guided by - Shri Dinesh Bhoyar (Commissioner) & Shri Rahul Gawande (Additional Commissioner),\n Designed & Developed By - Shri Pramod Kumar Kushwaha (Superintendent)',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Container(
                          height: 30,
                          child: Marquee(
                            text: languageId == "hi"
                                ? 'अस्वीकरण: यह पोर्टल केवल सूचनात्मक उद्देश्यों के लिए है। विवरण के लिए कृपया संबंधित अधिनियम और नियम देखें।'
                                : 'Disclaimer: This portal is for information purposes only. Please refer to the relevant Act and Rules for details.',
                            style: TextStyle(color: Colors.red, fontSize: 16),
                            scrollAxis: Axis.horizontal,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            blankSpace: 50.0,
                            velocity: 50.0,
                            pauseAfterRound: Duration(seconds: 1),
                            startPadding: 10.0,
                            accelerationDuration: Duration(seconds: 1),
                            accelerationCurve: Curves.linear,
                            decelerationDuration: Duration(milliseconds: 500),
                            decelerationCurve: Curves.easeOut,
                          ),
                        ),
                      ),
                      
                    
                    ],
                    
                   
                   
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<TextSpan> _buildVidhaaTextSpans() {
    final highlightStyle = TextStyle(
      color: Colors.indigo.shade600.withOpacity(.9),
      fontWeight: FontWeight.bold,
      fontSize: 24,
    );

    final bracketStyle = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 24,
    );

    final Map<String, bool> text = {
      '(': false,
      'V': true,
      'irtual ': false,
      'I': true,
      'nteractive ': false,
      'D': true,
      'esk for ': false,
      'H': true,
      'elping & ': false,
      'A1': true,
      'ssisting ': false,
      'A2': true,
      'll ': false,
      'N': true,
      'avigation': false,
      ')': false,
    };

    return text.entries.map((entry) {
      return TextSpan(
        text: entry.key.startsWith('A') ? 'A' : entry.key,
        style: entry.value
            ? highlightStyle
            : entry.key == '(' || entry.key == ')'
                ? bracketStyle
                : null,
      );
    }).toList();
  }
}
