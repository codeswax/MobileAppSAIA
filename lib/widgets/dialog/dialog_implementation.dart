import 'package:flutter/material.dart';

import 'package:saia_mobile_app/widgets/dialog/dialog_interface.dart';

class DialogImplementation implements DialogService {
  @override
  Future<void> showExceptionDialog(
      BuildContext context, String exceptionMessage) async {
    if (!context.mounted) return;
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text(
                'ERROR',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              content: Text(
                exceptionMessage,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: Text(
                    'OK',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ));
  }

  @override
  Future<void> showCompletionDialog(
      BuildContext context, String exceptionMessage) async {
    if (!context.mounted) return;
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text(
                'AVISO',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              content: Text(
                exceptionMessage,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: Text(
                    'OK',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ));
  }
}
