import 'package:flutter/cupertino.dart';
import 'package:testingapp/utilities/dialogs/generic_dialog.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text
) {
  return showGenericDialog(
    context: context, 
    title: 'An error Ocurred', 
    content: text, 
    optionBuilder: () => {
      'OK': null,
    },
  );
}