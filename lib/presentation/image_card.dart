import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageCard extends StatefulWidget {
  final String address;
  const ImageCard({super.key, required this.address});

  @override
  State<ImageCard> createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  String? deviceName;
  bool isLoading = true;

  @override
  void initState() {
    _getDeviceLocation();

    super.initState();
  }

  _getDeviceLocation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    deviceName = prefs.getString('device_name');
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return isLoading
        ? SizedBox()
        : Stack(
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
                top: 85,
                left: 45,
                // top: size.height * 0.20,
                // left: size.width * 0.25,
                // right: size.width * 0.25,
                // bottom: size.height * 0.20,
                child: Container(
                  height: size.height * 0.12,
                  width: size.width * 0.385,
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
//  List<String> deviceNames = [
//       'A Wing',
//       'B Wing',
//       'C Wing',
//       'D Wing',
//       'E Wing',
//       'F Wing'
//     ];

                      _buildContainer(size,
                          location: deviceName == 'A Wing' ? true : false,
                          destination:
                              widget.address.contains('A Wing') ? true : false),
                      _buildContainer(size,
                          location: deviceName == 'B Wing' ? true : false,
                          destination:
                              widget.address.contains('B Wing') ? true : false),
                      _buildContainer(size,
                          location: deviceName == 'C Wing' ? true : false,
                          destination: (widget.address.contains('C Wing'))
                              ? true
                              : false),
                      _buildContainer(size,
                          location: deviceName == 'D Wing' ? true : false,
                          destination:
                              widget.address.contains('D Wing') ? true : false),
                      _buildContainer(size,
                          location: deviceName == 'E Wing' ? true : false,
                          destination: (widget.address.contains('E Wing') ||
                                  widget.address.contains('E & F Wing'))
                              ? true
                              : false),
                      _buildContainer(size,
                          location: deviceName == 'F Wing' ? true : false,
                          destination:
                              widget.address.contains('F Wing') ? true : false),
                    ],
                  ),
                ),
              )
            ],
          );
  }

  Widget _buildIconWithLabel(
      IconData icon, Color color, String label, bool isDit) {
    return Column(
      mainAxisAlignment:
          isDit ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        _GrowingIcon(icon: icon, color: color),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
        fontSize: 10,
        color: color,
        fontWeight: FontWeight.w500,
        shadows: [
          Shadow(offset: Offset(1, 0), color: Colors.black, blurRadius: 1),
          Shadow(offset: Offset(-1, 0), color: Colors.black, blurRadius: 1),
          Shadow(offset: Offset(0, 1), color: Colors.black, blurRadius: 1),
          Shadow(offset: Offset(0, -1), color: Colors.black, blurRadius: 1),
        ],
          ),
        ),
      ],
    );
  }

  Widget _buildContainer(Size size,
      {bool location = false, bool destination = false}) {
    return Container(
      alignment: Alignment.bottomCenter,
      height: size.height * 0.12,
      width: 70,
      child: location
          ? _buildIconWithLabel(
              Icons.my_location, Colors.red, "You are here", false)
          : destination
              ? _buildIconWithLabel(
                  Icons.person_pin_circle, Colors.blue, "Destination", true)
              : null,
    );
  }
}

class _GrowingIcon extends StatefulWidget {
  final IconData icon;
  final Color color;

  const _GrowingIcon({required this.icon, required this.color});

  @override
  State<_GrowingIcon> createState() => _GrowingIconState();
}

class _GrowingIconState extends State<_GrowingIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) {
        return Transform.scale(
          scale: _animation.value,
          child: Icon(widget.icon, color: widget.color, size: 20),
        );
      },
    );
  }
}
