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
      this.onPressed});

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
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 30),
                      child: TweenAnimationBuilder(
                        tween: Tween<double>(begin: 0, end: 1),
                        duration: const Duration(milliseconds: 800),
                        builder: (context, double value, child) {
                          return Transform.scale(
                            scale: value,
                            child: Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.withOpacity(0.2),
                                    blurRadius: 20,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Image.asset(
                                  "assets/images/logo.png",
                                  height: 120,
                                  width: 120,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    if (heading != null) ...[
                      ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [Colors.blue, Colors.black, Colors.purple],
                        ).createShader(bounds),
                        child: Text(
                          heading!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
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
