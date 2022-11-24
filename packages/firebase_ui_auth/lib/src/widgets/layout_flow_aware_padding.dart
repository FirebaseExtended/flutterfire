import 'package:flutter/widgets.dart';

class LayoutFlowAwarePadding extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  const LayoutFlowAwarePadding({
    Key? key,
    required this.child,
    required this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Axis? axis;

    context.visitAncestorElements((element) {
      if (element.widget is Row) {
        axis = Axis.horizontal;
        return false;
      } else if (element.widget is Column) {
        axis = Axis.vertical;
        return false;
      } else if (element.widget is Flex) {
        axis = (element.widget as Flex).direction;
        return false;
      }

      return true;
    });

    EdgeInsets finalPadding;

    if (axis == null) {
      finalPadding = padding;
    } else if (axis == Axis.horizontal) {
      finalPadding = EdgeInsets.only(
        left: padding.left,
        right: padding.right,
      );
    } else {
      finalPadding = EdgeInsets.only(
        top: padding.top,
        bottom: padding.bottom,
      );
    }

    return Padding(
      padding: finalPadding,
      child: child,
    );
  }
}
