import 'package:flutter/material.dart';

Widget singInFailureSnackBar() => SnackBar(
      backgroundColor: Colors.red[900],
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Sign-in Failure"),
          Icon(Icons.error_outline_sharp, color: Colors.white),
        ],
      ),
    );