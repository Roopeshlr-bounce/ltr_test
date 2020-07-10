import 'package:flutter/material.dart';
import 'package:web_test/single_tap_gesture_widget.dart';

/// Show Bottomsheet
Future<T> showDismissableBottomsheet<T>(
    {BuildContext context, bool dissmisable, bool isScrollControlled = true, Widget child}) async {
  return showModalBottomSheet(
    useRootNavigator: true,
    isScrollControlled: isScrollControlled,
    context: context,
    builder: (context) => DismissableBottomSheet(
      dissmisable: dissmisable,
      child: child,
    ),
  );
}

/// Dismissable Bottomsheet
class DismissableBottomSheet extends StatelessWidget {
  /// Constructor
  const DismissableBottomSheet({Key key, this.dissmisable, this.child, this.onDismiss})
      : super(key: key);

  /// Dismissiable
  final bool dissmisable;

  /// Widget to be displayed
  final Widget child;

  final Function onDismiss;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: dissmisable
                ? SingleTapGestureDetector(
                    onTap: () {
                      if (onDismiss != null) onDismiss();
                      return Navigator.pop(context, false);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Container(
//                        child:
//                            SvgPicture.asset(BounceSvgIcons.close),
                      ),
                    ),
                  )
                : Container(),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Material(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                ),
              ),
              child: child,
            ),
          )
        ],
      );
}
