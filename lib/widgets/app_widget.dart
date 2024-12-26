import 'package:flutter/material.dart';
import 'package:pune_gst/widgets/custom_app_bar.dart';
import 'package:pune_gst/widgets/custom_button.dart';

class AppWidget extends StatelessWidget {
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
                          children: [
                            TextSpan(
                              text: '(',
                              style: TextStyle(color: Colors.black),
                            ),
                            TextSpan(
                              text: 'V',
                              style: TextStyle(color: Colors.blue.shade700),
                            ),
                            const TextSpan(text: 'irtual '),
                            TextSpan(
                              text: 'I',
                              style: TextStyle(color: Colors.purple.shade700),
                            ),
                            const TextSpan(text: 'nteractive '),
                            TextSpan(
                              text: 'D',
                              style: TextStyle(color: Colors.red.shade700),
                            ),
                            const TextSpan(text: 'esk for '),
                            TextSpan(
                              text: 'A',
                              style: TextStyle(color: Colors.green.shade700),
                            ),
                            const TextSpan(text: 'ssisting '),
                            TextSpan(
                              text: 'A',
                              style: TextStyle(color: Colors.orange.shade700),
                            ),
                            const TextSpan(text: 'll '),
                            TextSpan(
                              text: 'N',
                              style: TextStyle(color: Colors.indigo.shade700),
                            ),
                            const TextSpan(text: 'avigation'),
                            TextSpan(
                              text: ')',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
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

                    // Footer
                    const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        '©2024 Your Company Name. All rights reserved.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
