import 'package:flutter/material.dart';

Widget failureSnackBar(String title) => SnackBar(
      backgroundColor: Colors.red[900],
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$title Failure"),
          Icon(Icons.error_outline_sharp, color: Colors.white),
        ],
      ),
    );