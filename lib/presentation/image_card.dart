import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class GrowingIcon extends StatefulWidget {
  final Widget child;

  const GrowingIcon({
    super.key,
    required this.child,
  });

  @override
  State<GrowingIcon> createState() => GrowingIconState();
}

class GrowingIconState extends State<GrowingIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
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
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: widget.child,
          // child: Icon(widget.icon, color: widget.color, size: widget.size),
        );
      },
    );
  }
}

class _OutlinedText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;

  const _OutlinedText({
    required this.text,
    required this.fontSize,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 3
              ..color = Colors.black,
          ),
        ),
        Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
            color: color,
          ),
        ),
      ],
    );
  }
}

class ImageCard extends StatefulWidget {
  final String address;
  const ImageCard({super.key, required this.address});

  @override
  State<ImageCard> createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  String? _deviceName;
  bool _isLoading = true;
  final List<String> _wings = ['A', 'B', 'C', 'D', 'E', 'F'];

  @override
  void initState() {
    super.initState();
    _getDeviceLocation();
  }

  Future<void> _getDeviceLocation() async {
    final prefs = await SharedPreferences.getInstance();
    _deviceName = prefs.getString('device_name');
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const _LoadingIndicator();

    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = constraints.maxWidth * 1;
        final imageAspectRatio =
            1.5; // Adjust this to match your image aspect ratio

        return Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Image Container
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                width: cardWidth,
                height: cardWidth / imageAspectRatio,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    )
                  ],
                  image: const DecorationImage(
                    image: AssetImage("assets/images/office.jpg"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),

              // Location Markers
              _LocationMarkersOverlay(
                wings: _wings,
                deviceName: _deviceName,
                address: widget.address,
                parentWidth: cardWidth,
                imageAspectRatio: imageAspectRatio,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _LocationMarkersOverlay extends StatelessWidget {
  final List<String> wings;
  final String? deviceName;
  final String address;
  final double parentWidth;
  final double imageAspectRatio;

  const _LocationMarkersOverlay({
    required this.wings,
    required this.deviceName,
    required this.address,
    required this.parentWidth,
    required this.imageAspectRatio,
  });

  @override
  Widget build(BuildContext context) {
    final imageHeight = parentWidth / imageAspectRatio;
    final markerSize = parentWidth * 0.1;

    return SizedBox(
      width: parentWidth,
      height: imageHeight,
      child: Stack(
        children: wings.asMap().entries.map((entry) {
          final index = entry.key;
          final wing = entry.value;
          final isCurrent = deviceName == '$wing Wing';
          final isDestination = address.contains('$wing Wing') ||
              (wing == 'E' && address.contains('E & F Wing'));

          // Calculate horizontal position based on wing index
          final horizontalPosition =
              (parentWidth / (wings.length + 1.1)) * (index + 1);

          return Positioned(
            left: horizontalPosition - markerSize / 2,
            top: isCurrent ? imageHeight * 0.4 : imageHeight * 0.15,
            child: _LocationMarker(
              isCurrent: isCurrent,
              isDestination: isDestination,
              label: wing,
              size: markerSize,
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _LocationMarker extends StatelessWidget {
  final bool isCurrent;
  final bool isDestination;
  final String label;
  final double size;

  const _LocationMarker({
    required this.isCurrent,
    required this.isDestination,
    required this.label,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    if (!isCurrent && !isDestination) return const SizedBox.shrink();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GrowingIcon(
          key: ValueKey("label_$label"),

          // icon: isCurrent ? Icons.my_location : Icons.person_pin_circle,

          child: Icon(
            isCurrent ? Icons.my_location : Icons.person_pin_circle,
            color: isCurrent ? Colors.red : Colors.blue,
            size: size / 2,
          ),
        ),
        const SizedBox(height: 4),
        GrowingIcon(
          child: _OutlinedText(
            text: isCurrent ? "You are here" : "Destination",
            fontSize: size * .20,
            color: isCurrent ? Colors.red : Colors.blue,
          ),
        ),
        // Text(
        //   label,
        //   style: TextStyle(
        //     fontSize: size * 0.15,
        //     color: isCurrent ? Colors.red : Colors.blue,
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
      ],
    );
  }
}

// Keep GrowingIcon and _OutlinedText widgets from previous version
// Keep _LoadingIndicator widget from previous version
