import 'package:flutter/material.dart';

Widget FailureSnackBar({@required String error}) => SnackBar(
      backgroundColor: Colors.red[900],
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(error),
          Icon(Icons.error_outline_sharp, color: Colors.white),
        ],
      ),
    );
