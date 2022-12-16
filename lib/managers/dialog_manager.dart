import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../locator.dart';
import '../models/dialog_models.dart';
import '../services/dialog_service.dart';

class DialogManager extends StatefulWidget {
  final Widget ?child;
  DialogManager({Key ?key, this.child}) : super(key: key);

  _DialogManagerState createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  final DialogService _dialogService = locator<DialogService>();

  @override
  void initState() {
    super.initState();
    _dialogService.registerDialogListener(_showDialog);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child!;
  }

  void _showDialog(DialogRequest request) {
    var isConfirmationDialog = request.cancelTitle != null;
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(request.title!),
              content: Text(request.description!),
              actions: <Widget>[
                if (isConfirmationDialog)
                  AppButton(
                    child: Text(request.cancelTitle!),
                    onTap: () {
                      _dialogService.dialogComplete(DialogResponse(confirmed: false));
                    },
                  ),
                AppButton(
                  child: Text(request.buttonTitle!),
                  onTap: () {
                    _dialogService
                        .dialogComplete(DialogResponse(confirmed: true));
                  },
                ),
              ],
            ));
  }
}
