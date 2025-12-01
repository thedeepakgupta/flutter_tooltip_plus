/*
 * Created by Deepak Gupta on 28/11/2025
 * Copyright (c) 2025 . All rights reserved.
 */
import 'dart:async';
import 'package:flutter/material.dart';
import 'tooltip_arrow.dart';

/// A customizable tooltip widget for displaying contextual information
/// over any child widget with smooth animations and flexible positioning.
class FlutterTooltip extends StatefulWidget {
  /// The widget displayed inside the tooltip (main content)
  final Widget content;

  /// The widget that triggers the tooltip when interacted with
  final Widget child;

  /// Background color of the tooltip
  final Color? background;

  /// Border radius for rounding the tooltip corners
  final BorderRadius? borderRadius;

  /// Internal spacing around the tooltip content
  final EdgeInsets padding;

  const FlutterTooltip({
    super.key,
    required this.child,
    required this.content,
    this.background,
    this.borderRadius,
    this.padding = const EdgeInsets.all(10),
  });

  @override
  State<StatefulWidget> createState() => FlutterTooltipState();
}

class FlutterTooltipState extends State<FlutterTooltip> with SingleTickerProviderStateMixin {
  /// Controls the tooltip overlay insertion and removal.
  final _overlayController = OverlayPortalController();

  /// Manages tooltip opening/closing animation timing.
  late final AnimationController _animationController = AnimationController(
    duration: const Duration(milliseconds: 200),
    vsync: this,
  );

  /// Adds a smooth scale animation when showing the tooltip.
  late final Animation<double> _scaleAnimation = CurvedAnimation(
    parent: _animationController,
    curve: Curves.easeOutBack,
  );

  /// Distance from the top of the screen where tooltip should appear.
  late double? _tooltipTop;

  /// Distance from the bottom of the screen where tooltip should appear.
  late double? _tooltipBottom;

  /// Alignment of tooltip box relative to target widget.
  late Alignment _tooltipAlignment;

  /// Alignment used for scale animation origin.
  late Alignment _transitionAlignment;

  /// Alignment used for positioning the arrow indicator.
  late Alignment _arrowAlignment;

  /// Whether tooltip is displayed inverted (above instead of below target).
  bool _isInverted = false;

  /// Timer used to delay tooltip display.
  Timer? _delayTimer;

  /// Size of the tooltip arrow indicator.
  final _arrowSize = const Size(14.0, 12.0);

  /// Minimum height constraint for the tooltip widget.
  final _tooltipMinimumHeight = 140;

  /// Shows or hides the tooltip overlay with animation.
  void _toggle() {
    _delayTimer?.cancel();
    _animationController.stop();
    if (_overlayController.isShowing) {
      _animationController.reverse().then((_) {
        _overlayController.hide();
      });
    } else {
      _updatePosition();
      _overlayController.show();
      _animationController.forward();
    }
  }

  void _updatePosition() {
    final Size contextSize = MediaQuery.of(context).size;

    final targetRenderBox = context.findRenderObject() as RenderBox;
    final targetOffset = targetRenderBox.localToGlobal(Offset.zero);
    final targetSize = targetRenderBox.size;

    final tooltipFitsAboveTarget = targetOffset.dy - _tooltipMinimumHeight >= 0;
    final tooltipFitsBelowTarget = targetOffset.dy + targetSize.height + _tooltipMinimumHeight <= contextSize.height;
    _tooltipTop = tooltipFitsAboveTarget
        ? null
        : tooltipFitsBelowTarget
        ? targetOffset.dy + targetSize.height
        : null;
    _tooltipBottom = tooltipFitsAboveTarget
        ? contextSize.height - targetOffset.dy
        : tooltipFitsBelowTarget
        ? null
        : targetOffset.dy + targetSize.height / 2;

    _isInverted = _tooltipTop != null;

    _tooltipAlignment = Alignment(
      (targetOffset.dx) / (contextSize.width - targetSize.width) * 2 - 1.0,
      _isInverted ? 1.0 : -1.0,
    );

    _transitionAlignment = Alignment(
      (targetOffset.dx + targetSize.width / 2) / contextSize.width * 2 - 1.0,
      _isInverted ? -1.0 : 1.0,
    );

    _arrowAlignment = Alignment(
      (targetOffset.dx + targetSize.width / 2) / (contextSize.width - _arrowSize.width) * 2 - 1.0,
      _isInverted ? 1.0 : -1.0,
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _delayTimer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OverlayPortal(
      controller: _overlayController,
      child: GestureDetector(onTap: _toggle, child: widget.child),
      overlayChildBuilder: (context) {
        return Positioned(
          top: _tooltipTop,
          bottom: _tooltipBottom,
          child: ScaleTransition(
            alignment: _transitionAlignment,
            scale: _scaleAnimation,
            child: TapRegion(
              onTapOutside: (_) {
                _toggle();
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_isInverted)
                      Align(
                        alignment: _arrowAlignment,
                        child: TooltipArrow(
                          size: _arrowSize,
                          isInverted: true,
                          color: widget.background ?? Colors.black,
                        ),
                      ),
                    Align(
                      alignment: _tooltipAlignment,
                      child: IntrinsicWidth(
                        child: Material(
                          elevation: 4.0,
                          color: widget.background ?? Colors.black,
                          borderRadius: widget.borderRadius ?? BorderRadius.circular(8.0),
                          child: Padding(padding: widget.padding, child: widget.content),
                        ),
                      ),
                    ),
                    if (!_isInverted)
                      Align(
                        alignment: _arrowAlignment,
                        child: TooltipArrow(
                          size: _arrowSize,
                          isInverted: false,
                          color: widget.background ?? Colors.black,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
