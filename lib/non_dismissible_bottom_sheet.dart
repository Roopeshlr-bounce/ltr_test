import 'package:flutter/material.dart';
import 'package:web_test/custom_bottom_sheet.dart';
import 'package:web_test/single_tap_gesture_widget.dart';

bool closethesheet = false;
//BottomSheetBloc _counterBloc;

/// Show Bottomsheet
Future<T> showNonDismissableBottomsheet<T>(
    {@required BuildContext context,
    bool dissmisable,
    Widget child,
    bool isScrollControlled = true}) async {
  return showCustomModalBottomSheet(
      useRootNavigator: true,
      isScrollControlled: isScrollControlled,
      context: context,
      builder: (context) =>
          // BlocProvider(
          //   bloc: BottomSheetBloc(),
          //   child:
          NonDismissableBottomSheet(
            dissmisable: dissmisable,
            child: child,
            //   ),
            // ),
          ));
}

closeTheNonDissmisableBottomSheet({BuildContext closeContext}) {
  if (Navigator.canPop(closeContext)) Navigator.pop(closeContext);
  // _counterBloc.activatesink.add(false);
}

/// Dismissable Bottomsheet
class NonDismissableBottomSheet extends StatelessWidget {
  /// Constructor
  const NonDismissableBottomSheet({Key key, this.dissmisable, this.child}) : super(key: key);

  /// Dismissiable
  final bool dissmisable;

  /// Widget to be displayed
  final Widget child;

  @override
  Widget build(BuildContext context) {
    //  _counterBloc = BlocProvider.of<BottomSheetBloc>(context);

    // return StreamBuilder<bool>(
    //     initialData: true,
    //     stream: _counterBloc.outActivatestream,
    //     builder: (context, AsyncSnapshot<bool> snapshot) {
    //       if (snapshot.hasData) {
    //         debugPrint('statement  ${snapshot.data}');
    //         if (!snapshot.data)
    //           Future.delayed(const Duration(seconds: 1), () {
    //             myCallback(() {
    //               Navigator.pop(context, true);
    //             });
    //           });
    //       }
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
            alignment: Alignment.topLeft,
            child: dissmisable
                ? SingleTapGestureDetector(
                    onTap: () => Navigator.pop(context, false),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Container(
//                        child:
//                            SvgPicture.asset('packages/bounce_ui_flutter/asset_res/svg/close.svg'),
                      ),
                    ),
                  )
                : Container()),
        Container(
          alignment: Alignment.bottomCenter,
          child: Material(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(18),
              ),
            ),
            child: child,
          ),
        )
      ],
    );
    // });
  }
}

void myCallback(Function callback) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    callback();
  });
}
