import 'package:flutter/material.dart';

class AnimatedNumber extends StatelessWidget {
  final num value;
  final String? prefix;
  final String? suffix;
  final int fractionDigits;
  final TextStyle? style;
  final Duration duration;

  const AnimatedNumber({
    super.key,
    required this.value,
    this.prefix,
    this.suffix,
    this.fractionDigits = 0,
    this.style,
    this.duration = const Duration(milliseconds: 1500),
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: value.toDouble()),
      duration: duration,
      curve: Curves.easeOutQuart,
      builder: (context, animatedValue, child) {
        return Text(
          '${prefix ?? ''}${animatedValue.toStringAsFixed(fractionDigits)}${suffix ?? ''}',
          style: style,
        );
      },
    );
  }
}
