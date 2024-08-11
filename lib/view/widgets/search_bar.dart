import 'package:flutter/material.dart';

Widget searchBarWidget() {
  return TextField(
    decoration: InputDecoration(
      hintText: 'Search Here',
      hintStyle: const TextStyle(
        fontSize: 14,
        color: Colors.grey,
        fontWeight: FontWeight.normal,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(
          color: Colors.black,
          width: 1.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(
          color: Colors.black,
          width: 1.0,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(
          color: Colors.black,
          width: 1.0,
        ),
      ),
      suffixIcon: const Icon(
        Icons.search,
        color: Colors.grey,
      ),
      filled: true,
      fillColor: Colors.white,
    ),
  );
}
