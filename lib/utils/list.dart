import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:quotes_db_miner/utils/app_color.dart';

int index = 0;

List<String> images = [
  //Popular
  "assets/images/popular/1.jpg",
  "assets/images/popular/2.jpg",
  "assets/images/popular/3.jpg",
  "assets/images/popular/4.jpg",
  "assets/images/popular/5.jpg",
];

List<Map<String,dynamic>> popular = [
  {
    "image": "assets/images/popular/p1.jpg",
    "name": "Love",
    "json": "assets/json/quotes_file.json",
  },
  {
    "image": "assets/images/popular/p2.jpg",
    "name": "Family",
    "json": "assets/json/quotes_file.json",
  },
  {
    "image": "assets/images/popular/p3.jpg",
    "name": "Friendship",
    "json": "assets/json/quotes_file.json",
  },
  {
    "image": "assets/images/popular/p4.jpg",
    "name": "Mom",
    "json": "assets/json/quotes_file.json",
  },
  {
    "image": "assets/images/popular/p5.jpg",
    "name": "Work",
    "json": "assets/json/quotes_file.json",
  },
];

List<Color> containerColor = [
  MyColor.red,
  MyColor.blue,
  MyColor.green,
  MyColor.orange,
  MyColor.purple,
  MyColor.pink,
  MyColor.cyan,
  MyColor.yellow,

];