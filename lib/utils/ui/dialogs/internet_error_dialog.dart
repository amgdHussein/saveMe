import 'package:flutter/material.dart';

void showErrorNetworkDialog(context) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      contentPadding: EdgeInsets.all(0.0),
      title: Text('Error'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Container(
              child: Text('An unknown network error has cccurred.'),
              padding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
            ),
            Divider(height: 0),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: MaterialButton(
                child: Text("Dismiss"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
