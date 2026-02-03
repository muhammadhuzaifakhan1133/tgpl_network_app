import 'package:flutter/material.dart';

deleteDialog(BuildContext context) {
  return showDialog(context: context, builder: (_) {
    return AlertDialog(
      title: const Text('Delete Confirmation'),
      content: const Text('Are you sure you want to delete this item?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false); // Return false
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true); // Return true
          },
          child: const Text('Delete'),
        ),
      ],
    );
  });
}