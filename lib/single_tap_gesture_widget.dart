import 'package:flutter/material.dart';

class SingleTapGestureDetector extends GestureDetector {
  final Widget child;

  final Function() onTap;

  final HitTestBehavior behavior;

  SingleTapGestureDetector({
    this.onTap,
    this.child,
    this.behavior,
  }) : super(
            onTap: onTap,
            child: child,
            onDoubleTap: () {
              debugPrint('DOUBLE TAP');
            },
            behavior: behavior ?? HitTestBehavior.translucent);
}
