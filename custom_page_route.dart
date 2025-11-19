// lib/utils/custom_page_route.dart
import 'package:flutter/material.dart';

enum SlideDirection {
  left,
  right,
  up,
  down,
}

class CustomPageRoute extends PageRouteBuilder {
  final Widget child;
  final SlideDirection direction;
  @override
  final Duration transitionDuration;

  CustomPageRoute({
    required this.child,
    this.direction = SlideDirection.right,
    this.transitionDuration = const Duration(milliseconds: 400),
  }) : super(
          transitionDuration: transitionDuration,
          pageBuilder: (context, animation, secondaryAnimation) => child,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            Offset beginOffset;
            switch (direction) {
              case SlideDirection.left:
                beginOffset = const Offset(1.0, 0.0);
                break;
              case SlideDirection.right:
                beginOffset = const Offset(-1.0, 0.0);
                break;
              case SlideDirection.up:
                beginOffset = const Offset(0.0, 1.0);
                break;
              case SlideDirection.down:
                beginOffset = const Offset(0.0, -1.0);
                break;
            }

            return SlideTransition(
              position: Tween<Offset>(
                begin: beginOffset,
                end: Offset.zero,
              ).animate(animation),
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        );
}