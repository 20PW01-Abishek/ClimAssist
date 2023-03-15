import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class SunAnimation extends StatefulWidget {
  const SunAnimation({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SunAnimationState createState() => _SunAnimationState();
}

class _SunAnimationState extends State<SunAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat(reverse: false);
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RotationTransition(
        turns: _animation,
        child: SvgPicture.asset(
          'assets/images/sunn.svg',
          height: 40,
        ),
      ),
    );
  }
}