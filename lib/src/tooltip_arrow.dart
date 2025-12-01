/*
 * Created by Deepak Gupta on 28/11/2025
 * Copyright (c) 2025 . All rights reserved.
 */

import 'package:flutter/material.dart';

class TooltipArrow extends StatelessWidget {
  final Size size;
  final Color color;
  final bool isInverted;

  const TooltipArrow({
    super.key,
    this.size = const Size(16.0, 10.0),
    this.color = Colors.white,
    this.isInverted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(-size.width / 2, 0.0),
      child: CustomPaint(
        size: size,
        painter: TooltipArrowPainter(size: size, color: color, isInverted: isInverted),
      ),
    );
  }
}

class TooltipArrowPainter extends CustomPainter {
  final Size size;
  final Color color;
  final bool isInverted;

  TooltipArrowPainter({required this.size, required this.color, required this.isInverted});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();

    final tipRadius = 2.0;

    if (isInverted) {
      /// Bottom arrow
      path.moveTo(0.0, size.height);
      path.lineTo(size.width / 2 - tipRadius, tipRadius);

      /// Rounded tip using quadratic bezier
      path.quadraticBezierTo(size.width / 2, 0.0, size.width / 2 + tipRadius, tipRadius);

      path.lineTo(size.width, size.height);
    } else {
      /// Top arrow
      path.moveTo(0.0, 0.0);
      path.lineTo(size.width / 2 - tipRadius, size.height - tipRadius);

      /// Rounded tip using quadratic bezier
      path.quadraticBezierTo(size.width / 2, size.height, size.width / 2 + tipRadius, size.height - tipRadius);

      path.lineTo(size.width, 0.0);
    }

    path.close();

    canvas.drawShadow(path, Colors.black, 2.0, false);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
