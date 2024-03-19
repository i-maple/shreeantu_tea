
import 'package:flutter/material.dart';

class HomeItemModel {
  final String title;
  final Widget icon;
  final String route;
  final Object? args;
  HomeItemModel({
    required this.title,
    required this.icon,
    required this.route,
    this.args,
  });
}