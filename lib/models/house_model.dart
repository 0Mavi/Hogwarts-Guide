import 'package:flutter/material.dart';


class House {
  final String name;
  final String founder;
  final String animal;
  final String colorsDescription;
  final String values;
  final String characteristics;
  final String famousMembers;
  final String imagePath;
  final Color primaryColor;
  final Color secondaryColor;

  const House({
    required this.name,
    required this.founder,
    required this.animal,
    required this.colorsDescription,
    required this.values,
    required this.characteristics,
    required this.famousMembers,
    required this.imagePath,
    required this.primaryColor,
    required this.secondaryColor,
  });
}
