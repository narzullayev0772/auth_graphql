import 'package:auth_graphql/src/application.dart';
import 'package:auth_graphql/src/core/locator.dart';
import 'package:flutter/material.dart';

void main() {
  // Initialize dependency injection
  initDI();

  runApp(const Application());
}
