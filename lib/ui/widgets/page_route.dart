import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeroPageRoute<T> extends PageRoute<T> with MaterialRouteTransitionMixin {
  final WidgetBuilder pageBuilder;

  HeroPageRoute({this.pageBuilder});
  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.6);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return pageBuilder(context);
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return new FadeTransition(
        opacity: new CurvedAnimation(parent: animation, curve: Curves.easeOut),
        child: child);
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  bool get fullscreenDialog => true;

  @override
  String get barrierLabel => "";

  @override
  get builder => builder;
}
