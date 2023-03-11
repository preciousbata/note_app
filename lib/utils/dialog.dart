import 'package:flutter/material.dart';

Future<bool?> showConfirmationDialog(
    BuildContext context, String action) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Do you want to $action this note?'),
        actions: [
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                child: const Text('Yes'),
                onPressed: () {
                  Navigator.pop(context,
                      true); // showDialog() returns true
                },
              ),
              TextButton(
                child: const Text('No'),
                onPressed: () {
                  Navigator.pop(context,
                      false); // showDialog() returns false
                },
              ),
            ],
          )
        ],
      );
    },
  );
}
