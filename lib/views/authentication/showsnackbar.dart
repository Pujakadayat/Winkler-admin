

import 'package:flutter/material.dart';

showSnack(context,String title){


  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: const Color.fromARGB(255, 13, 62, 86),
    content:Text(title,
    style: TextStyle(
      fontWeight: FontWeight.bold,
    ),) ,),);
}