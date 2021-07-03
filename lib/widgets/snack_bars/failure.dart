import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget FailureSnackBar({@required String error}) => SnackBar(
      backgroundColor: Colors.red[900],
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            error,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 11),
          ),
          Icon(Icons.error_outline_sharp, color: Colors.white),
        ],
      ),
    );
