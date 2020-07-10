import 'package:common_ui/module/service_locator.dart';
import 'package:common_ui/navigation/bottom_sheet_service.dart';
import 'package:flutter/material.dart';
import 'package:web_test/dismisable_bottom_sheet.dart';
import 'package:web_test/non_dismissible_bottom_sheet.dart';

//dummy comment

class BottomSheetManager extends StatefulWidget {
  final Widget child;
  BottomSheetManager({this.child});
  @override
  _BottomSheetManagerState createState() => _BottomSheetManagerState();
}

class _BottomSheetManagerState extends State<BottomSheetManager> {
  BottomSheetService _bottomSheetService = locator<BottomSheetService>();
  @override
  void initState() {
    super.initState();
    _bottomSheetService.registerBottomSheetListener(
        _showDismissibleBottomSheet,
        _showNonDismissibleBottomSheet,
        _closeBottomSheet,
        _closeAllOpenBottomSheets);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.child,
    );
  }

  void _showDismissibleBottomSheet(
      Widget child, bool dismissible, bool isScrollControlled) async {
    _bottomSheetService.sheetOpened();
    dynamic result = await showDismissableBottomsheet(
        context: context,
        dissmisable: dismissible,
        child: child,
        isScrollControlled: isScrollControlled);

    ///This will execute when bottom sheet is closed
    _bottomSheetService.sheetClosed(result);
    _bottomSheetService.resetCompleter();
    _bottomSheetService.bottomSheetComplete(isSheetOpened: result);
  }

  void _showNonDismissibleBottomSheet(
      Widget child, bool dismissible, bool isScrollControlled) async {
    _bottomSheetService.sheetOpened();
    dynamic result = await showNonDismissableBottomsheet(
        context: context,
        dissmisable: dismissible,
        child: child,
        isScrollControlled: isScrollControlled);

    ///This will execute when bottom sheet is closed
    _bottomSheetService.sheetClosed(result);
    _bottomSheetService.resetCompleter();
    _bottomSheetService.bottomSheetComplete(isSheetOpened: result);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _closeBottomSheet() async {
    _bottomSheetService.bottomSheetComplete(isSheetOpened: false);
    if (Navigator.canPop(context)) {
      ///@NS
      ///Don't remove this,
      ///With this line it won't crash, even 1ms delay is enough.
      ///
      ///Caution: Removing this will cause the crash, from AnimationController.
      ///Crash Log:
      /// ======================
      /// "The following assertion was thrown while notifying status listeners for AnimationController:
      /// setState() or markNeedsBuild() called during build."
      /// ======================
      await Future.delayed(Duration(milliseconds: 1));
      Navigator.pop(context, false);
      _bottomSheetService.sheetClosed(false);
    }
  }

  void _closeAllOpenBottomSheets() {
    if (Navigator.canPop(context)) {
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }
}