import 'package:flutter/material.dart';

Future<void> showEmailVerificationDialog(context) async {
  return await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      contentPadding: EdgeInsets.all(0.0),
      title: Text('Email Not verified'),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Container(
              child: Text(
                'Please, verify your email.',
              ),
              padding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
            ),
          ],
        ),
      ),
    ),
  );
}
