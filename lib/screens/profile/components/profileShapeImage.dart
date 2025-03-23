import 'package:flutter/material.dart';

profileImage() {
  return Container(
    child: const CircleAvatar(
      radius: 50,
      backgroundColor: Colors.blue,
      child: Icon(
        Icons.person,
        size: 70,
        color: Colors.white,
      ),
    ),
  );
}