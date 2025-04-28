import 'package:flutter/material.dart';

class ImageCard extends StatefulWidget {
  final String address;
  const ImageCard({super.key, required this.address});

  @override
  State<ImageCard> createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 40),
          height: size.height * 0.30,
          width: size.width * 0.5,
          // width: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Image.asset(
            "assets/images/office.jpg",
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
          top: 35,
          left: 22,
          // top: size.height * 0.20,
          // left: size.width * 0.25,
          // right: size.width * 0.25,
          // bottom: size.height * 0.20,
          child: Container(
            height: size.height * 0.12,
            width: size.width * 0.425,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: size.height * 0.12,
                  width: 67,
                  color: Colors.red.withOpacity(0.5),
                ),
                Container(
                  height: size.height * 0.12,
                  width: 67,
                  color: Colors.red.withOpacity(0.5),
                ),
                Container(
                  height: size.height * 0.12,
                  width: 67,
                  color: Colors.red.withOpacity(0.5),
                ),
                Container(
                  height: size.height * 0.12,
                  width: 67,
                  color: Colors.red.withOpacity(0.5),
                ),
                Container(
                  height: size.height * 0.12,
                  width: 67,
                  color: Colors.red.withOpacity(0.5),
                ),
                Container(
                  height: size.height * 0.12,
                  width: 67,
                  color: Colors.red.withOpacity(0.5),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
